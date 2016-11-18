unit vlc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls;

const
  iFRAME_WIDTH = 640;
  iFRAME_HEIGHT = 480;
  strVLC_REGISTRY_KEY = 'Software\VideoLAN\VLC';
  strREGISTRY_VALUE_NAME = 'InstallDir';
  strLOAD_VLC_LIBRARY_FAILED = 'Load vlc library failed';
  strSOME_FUNCTIONS_FAILED_TO_LOAD = 'Some functions failed to load : ';
  strNOT_PLAYING = 'Not playing';
  strERROR_ON_READING_REGISTRY = 'Error on reading registry';

type
  PLibVLCInstance        = type Pointer;
  PLibVLCMediaPlayer    = type Pointer;
  PLibVLCMedia           = type Pointer;

var
  LibVLCMediaNewPath              : function(p_instance : PLibVLCInstance; path : PAnsiChar) : PLibVLCMedia; cdecl;
  LibVLCMediaNewLocation          : function(p_instance : PLibVLCInstance; psz_mrl : PAnsiChar) : PLibVLCMedia; cdecl;
  LibVLCMediaPlayerNewFromMedia   : function(p_media : PLibVLCMedia) : PLibVLCMediaPlayer; cdecl;
  LibVLCMediaPlayerSetHWND        : procedure(p_media_player : PLibVLCMediaPlayer; drawable : Pointer); cdecl;
  LibVLCMediaPlayerPlay           : procedure(p_media_player : PLibVLCMediaPlayer); cdecl;
  LibVLCMediaPlayerStop           : procedure(p_media_player : PLibVLCMediaPlayer); cdecl;
  LibVLCMediaPlayerRelease        : procedure(p_media_player : PLibVLCMediaPlayer); cdecl;
  LibVLCMediaPlayerIsPlaying      : function(p_media_player : PLibVLCMediaPlayer) : Integer; cdecl;
  LibVLCMediaRelease              : procedure(p_media : PLibVLCMedia); cdecl;
  LibVLCNew                       : function(argc : Integer; argv : PAnsiChar) : PLibVLCInstance; cdecl;
  LibVLCRelease                   : procedure(p_instance : PLibVLCInstance); cdecl;
  LibVLCVideoTakeSnapshot         : procedure (p_media_player : PLibVLCMediaPlayer; num : Integer; filepath : PAnsiChar; width, height : Integer); cdecl;

  vlcLib: integer;
  vlcInstance: PLibVLCInstance;
  vlcMedia: PLibVLCMedia;
  vlcMediaPlayer: PLibVLCMediaPlayer;

  procedure LoadVLCLib;
  procedure StartDVRPlaybackAt(strURL : String; hwndDrawable : HWND);
  procedure StopDVRPlayback(p_media_player: PLibVLCMediaPlayer);
  procedure GetSnapshot(p_media_player: PLibVLCMediaPlayer; strFileName : String);

implementation

// -----------------------------------------------------------------------------
// Read registry to get VLC installation path
// -----------------------------------------------------------------------------
function GetVLCLibPath: String;
var
  Handle: HKEY;
  RegType: Integer;
  DataSize: Cardinal;
  Key: PWideChar;
begin
  Result := '';
  Key := strVLC_REGISTRY_KEY;
  if RegOpenKeyEx(HKEY_LOCAL_MACHINE, Key, 0, KEY_READ, Handle) = ERROR_SUCCESS then begin
    if RegQueryValueEx(Handle, strREGISTRY_VALUE_NAME, nil, @RegType, nil, @DataSize) = ERROR_SUCCESS then begin
      SetLength(Result, DataSize);
      RegQueryValueEx(Handle, strREGISTRY_VALUE_NAME, nil, @RegType, PByte(@Result[1]), @DataSize);
      Result[DataSize] := '\';
    end
    else ShowMessage(strERROR_ON_READING_REGISTRY);
    RegCloseKey(Handle);
    Result := String(PChar(Result));
  end;
end;

// -----------------------------------------------------------------------------
// Load libvlc library into memory
// -----------------------------------------------------------------------------
function LoadVLCLibrary(APath: string): integer;
begin
  Result := LoadLibrary(PWideChar(APath + '\libvlccore.dll'));
  Result := LoadLibrary(PWideChar(APath + '\libvlc.dll'));
end;

// -----------------------------------------------------------------------------
function GetAProcAddress(handle: integer; var addr: Pointer; procName: string; failedList: TStringList): integer;
begin
  addr := GetProcAddress(handle, PWideChar(procName));
  if Assigned(addr) then Result := 0
  else begin
    if Assigned(failedList) then failedList.Add(procName);
    Result := -1;
  end;
