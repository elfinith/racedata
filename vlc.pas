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
  plibvlc_instance_t        = type Pointer;
  plibvlc_media_player_t    = type Pointer;
  plibvlc_media_t           = type Pointer;

var
  libvlc_media_new_path              : function(p_instance : Plibvlc_instance_t; path : PAnsiChar) : Plibvlc_media_t; cdecl;
  libvlc_media_new_location          : function(p_instance : plibvlc_instance_t; psz_mrl : PAnsiChar) : Plibvlc_media_t; cdecl;
  libvlc_media_player_new_from_media : function(p_media : Plibvlc_media_t) : Plibvlc_media_player_t; cdecl;
  libvlc_media_player_set_hwnd       : procedure(p_media_player : Plibvlc_media_player_t; drawable : Pointer); cdecl;
  libvlc_media_player_play           : procedure(p_media_player : Plibvlc_media_player_t); cdecl;
  libvlc_media_player_stop           : procedure(p_media_player : Plibvlc_media_player_t); cdecl;
  libvlc_media_player_release        : procedure(p_media_player : Plibvlc_media_player_t); cdecl;
  libvlc_media_player_is_playing     : function(p_media_player : Plibvlc_media_player_t) : Integer; cdecl;
  libvlc_media_release               : procedure(p_media : Plibvlc_media_t); cdecl;
  libvlc_new                         : function(argc : Integer; argv : PAnsiChar) : Plibvlc_instance_t; cdecl;
  libvlc_release                     : procedure(p_instance : Plibvlc_instance_t); cdecl;
  libvlc_video_take_snapshot         : procedure (p_media_player : Plibvlc_media_player_t; num : Integer; filepath : PAnsiChar; width, height : Integer); cdecl;

  vlcLib: integer;
  vlcInstance: plibvlc_instance_t;
  vlcMedia: plibvlc_media_t;
  vlcMediaPlayer: plibvlc_media_player_t;

  procedure LoadVLCLib;
  procedure StartDVRPlaybackAt(strURL : String; hwndDrawable : HWND);
  procedure StopDVRPlayback(p_media_player: plibvlc_media_player_t);
  procedure GetSnapshot(p_media_player: plibvlc_media_player_t; strFileName : String);

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
  GetAProcAddress(vlcHandle, @libvlc_new, 'libvlc_new', failedList);
  GetAProcAddress(vlcHandle, @libvlc_media_new_location, 'libvlc_media_new_location', failedList);
  GetAProcAddress(vlcHandle, @libvlc_media_player_new_from_media, 'libvlc_media_player_new_from_media', failedList);
  GetAProcAddress(vlcHandle, @libvlc_media_release, 'libvlc_media_release', failedList);
  GetAProcAddress(vlcHandle, @libvlc_media_player_set_hwnd, 'libvlc_media_player_set_hwnd', failedList);
  GetAProcAddress(vlcHandle, @libvlc_media_player_play, 'libvlc_media_player_play', failedList);
  GetAProcAddress(vlcHandle, @libvlc_media_player_stop, 'libvlc_media_player_stop', failedList);
  GetAProcAddress(vlcHandle, @libvlc_media_player_release, 'libvlc_media_player_release', failedList);
  GetAProcAddress(vlcHandle, @libvlc_release, 'libvlc_release', failedList);
  GetAProcAddress(vlcHandle, @libvlc_media_player_is_playing, 'libvlc_media_player_is_playing', failedList);
  GetAProcAddress(vlcHandle, @libvlc_media_new_path, 'libvlc_media_new_path', failedList);
  GetAProcAddress(vlcHandle, @libvlc_video_take_snapshot, 'libvlc_video_take_snapshot', failedList);
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
  vlcInstance := libvlc_new(0, nil);
  // if you want to play from network, use libvlc_media_new_location instead
  vlcMedia := libvlc_media_new_location(vlcInstance, PAnsiChar(System.UTF8Encode(strURL)));
  // create new vlc media player
  vlcMediaPlayer := libvlc_media_player_new_from_media(vlcMedia);
  // now no need the vlc media, free it
  libvlc_media_release(vlcMedia);
  // play video in hwndDrawable
  libvlc_media_player_set_hwnd(vlcMediaPlayer, Pointer(hwndDrawable));
  // play media
  libvlc_media_player_play(vlcMediaPlayer);
end;

procedure StopDVRPlayback(p_media_player: plibvlc_media_player_t);
begin
  if not Assigned(p_media_player) then begin
    ShowMessage(strNOT_PLAYING);
    Exit;
  end;
  // stop vlc media player
  libvlc_media_player_stop(p_media_player);
  // and wait until it completely stops
  while libvlc_media_player_is_playing(p_media_player) = 1 do begin
    Sleep(100);
  end;
  // release vlc media player
  libvlc_media_player_release(p_media_player);
  p_media_player := nil;
  // release vlc instance
  libvlc_release(vlcInstance);
end;

procedure GetSnapshot(p_media_player: plibvlc_media_player_t; strFileName : String);
begin
  libvlc_video_take_snapshot(p_media_player, 0, PAnsiChar(System.UTF8Encode(strFileName)),
    iFRAME_WIDTH, iFRAME_HEIGHT);
end;


end.