end;
// -----------------------------------------------------------------------------
// Get address of libvlc functions
// -----------------------------------------------------------------------------
function LoadVLCFunctions(vlcHandle: integer; failedList: TStringList): Boolean;
begin
  GetAProcAddress(vlcHandle, @LibVLCNew, 'libvlc_new', failedList);
  GetAProcAddress(vlcHandle, @LibVLCMediaNewLocation, 'libvlc_media_new_location', failedList);
  GetAProcAddress(vlcHandle, @LibVLCMediaPlayerNewFromMedia, 'libvlc_media_player_new_from_media', failedList);
  GetAProcAddress(vlcHandle, @LibVLCMediaRelease, 'libvlc_media_release', failedList);
  GetAProcAddress(vlcHandle, @LibVLCMediaPlayerSetHWND, 'libvlc_media_player_set_hwnd', failedList);
  GetAProcAddress(vlcHandle, @LibVLCMediaPlayerPlay, 'libvlc_media_player_play', failedList);
  GetAProcAddress(vlcHandle, @LibVLCMediaPlayerStop, 'libvlc_media_player_stop', failedList);
  GetAProcAddress(vlcHandle, @LibVLCMediaPlayerRelease, 'libvlc_media_player_release', failedList);
  GetAProcAddress(vlcHandle, @LibVLCRelease, 'libvlc_release', failedList);
  GetAProcAddress(vlcHandle, @LibVLCMediaPlayerIsPlaying, 'libvlc_media_player_is_playing', failedList);
  GetAProcAddress(vlcHandle, @LibVLCMediaNewPath, 'libvlc_media_new_path', failedList);
  GetAProcAddress(vlcHandle, @LibVLCVideoTakeSnapshot, 'libvlc_video_take_snapshot', failedList);
  // if all functions loaded, result is an empty list, otherwise result is a list of functions failed
  Result := failedList.Count = 0;
end;

procedure LoadVLCLib;
var
  sL: TStringList;
begin
  // load vlc library
  vlclib := LoadVLCLibrary(GetVLCLibPath());
  if vlclib = 0 then begin
    ShowMessage(strLOAD_VLC_LIBRARY_FAILED);
    Exit;
  end;
  // sL will contains list of functions fail to load
  sL := TStringList.Create;
  if not LoadVLCFunctions(vlclib, sL) then begin
    Showmessage(strSOME_FUNCTIONS_FAILED_TO_LOAD + #13#10 + sL.Text);
    FreeLibrary(vlclib);
    sL.Free;
    Exit;
  end;
  sL.Free;
end;

procedure StartDVRPlaybackAt(strURL : String; hwndDrawable : HWND);
begin
  // create new vlc instance
  vlcInstance := LibVLCNew(0, nil);
  // if you want to play from network, use libvlc_media_new_location instead
  vlcMedia := LibVLCMediaNewLocation(vlcInstance, PAnsiChar(System.UTF8Encode(strURL)));
  // create new vlc media player
  vlcMediaPlayer := LibVLCMediaPlayerNewFromMedia(vlcMedia);
  // now no need the vlc media, free it
  LibVLCMediaRelease(vlcMedia);
  // play video in hwndDrawable
  LibVLCMediaPlayerSetHWND(vlcMediaPlayer, Pointer(hwndDrawable));
  // play media
  LibVLCMediaPlayerPlay(vlcMediaPlayer);
end;

procedure StopDVRPlayback(p_media_player: PLibVLCMediaPlayer);
begin
  if not Assigned(p_media_player) then begin
    ShowMessage(strNOT_PLAYING);
    Exit;
  end;
  // stop vlc media player
  LibVLCMediaPlayerStop(p_media_player);
  // and wait until it completely stops
  while LibVLCMediaPlayerIsPlaying(p_media_player) = 1 do begin
    Sleep(100);
  end;
  // release vlc media player
  LibVLCMediaPlayerRelease(p_media_player);
  p_media_player := nil;
  // release vlc instance
  LibVLCRelease(vlcInstance);
end;

procedure GetSnapshot(p_media_player: PLibVLCMediaPlayer; strFileName : String);
begin
  LibVLCVideoTakeSnapshot(p_media_player, 0, PAnsiChar(System.UTF8Encode(strFileName)),
    iFRAME_WIDTH, iFRAME_HEIGHT);
end;


end.
