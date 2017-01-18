unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, ComCtrls, ExtCtrls, sPanel,
  sButton, sListBox, sLabel, sEdit, IBDatabase, DB, IBSQL, IBQuery, sComboBox,
  sCheckListBox, sCheckBox, sScrollBar, Menus, sSkinProvider, ImgList,
  FreeButton, acTitleBar, DateUtils, SPageControl, sListView, Mask, sMaskEdit,
  sCustomComboEdit, sToolEdit, acProgressBar, IniFiles, sSplitter, FR_DSet,
  FR_Class, Math, FR_E_RTF, sDialogs, Printers, Vlc, sGroupBox, acImage, ShellAPI,
  ToolWin, sToolBar;

const
  arrDIALOG_CAPTIONS: array[0..2] of String = ('Подтверждение', 'ОК', 'Отмена');
  iBEST_LAP_FLAG = 2;
  iORDINARY_LAP_FLAG = 1;
  iPLATENUMBERS_COUNT_DEFAULT = 50;
  llDEBUG = 3;
  llERROR = 1;
  llNOLOG = 0;
  llWARNING = 2;
  strABSOLUTE = 'Абсолютный зачёт';
  strARROW_DOWN = '▼';
  strARROW_UP = '▲';
  strCOMPLETE_RACE = 'Завершить гонку и перейти к итоговой таблице?';
  strCOMP_GROUP_NOT_SELECTED = 'Не выбрана зачётная подгруппа';
  strCONFIG_FILENAME = 'config.ini';
  strDB_CONNECTION_ERROR = 'Ошибка при соединении с БД';
  strDB_FILENAME = 'DBASE.FDB';
  strDEFAULT_DVR_URL = 'rtsp://192.168.110.156:554/user=view&password=view&channel=1&stream=1.sdp';
  strDEFAULT_SKIN_NAME = 'Clean card (internal)';
  strDELETE_COMP_GROUP = 'Удалить зачётную подгруппу?';
  strDROP_ALL_TIMENOTES = 'ВНИМАНИЕ! Будут удалены данные о ВСЕХ заездах! Продолжить?';
  strEXEC_SQL = 'SQL: ';
  strFINISH = 'ФИНИШ';
  strFS_VALID_FORMAT = 'hh.mm.ss.zzz';
  strINVALID_TIMENOTE_DATA = 'Неверные данные о временной отметке';
  strLAPSTOGO = ' кругов до финиша';
  strLASTLAP = 'Последний круг';
  strLOG_FILENAME = 'racedata.log';
  strNO_PDF_PRINTER_ASSIGNED = 'Не выбран';
  strNO_POSITION_CHANGES = '▬';
  strPLATENUMBER_FONT_NAME = 'Century Gothic';
  strPRERACE_CHECK_REQUIRED = 'Требуется предстартовая проверка';
  strRACE_FINISHED = 'Гонка закончена';
  strRACE_NOT_DELECTED = 'Не выбран заезд';
  strRACE_STATUS_FINISHED = 'Завершено';
  strRACE_STATUS_STARTED = 'В процессе';
  strREADY_TO_RACE = 'Готовы к старту';
  strREQUIRED_FIELDS_MISSING = 'Пропущены обязательные для заполнения поля';
  strSIMPLE_DATEFORMAT = 'dd/mm/yyyy';
  strSNAPSHOT_DELAY_CALIBRATION = 'Калибровка';
  strSNAPSHOT_DELAY_START = 'Старт';
  strSNAPSHOT_DELAY_STOP = 'Стоп';
  strSTART = 'СТАРТ';
  strTIMENOTE_FORMAT = 'hh:mm:ss.zzz';
  strTIMER_CAPTION = '00:00:00.00';
  strUNABLE_TO_DELETE_STARTED_EVENT = 'Невозможно удалить мероприятие с проведёнными заездами';
  strUNABLE_TO_DELETE_STARTED_RACE = 'Невозможно удалить уже начатый заезд';
  strVIEW_TEST_SNAPSHOT = 'Открыть снимок для просмотра?';

  // форматы отображения Имени и Фамилии
  nfFirstLowerLastLower = 0;
  nfLastLowerFirstLower = 1;
  nfFirstLowerLastUPPER = 2;
  nfLastUPPERFirstLower = 3;

  // розовый (св-т)
  clOddLight = TColor($FAF0E6);
  clOddDark = TColor($FFE4E1);
  // голубой (св-т)
  clEvenLight = TColor($F0F8FF);
  clEvenDark = TColor($E6E6FA);
  // серый фон
  clOverlapped = TColor($DCDCDC);
  // серый шрифт
  clFontGrayed = TColor($808080);

type
  TMainForm = class(TForm)
    DBTran: TIBTransaction;
    DBase: TIBDatabase;
    Timer: TTimer;
    btnAthletNew: TsBitBtn;
    btnAthletSearch: TsBitBtn;
    btnAthletes: TsBitBtn;
    btnCGClose: TsBitBtn;
    btnCGSave: TsBitBtn;
    btnDropAllTimenotes: TsBitBtn;
    btnEventClose: TsBitBtn;
    btnEventDelete: TsBitBtn;
    btnEventEdit: TsBitBtn;
    btnEventNew: TsBitBtn;
    btnEventResults: TsBitBtn;
    btnEventSave: TsBitBtn;
    btnEvents: TsBitBtn;
    btnFindAthlet: TsBitBtn;
    btnRaceClose: TsBitBtn;
    btnRaceConfirm: TsBitBtn;
    btnRaceDelete: TsBitBtn;
    btnRaceEdit: TsBitBtn;
    btnRaceNew: TsBitBtn;
    btnRaceResults: TsBitBtn;
    btnRaceSave: TsBitBtn;
    btnRaceStart: TsBitBtn;
    btnRegister: TsBitBtn;
    btnRegistration: TsBitBtn;
    btnResultsPrint: TsBitBtn;
    btnSettings: TsBitBtn;
    btnStart: TsBitBtn;
    btnStpwtchFinish: TsBitBtn;
    btnStpwtchStart: TsBitBtn;
    btnTimenoteCancel: TsBitBtn;
    btnTimenoteOK: TsBitBtn;
    cbEvent: TsComboBox;
    cbLogLevel: TsComboBox;
    cbRace: TsComboBox;
    cbRegisterNumberplate: TsComboBox;
    cbResultsCG: TsComboBox;
    cbTimenotePlatenumber: TsComboBox;
    chbCGAgeMax: TsCheckBox;
    chbCGAgeMin: TsCheckBox;
    chbCGFemale: TsCheckBox;
    chbCGMale: TsCheckBox;
    chbSexFemale: TsCheckBox;
    chbSexMale: TsCheckBox;
    chlbAthletes: TsCheckListBox;
    chlbRaces: TsCheckListBox;
    dtpAthlet: TSDateEdit;
    dtpEvent: TSDateEdit;
    eAthletName: TsEdit;
    eAthletSearch: TsEdit;
    eCGAgeMax: TsEdit;
    eCGAgeMin: TsEdit;
    eCGLaps: TsEdit;
    eCity: TsEdit;
    eEventName: TsEdit;
    eRaceLaps: TsEdit;
    eRaceName: TsEdit;
    eRaceTrackLength: TsEdit;
    eTeam: TsEdit;
    eTimenote: TsEdit;
    ilMenuImages: TImageList;
    lbEventRaces: TsListBox;
    lbEvents: TsListBox;
    lblAthletBirthdate: TsLabel;
    lblAthletRaceStats: TsLabel;
    lblAthletRaces: TsLabelFX;
    lblAthletes: TsLabel;
    lblCGAge: TsLabel;
    lblCGLabs: TsLabel;
    lblCGSex: TsLabel;
    lblCity: TsLabel;
    lblDateEvent: TsLabelFX;
    lblEvent: TsLabelFX;
    lblEventDate: TsLabel;
    lblEventName: TsLabel;
    lblEventRaces: TsLabelFX;
    lblLogLevel: TsLabel;
    lblRace: TsLabel;
    lblRaceLaps: TsLabel;
    lblRaceName: TsLabel;
    lblRaceStatus: TsLabelFX;
    lblRaceTrackLength: TsLabel;
    lblRegisterAthletName: TsLabel;
    lblRegisterEventName: TsLabelFX;
    lblRegisterPlatenumber: TsLabel;
    lblRegisterRaces: TsLabel;
    lblRegisterSex: TsLabel;
    lblRegisteredList: TsLabelFX;
    lblResultsCG: TsLabel;
    lblTeam: TsLabel;
    lvAthRaces: TsListView;
    lvAthStats: TsListView;
    lvRacePanel: TsListView;
    lvRegistered: TsListView;
    lvResults: TsListView;
    miRPTimenoteAdd: TMenuItem;
    miRPTimenoteDel: TMenuItem;
    miRPTimenoteRenum: TMenuItem;
    miRagistrationCancel: TMenuItem;
    pcMain: TSPageControl;
    pcStart: TSPageControl;
    pmAthletSearch: TPopupMenu;
    pmRPMenu: TPopupMenu;
    pmRegistrationCancel: TPopupMenu;
    pnlAthletStats: TsPanel;
    pnlCGEdit: TsPanel;
    pnlEvent: TsPanel;
    pnlEventRaces: TsPanel;
    pnlMainMenu: TsPanel;
    pnlRace: TsPanel;
    pnlTimenote: TsPanel;
    cbEventRegistration: TsComboBox;
    sSkinManager: TsSkinManager;
    sSkinProvider: TsSkinProvider;
    sSplitter1: TsSplitter;
    spNumbersPanel: TsPanel;
    spRace: TsPanel;
    spRacePanel: TsPanel;
    spbResults: TsProgressBar;
    tsAthletes: TSTabSheet;
    tsEvent: TSTabSheet;
    tsRacePanel: TSTabSheet;
    tsRaceResults: TSTabSheet;
    tsRegistration: TSTabSheet;
    tsSettings: TSTabSheet;
    tsStart: TSTabSheet;
    tsStartPrep: TSTabSheet;
    frResults: TfrReport;
    frUserDataset: TfrUserDataset;
    frTimenotes: TfrReport;
    miRPPrint: TMenuItem;
    frAthletStats: TfrReport;
    btnPrintAthletStats: TsBitBtn;
    miRPTimenoteAddNow: TMenuItem;
    miRPTimenote1SecPlus: TMenuItem;
    miRPTimenoteAdd1SecMinus: TMenuItem;
    lblPlatesCount: TsLabel;
    ePlatesCount: TsEdit;
    btnPlatesCount: TsBitBtn;
    lvCompGroups: TsListView;
    btnCGDelete: TsBitBtn;
    btnCGNew: TsBitBtn;
    lblCGList: TsLabelFX;
    gbVideoSettings: TsGroupBox;
    chbEnableSnapshots: TsCheckBox;
    eDVRUrl: TsEdit;
    lblDVRUrl: TsLabel;
    lblSnapshotsDir: TsLabel;
    pnlDRVTest: TsPanel;
    btnDVRTestPlay: TsBitBtn;
    btnDVRTestStop: TsBitBtn;
    btnDVRTestSnapshot: TsBitBtn;
    pnlTimerLabel: TsPanel;
    sTimerLabel: TsLabel;
    btnDVRIndicator: TsBitBtn;
    pnlDVRPlayback: TsPanel;
    eSnapshotsDir: TsDirectoryEdit;
    N2: TMenuItem;
    miOpenSnapshot: TMenuItem;
    pmAthletes: TPopupMenu;
    N3: TMenuItem;
    pnlAthletes: TsPanel;
    lvAthletes: TsListView;
    pnlEditAthlet: TsPanel;
    eAthName: TsEdit;
    eAthCity: TsEdit;
    eAthTeam: TsEdit;
    deAthBirthdate: TsDateEdit;
    btnEditAthSave: TsBitBtn;
    btnEditAthClose: TsBitBtn;
    chbAthMale: TsCheckBox;
    chbAthFemale: TsCheckBox;
    lblSnapshotDelay: TsLabel;
    eSnapshotDelay: TsEdit;
    btnSnapshotDelay: TsButton;
    lblAvailableRaces: TsLabel;
    lblUnalailableRaces: TsLabel;
    lbUnavailableRaces: TsListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure btnAthletNewClick(Sender: TObject);
    procedure btnAthletSearchClick(Sender: TObject);
    procedure btnAthletesClick(Sender: TObject);
    procedure btnCGCloseClick(Sender: TObject);
    procedure btnCGDeleteClick(Sender: TObject);
    procedure btnCGNewClick(Sender: TObject);
    procedure btnCGSaveClick(Sender: TObject);
    procedure btnDropAllTimenotesClick(Sender: TObject);
    procedure btnEventCloseClick(Sender: TObject);
    procedure btnEventDeleteClick(Sender: TObject);
    procedure btnEventEditClick(Sender: TObject);
    procedure btnEventNewClick(Sender: TObject);
    procedure btnEventSaveClick(Sender: TObject);
    procedure btnEventsClick(Sender: TObject);
    procedure btnFindAthletClick(Sender: TObject);
    procedure btnRaceCloseClick(Sender: TObject);
    procedure btnRaceConfirmClick(Sender: TObject);
    procedure btnRaceDeleteClick(Sender: TObject);
    procedure btnRaceEditClick(Sender: TObject);
    procedure btnRaceNewClick(Sender: TObject);
    procedure btnRaceResultsClick(Sender: TObject);
    procedure btnRaceSaveClick(Sender: TObject);
    procedure btnRaceStartClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure btnRegistrationClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnStpwtchFinishClick(Sender: TObject);
    procedure btnStpwtchStartClick(Sender: TObject);
    procedure btnTimenoteCancelClick(Sender: TObject);
    procedure btnTimenoteOKClick(Sender: TObject);
    procedure cbEventChange(Sender: TObject);
    procedure cbLogLevelChange(Sender: TObject);
    procedure cbRaceChange(Sender: TObject);
    procedure cbResultsCGChange(Sender: TObject);
    procedure chbCGAgeMaxClick(Sender: TObject);
    procedure chbCGAgeMinClick(Sender: TObject);
    procedure chbCGFemaleClick(Sender: TObject);
    procedure chbCGMaleClick(Sender: TObject);
    procedure chbSexFemaleClick(Sender: TObject);
    procedure chbSexMaleClick(Sender: TObject);
    procedure eAthletSearchChange(Sender: TObject);
    procedure eAthletSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbEventsDblClick(Sender: TObject);
    procedure lbEventsEnter(Sender: TObject);
    procedure lvAthRacesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvAthStatsCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvAthStatsCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvAthletesSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvRacePanelCustomDraw(Sender: TCustomListView; const ARect: TRect; var DefaultDraw: Boolean);
    procedure lvRacePanelCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvRacePanelCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure miRPTimenoteDelClick(Sender: TObject);
    procedure miRPTimenoteRenumClick(Sender: TObject);
    procedure miRagistrationCancelClick(Sender: TObject);
    procedure cbEventRegistrationChange(Sender: TObject);
    procedure sSkinManagerAfterChange(Sender: TObject);
    procedure spNumbersPanelResize(Sender: TObject);
    procedure tsAthletesShow(Sender: TObject);
    procedure tsEventShow(Sender: TObject);
    procedure tsRacePanelShow(Sender: TObject);
    procedure tsRaceResultsShow(Sender: TObject);
    procedure tsRegistrationShow(Sender: TObject);
    procedure tsStartPrepShow(Sender: TObject);
    procedure btnEventResultsClick(Sender: TObject);
    procedure frResultsGetValue(const ParName: string; var ParValue: Variant);
    procedure btnResultsPrintClick(Sender: TObject);
    procedure miRPPrintClick(Sender: TObject);
    procedure frTimenotesGetValue(const ParName: string; var ParValue: Variant);
    procedure btnPrintAthletStatsClick(Sender: TObject);
    procedure frAthletStatsGetValue(const ParName: string; var ParValue: Variant);
    procedure miRPTimenoteAddNowClick(Sender: TObject);
    procedure miRPTimenote1SecPlusClick(Sender: TObject);
    procedure miRPTimenoteAdd1SecMinusClick(Sender: TObject);
    procedure btnPlatesCountClick(Sender: TObject);
    procedure cbPrintersChange(Sender: TObject);
    procedure tsSettingsShow(Sender: TObject);
    procedure chbEnableSnapshotsClick(Sender: TObject);
    procedure btnDVRTestPlayClick(Sender: TObject);
    procedure btnDVRTestStopClick(Sender: TObject);
    procedure btnDVRTestSnapshotClick(Sender: TObject);
    procedure eDVRUrlChange(Sender: TObject);
    procedure btnDVRIndicatorClick(Sender: TObject);
    procedure eSnapshotsDirChange(Sender: TObject);
    procedure pmRPMenuPopup(Sender: TObject);
    procedure miOpenSnapshotClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure btnEditAthCloseClick(Sender: TObject);
    procedure chbAthMaleClick(Sender: TObject);
    procedure chbAthFemaleClick(Sender: TObject);
    procedure btnEditAthSaveClick(Sender: TObject);
    procedure btnSnapshotDelayClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fs: TFormatSettings;
    iPlatenumbersCount: Integer;
    RaceNumbers: TStringList;
    TIME_START, dtSnapshotClbrStart, dtSnapshotClbrStop: TDateTime;
    iSnapshotDelay : integer;
    logLevel: Integer;
    strPDFPrinterName: string;
    strLogFilename: string;
    strSnapshotFileName: string;
    Config: TIniFile;
    bDoRacePanelRefresh, bDoNBRepaintLater: Boolean;
    procedure SelectAthlet(Sender: TObject);
    procedure RepaintNumberButtons(Sender: TObject);
    procedure OnPlateNumberClick(Sender: TObject);
    procedure RefreshRacePanel(bFullUpdate: boolean);
    procedure LogIt(errLever: Integer; strMessage: string);
    function GetReportHeaderParam(const RACE_ID: Integer; const ParName: string): Variant;
    function FormatTimeNote(dtTimeNote : TDateTime): string;
  end;

  RPUpdThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure DoWork;
    procedure Execute; override;
  end;

  DVRSnapshotThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

var
  MainForm: TMainForm;
  rpThread: RPUpdThread;
  dvrThread: DVRSnapshotThread;
  function ScrollBarVisible(Handle: HWnd; Style: Longint): Boolean;

implementation

{$R *.dfm}

procedure RPUpdThread.Execute;
begin
  FreeOnTerminate := true;
  Synchronize(DoWork);
end;

procedure RPUpdThread.DoWork;
begin
  with MainForm do begin
    RefreshRacePanel(False);
//    RefreshRacePanel(True);
    LogIt(llDEBUG, 'RPUpdThread.Free, ThreadID = ' + IntToStr(ThreadID) + #13#10);
  end;
end;

procedure DVRSnapshotThread.Execute;
begin
  FreeOnTerminate := true;
  with MainForm do begin
    // отработка задержки
    LogIt(llDEBUG, 'Snapshot delay ' + IntToStr(iSnapshotDelay) + ' ms, ThreadID = ' + IntToStr(ThreadID) + #13#10);
    Sleep(iSnapshotDelay);
    LogIt(llDEBUG, 'Snapshot at ' + eSnapshotsDir.Text + '\' + strSnapshotFileName + ', ThreadID = ' + IntToStr(ThreadID) + #13#10);
    GetSnapshot(vlcMediaPlayer, eSnapshotsDir.Text + '\' + strSnapshotFileName);
    LogIt(llDEBUG, 'DVRSnapshotThread.Free, ThreadID = ' + IntToStr(ThreadID) + #13#10);
  end;
end;

function RusMessageDialog(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Captions: array of string): Integer;
var
  aMsgDlg: TForm;
  i: Integer;
  dlgButton: TButton;
  CaptionIndex: Integer;
begin
  aMsgDlg := CreateMessageDialog(Msg, DlgType, Buttons);
  aMsgDlg.Caption := Captions[0];
  CaptionIndex := 1;
  // перебор по объектам в диалоге
  for i := 0 to aMsgDlg.ComponentCount - 1 do begin
    // если кнопка
    if (aMsgDlg.Components[i] is TButton) then begin
      dlgButton := TButton(aMsgDlg.Components[i]);
      if CaptionIndex > High(Captions) then
        Break;
      // загружаем новый заголовок из нашего массива заголовков
      dlgButton.Caption := Captions[CaptionIndex];
      inc(CaptionIndex);
    end;
  end;
  Result := aMsgDlg.ShowModal;
end;

function FormatAthName(NameFormat: byte; strAthName: string) : string;
var
  slBuffer: TStringList;
  str : string;
begin
  case NameFormat of
    nfFirstLowerLastLower : begin
      FormatAthName := StringReplace(strAthName, '  ' , ' ', [rfReplaceAll, rfIgnoreCase]);
    end;
    nfLastLowerFirstLower : begin
      slBuffer := TStringList.Create;
      slBuffer.Delimiter := ' ';
      slBuffer.DelimitedText := StringReplace(strAthName, '  ' , ' ', [rfReplaceAll, rfIgnoreCase]);
      if slBuffer.Count = 2 then begin
        str := slBuffer[0];
        slBuffer[0] := slBuffer[1];
        slBuffer[1] := str;
        FormatAthName := slBuffer.DelimitedText;
      end
      else FormatAthName := strAthName;
      slBuffer.Free;
    end;
    nfFirstLowerLastUPPER : begin
      slBuffer := TStringList.Create;
      slBuffer.Delimiter := ' ';
      slBuffer.DelimitedText := StringReplace(strAthName, '  ' , '' , [rfReplaceAll, rfIgnoreCase]);
      if slBuffer.Count = 2 then begin
        str := slBuffer[1];
        slBuffer[1] := AnsiUpperCase(str);
        FormatAthName := slBuffer.DelimitedText;
      end
      else FormatAthName := strAthName;
      slBuffer.Free;
    end;
    nfLastUPPERFirstLower : begin
      slBuffer := TStringList.Create;
      slBuffer.Delimiter := ' ';
      slBuffer.DelimitedText := StringReplace(strAthName, '  ' , ' ', [rfReplaceAll, rfIgnoreCase]);
      if slBuffer.Count = 2 then begin
        str := slBuffer[0];
        slBuffer[0] := AnsiUpperCase(slBuffer[1]);
        slBuffer[1] := str;
        FormatAthName := slBuffer.DelimitedText;
      end
      else FormatAthName := strAthName;
      slBuffer.Free;
    end;
  end;
end;

procedure TMainForm.LogIt(errLever: Integer; strMessage: string);
var
  F: TextFile;
  dt, strLogLevel: string;
begin
  if logLevel >= errLever then begin
    AssignFile(F, strLogFilename);
    if FileExists(strLogFilename) then
      Append(F)
    else
      Rewrite(F);
    dt := DateToStr(Date);
    dt := dt + ' ' + TimeToStr(Time);
    case errLever of
      llERROR: strLogLevel := 'ERROR';
      llWARNING: strLogLevel := 'WARNING';
      llDEBUG: strLogLevel := 'DEBUG';
    end;
    Write(F, dt + ' [' + strLogLevel + '] ' + strMessage);
    CloseFile(F);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Config := TIniFile.Create(ExtractFilePath(Application.ExeName) + strCONFIG_FILENAME);
  logLevel := Config.ReadInteger('Logging', 'Level', llNOLOG);
  strLogFilename := ExtractFilePath(Application.ExeName)
    + Config.ReadString('Logging', 'Filename', strLOG_FILENAME);
  sSkinManager.SkinName := Config.ReadString('General', 'Skin', strDEFAULT_SKIN_NAME);
  DBase.DatabaseName := ExtractFilePath(Application.ExeName) + strDB_FILENAME;
  iPlatenumbersCount := Config.ReadInteger('General', 'PlateNumbers', iPLATENUMBERS_COUNT_DEFAULT);
  strPDFPrinterName := Config.ReadString('General', 'PDFPrinter', strNO_PDF_PRINTER_ASSIGNED);
  chbEnableSnapshots.Checked := Config.ReadBool('DVR', 'Enabled', False);
  eDVRUrl.Enabled := chbEnableSnapshots.Checked;
  btnDVRIndicator.Enabled := chbEnableSnapshots.Checked;
  eSnapshotsDir.Enabled := chbEnableSnapshots.Checked;
  btnDVRTestPlay.Enabled := chbEnableSnapshots.Checked;
  eSnapshotsDir.Text := Config.ReadString('DVR', 'SnapshotsDir',
    ExtractFilePath(Application.ExeName) + 'Snapshots');
  eDVRUrl.Text := Config.ReadString('DVR', 'URL', strDEFAULT_DVR_URL);
  iSnapshotDelay := Config.ReadInteger('DVR', 'CameraDelayMS', 0);
  eSnapshotDelay.Text := IntToStr(iSnapshotDelay);
  try
    DBase.Connected := true;
    DBTran.Active := true;
  except
    ShowMessage(strDB_CONNECTION_ERROR);
    LogIt(llERROR, strDB_CONNECTION_ERROR);
  end;
  RaceNumbers := TStringList.Create;
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, fs);
  with fs do begin
    TimeSeparator := ':';
    DecimalSeparator := '.';
    ShortTimeFormat := strTIMENOTE_FORMAT;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  tsEvent.Show;
end;

// извлечение дополнительных параметров дял шапки отчёта. передаём RACE_ID и ParName
function TMainForm.GetReportHeaderParam(const RACE_ID: Integer;
  const ParName: string): Variant;
var
  i: Integer;
begin
  if ParName = 'date' then begin
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select events.event_date from events, races where ' +
        '(races.event_id=events.event_id) and (races.race_id=' + IntToStr(RACE_ID) + ');';
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      Open;
      GetReportHeaderParam := FormatDateTime(strSIMPLE_DATEFORMAT, Fields[0].AsDateTime);
    finally
      Free;
    end;
  end;
  if ParName = 'track_length' then begin
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select track_length from races where race_id=' + IntToStr(RACE_ID) + ';';
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      Open;
      GetReportHeaderParam := Fields[0].AsInteger;
    finally
      Free;
    end;
  end;
  if (ParName = 'laps') or (ParName = 'race_distance') then begin
    if (cbResultsCG.ItemIndex = 0) or (tsAthletes.Visible) then begin
      // если абсолют
      with TIBQuery.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        SQL.Text := 'select laps, track_length from races where race_id='
          + IntToStr(RACE_ID) + ';';
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
        Open;
        if ParName = 'laps' then GetReportHeaderParam := Fields[0].AsInteger;
        if ParName = 'race_distance' then GetReportHeaderParam :=
          RoundTo(Fields[0].AsInteger * Fields[1].AsInteger / 1000, -3);
      finally
        Free;
      end;
    end
    else begin
      // если подгруппа
      with TIBQuery.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        // изображаем такой-же запрос как и в sComboBox6, пробегаемся по нему до ItemIndex
        // и находим нужные поля
        SQL.Text := 'select comp_groups.sex, comp_groups.agemin, comp_groups.agemax, '
          + 'comp_groups.laps, races.track_length from comp_groups,races where '
          + '(comp_groups.race_id=' + IntToStr(RACE_ID)
          + ') and(races.race_id=comp_groups.race_id)'
          + ' order by sex,agemin;';
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
        Open;
        FetchAll;
        i := 1;
        while i < cbResultsCG.ItemIndex do begin
          Next;
          inc(i);
        end;
        if ParName = 'laps' then GetReportHeaderParam := Fields[3].AsInteger;
        if ParName = 'race_distance' then GetReportHeaderParam :=
          RoundTo(Fields[3].AsInteger * Fields[4].AsInteger / 1000, -3);
      finally
        Free;
      end;
    end;
  end;
end;

function TMainForm.FormatTimeNote(dtTimeNote : TDateTime) : string;
begin
  FormatTimenote := Copy(FormatDateTime(strTIMENOTE_FORMAT, dtTimeNote), 1, 11);
end;

procedure TMainForm.frAthletStatsGetValue(const ParName: string;
  var ParValue: Variant);
var
  i: Integer;
begin
  if (ParName = 'laps') or (ParName = 'race_distance')
    or (ParName = 'date') or (ParName = 'track_length')
  then ParValue := GetReportHeaderParam(Integer(lvAthRaces.Selected.Data), ParName);
  if ParName = 'event_name' then ParValue := lvAthRaces.Selected.SubItems.Strings[0];
  if ParName = 'race_name' then ParValue := lvAthRaces.Selected.SubItems.Strings[1];
  if ParName = 'comp_group' then ParValue := strABSOLUTE;
  if ParName = 'athlet' then ParValue := FormatAthName(nfLastUPPERFirstLower, lvAthletes.Selected.Caption);
  if ParName = 'lap' then ParValue := lvAthStats.Items[frUserDataset.RecNo].Caption;
  if ParName = 'lap_time' then ParValue :=
    lvAthStats.Items[frUserDataset.RecNo].SubItems.Strings[0];
  if ParName = 'position' then ParValue :=
    lvAthStats.Items[frUserDataset.RecNo].SubItems.Strings[1];
  if ParName = 'move' then ParValue :=
    lvAthStats.Items[frUserDataset.RecNo].SubItems.Strings[2];
  if ParName = 'speed' then ParValue :=
    lvAthStats.Items[frUserDataset.RecNo].SubItems.Strings[3];
  if (ParName = 'best_lap_number') or (ParName = 'best_lap_time') or (ParName = 'best_avg_speed')
  then begin
    i := 0;
    while Integer(lvAthStats.Items[i].Data) <> iBEST_LAP_FLAG do inc(i);
    if ParName = 'best_lap_number' then ParValue := lvAthStats.Items[i].Caption;
    if ParName = 'best_lap_time' then ParValue := lvAthStats.Items[i].SubItems.Strings[0];
    if ParName = 'best_avg_speed' then ParValue := lvAthStats.Items[i].SubItems.Strings[3];
  end;
end;

procedure TMainForm.frResultsGetValue(const ParName: string;
  var ParValue: Variant);
begin
  if (ParName = 'laps') or (ParName = 'race_distance') or (ParName = 'date') or (ParName = 'track_length')
  then ParValue := GetReportHeaderParam(cbResultsCG.Tag, ParName);
  if ParName = 'event_name' then ParValue := cbEvent.Text;
  if ParName = 'race_name' then ParValue := cbRace.Text;
  if ParName = 'comp_group' then ParValue := cbResultsCG.Text;
  if ParName = 'place' then ParValue := lvResults.Items[frUserDataset.RecNo].Caption;
  if ParName = 'athlet' then ParValue := FormatAthName(nfLastUPPERFirstLower, lvResults.Items[frUserDataset.RecNo].SubItems.Strings[0]);
  if ParName = 'platenumber' then ParValue :=
    lvResults.Items[frUserDataset.RecNo].SubItems.Strings[1];
  if ParName = 'time' then ParValue :=
    lvResults.Items[frUserDataset.RecNo].SubItems.Strings[2];
  if ParName = 'city' then begin
    if lvResults.Items[frUserDataset.RecNo].SubItems.Count > 3 then
      ParValue := lvResults.Items[frUserDataset.RecNo].SubItems.Strings[3]
    else
      ParValue := '';
  end;
  if ParName = 'team' then begin
    if lvResults.Items[frUserDataset.RecNo].SubItems.Count > 4 then
      ParValue := lvResults.Items[frUserDataset.RecNo].SubItems.Strings[4]
    else ParValue := '';
  end;
end;

procedure TMainForm.frTimenotesGetValue(const ParName: string;
  var ParValue: Variant);
begin
  if (ParName = 'laps') or (ParName = 'race_distance') or (ParName = 'date') or
    (ParName = 'track_length')
  then
    ParValue := GetReportHeaderParam(cbResultsCG.Tag, ParName);
  if ParName = 'event_name' then ParValue := cbEvent.Text;
  if ParName = 'race_name' then ParValue := cbRace.Text;
  if ParName = 'comp_group' then ParValue := strABSOLUTE;
  if ParName = 'timenote' then ParValue := lvRacePanel.Items[frUserDataset.RecNo].Caption;
  if ParName = 'platenumber' then ParValue :=
    lvRacePanel.Items[frUserDataset.RecNo].SubItems.Strings[0];
  if ParName = 'athlet' then ParValue := FormatAthName(nfLastUPPERFirstLower,
    lvRacePanel.Items[frUserDataset.RecNo].SubItems.Strings[1]);
  if ParName = 'lap' then ParValue :=
    lvRacePanel.Items[frUserDataset.RecNo].SubItems.Strings[2];
  if ParName = 'position' then ParValue :=
    lvRacePanel.Items[frUserDataset.RecNo].SubItems.Strings[3];
  if ParName = 'overlaps' then begin
    if lvRacePanel.Items[frUserDataset.RecNo].SubItems.Count > 4 then
      ParValue := lvRacePanel.Items[frUserDataset.RecNo].SubItems.Strings[4]
    else ParValue := '';
  end;
end;

procedure TMainForm.miRPPrintClick(Sender: TObject);
begin
  frUserDataset.RangeEnd := reCount;
  frUserDataset.RangeEndCount := lvRacePanel.Items.Count;
  frTimenotes.ShowReport;
end;

procedure TMainForm.OnPlateNumberClick(Sender: TObject);
var
  PLATENUMBER, RACE_ID, LAST_TN_ID: Integer;
begin
  // проверяем стартовал ли заезд
  if not(btnStpwtchStart.Enabled) then begin
    PLATENUMBER := StrToInt(TFreeButton(Sender).Caption);
    RACE_ID := TFreeButton(Sender).Tag;
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select max(tn_id) from timenotes;';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      LAST_TN_ID := Fields[0].AsInteger;
    finally
      Free;
    end;
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text :=
        'insert into timenotes(tn_id,race_id,platenumber,timenote) values('
        + IntToStr(LAST_TN_ID + 1) + ',' + IntToStr(RACE_ID) + ','
        + IntToStr(PLATENUMBER) + ',''' + FormatDateTime(strTIMENOTE_FORMAT, Now())
        + ''');';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    finally
      Free;
    end;
    // фигачим фото
    if chbEnableSnapshots.Checked then begin
      strSnapshotFileName :=
        IntToStr(RACE_ID) + '.'  + IntToStr(LAST_TN_ID + 1) + '.'
        + TFreeButton(Sender).Caption + '.png';
      dvrThread := DVRSnapshotThread.Create(False);
      LogIt(llDEBUG, 'DVRSnapshotThread.Create, ThreadID = ' + IntToStr(dvrThread.ThreadID) + #13#10);
    end;
    // если предыдущий поток обновления завершил работу, запускаем новый
    if not(bDoRacePanelRefresh) then begin
      // выставляем флаг процесса обновления
      bDoRacePanelRefresh := true;
      rpThread := RPUpdThread.Create(False);
      LogIt(llDEBUG, 'RPUpdThread.Create, ThreadID = ' + IntToStr(rpThread.ThreadID) + #13#10);
    end;
  end;
end;

procedure TMainForm.pmRPMenuPopup(Sender: TObject);
var
  strFileName : string;
  RACE_ID : integer;
begin
  RACE_ID := spNumbersPanel.Tag;
  strFileName := eSnapshotsDir.Text + '\' + IntToStr(RACE_ID) + '.'
    + IntToStr(Integer(lvRacePanel.Selected.Data)) + '.'
    + lvRacePanel.Selected.SubItems.Strings[0] + '.png';
  miOpenSnapshot.Enabled := FileExists(strFileName);
end;

procedure TMainForm.RefreshRacePanel(bFullUpdate : boolean);
var
  i, j, k, iPosCnt, iLapsOffset, iPanelWidth, ScrollBarWidth, RACE_ID, TN_ID,
    PLATENUMBER, iLapsCompleted, iLapsToGo, iStartRefreshIdx : Integer;
  TIMENOTE, RACETIME: TDateTime;
  strTIME_START, strTIMENOTES_SQL: string;
  lItem: TListItem;
begin
  // берём RACE_ID из sspNumbersPanel.Tag
  RACE_ID := spNumbersPanel.Tag;
  // проверяем режим обновления панели
  if (bFullUpdate) or (lvRacePanel.Items.Count = 0) then begin
    // если полное обновление, выбираем все отметки и проставляеми позиции с начала
    LogIt(llDEBUG, 'Full RacePanel clean & refresh' + #13#10);
    lvRacePanel.Clear;
    strTIMENOTES_SQL :=
      'select timenotes.tn_id, athletes.name, timenotes.platenumber, '
      + 'timenotes.timenote from athletes, registry, timenotes where (athletes.athlet_id = '
      + 'registry.athlet_id) and (registry.platenumber = timenotes.platenumber) and '
      + '(registry.race_id = timenotes.race_id) and (timenotes.race_id = '
      + IntToStr(RACE_ID) + ') order by timenotes.timenote;';
    iStartRefreshIdx := 0;
  end
  else begin
    // если только добавить, то выбираем ещё не добавленные отметки
    // и проставляем позиции только для них
    LogIt(llDEBUG, 'Partial RacePanel refresh from TN_ID='
      + IntToStr(Integer(lvRacePanel.Items.Item[lvRacePanel.Items.Count - 1].Data)) + #13#10);
    strTIMENOTES_SQL :=
      'select timenotes.tn_id, athletes.name, timenotes.platenumber, '
      + 'timenotes.timenote from athletes, registry, timenotes where (athletes.athlet_id = '
      + 'registry.athlet_id) and (registry.platenumber = timenotes.platenumber) and '
      + '(registry.race_id = timenotes.race_id) and (timenotes.race_id = '
      + IntToStr(RACE_ID) + ') and (timenotes.tn_id > '
      + IntToStr(Integer(lvRacePanel.Items.Item[lvRacePanel.Items.Count - 1].Data))
      + ') order by timenotes.timenote;';
    iStartRefreshIdx := lvRacePanel.Items.Count;
  end;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // время старта
    SQL.Text :=
      'select timenote from timenotes where (platenumber = 0) '
      + 'and (race_id = ' + IntToStr(RACE_ID) + ');';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    if RecordCount > 0 then begin
      btnStpwtchStart.Enabled := False;
      strTIME_START := Fields[0].AsString;
      TIME_START := StrToTime(strTIME_START, fs);
      btnStpwtchStart.Caption := 'Время старта: ' + Copy(strTIME_START, 1, 11);
      // Timer.Enabled := true;
    end
    else begin
      btnStpwtchStart.Enabled := true;
      btnStpwtchStart.Caption := strSTART;
    end;
    Close;
    // времена засечек
    SQL.Text := strTIMENOTES_SQL;
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    while not(EOF) do begin
      TN_ID := Fields[0].AsInteger;
      PLATENUMBER := Fields[2].AsInteger;
      TIMENOTE := StrToTime(Fields[3].AsString, fs);
      RACETIME := TIMENOTE - TIME_START;
      lItem := lvRacePanel.Items.Add;
      with lItem do begin
        // сохраняем TN_ID в Item.Data
        Data := Pointer(TN_ID);
        // отсекаем тысячные, чтоб не захламлять
        Caption := FormatTimeNote(RACETIME);
        SubItems.Add(IntToStr(PLATENUMBER));
        SubItems.Add(Fields[1].AsString);
        // считаем круги
        with TIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text :=
            'select count(tn_id) from timenotes where ' + '(tn_id < '
            + IntToStr(TN_ID) + ') and (platenumber=' + IntToStr(PLATENUMBER)
            + ') and (race_id=' + IntToStr(RACE_ID) + ');';
          Open;
          LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
          SubItems.Add(IntToStr(Fields[0].AsInteger + 1));
        finally
          Free;
        end;
      end;
      Next;
    end;
    // проставляем позиции
    with lvRacePanel.Items do begin
      if Count <> 0 then begin
        iPosCnt := 1;
        // проставялем 1-ю позицию только при полном апдейте панели
        if bFullUpdate then Item[0].SubItems.Add('1');
        // начинаем пробегать начиная с указанного элемента
        for i := iStartRefreshIdx to Count - 1 do begin
          iPosCnt := 0;
          iLapsOffset := 0;
          // преебираем всех, кто прошёл ранее
          for j := i downto 0 do begin
            // находим позицию на основании числа уже прошедших в этом круге
            if Item[i].SubItems.Strings[2] = Item[j].SubItems.Strings[2] then inc(iPosCnt);
            // находим максимальную разницу в кругах из уже ранее отметившихся
            k := StrToInt(Item[j].SubItems.Strings[2]) - StrToInt(Item[i].SubItems.Strings[2]);
            if iLapsOffset < k then iLapsOffset := k;
            // заодно сохраняем текущий круг лидера
            if iLapsCompleted < StrToInt(Item[j].SubItems.Strings[2]) then
              iLapsCompleted := StrToInt(Item[j].SubItems.Strings[2]);
          end;
          Item[i].SubItems.Add(IntToStr(iPosCnt));
          if iLapsOffset > 0 then Item[i].SubItems.Add('-' + IntToStr(iLapsOffset));
        end;
      end;
    end; // with ListView2.Items
    // выравнивание ширины колонок, подгонка ширины панели по колонкам
    iPanelWidth := 0;
    for i := 0 to lvRacePanel.Columns.Count - 2 do begin
      lvRacePanel.Columns[i].Width := ColumnHeaderWidth;
      iPanelWidth := iPanelWidth + lvRacePanel.Columns[i].Width;
    end;
    iPanelWidth := iPanelWidth + lvRacePanel.Columns
      [lvRacePanel.Columns.Count - 1].Width;
    if ScrollBarVisible(lvRacePanel.Handle, WS_VSCROLL) then
      ScrollBarWidth := GetSystemMetrics(SM_CXVSCROLL)
    else
      ScrollBarWidth := 0;
    spRacePanel.Width := iPanelWidth + ScrollBarWidth + lvRacePanel.Columns.Count;
    // прокрутка в конец
    SendMessage(lvRacePanel.Handle, WM_VSCROLL, SB_BOTTOM, 0);
  finally
    Free;
  end;
  // выводим, сколько кругов осталось
  iLapsToGo := btnStpwtchFinish.Tag - iLapsCompleted;
  if iLapsToGo > 1 then btnStpwtchFinish.Caption :=
    IntToStr(btnStpwtchFinish.Tag - iLapsCompleted) + strLAPSTOGO;
  if iLapsToGo = 1 then btnStpwtchFinish.Caption := strLASTLAP;
  if iLapsToGo < 1 then btnStpwtchFinish.Caption := strFINISH;
  // снимаем флаг процесса обновления
  bDoRacePanelRefresh := False;
end;

procedure TMainForm.RepaintNumberButtons(Sender: TObject);
var
  i, iBtnNum, iBtnWidth, iBtnHeight, iRows, iColumns, iFldWidth, iFldHeight,
    maxBtnSize: Integer;
  k: real;
  Item: TControl;
begin
  // вычисление параметров кнопочного поля
  iFldWidth := spNumbersPanel.Width;
  iFldHeight := spNumbersPanel.Height;
  iBtnNum := RaceNumbers.Count;
  // Считаем максимальную сторону квадрата
  maxBtnSize := trunc(sqrt(iFldHeight * iFldWidth / iBtnNum));
  // пробежался в сторону уменьшения i подставляя его в формулу K=(ширина div i)*(высота div i)
  // пока K не станет равно количеству квадратов
  i := maxBtnSize;
  repeat
    dec(i);
    iColumns := iFldWidth div i;
    iRows := iFldHeight div i;
    k := iColumns * iRows;
  until (k >= iBtnNum);
  iBtnHeight := i;
  iBtnWidth := i;
  spNumbersPanel.Hide;
  // удаление старых кнопок
  for i := spNumbersPanel.ControlCount - 1 downto 0 do begin
    Item := spNumbersPanel.Controls[i];
    Item.Free;
  end;
  // заполняем
  for i := 0 to iBtnNum - 1 do begin
    with TFreeButton.Create(spNumbersPanel) do begin
      Parent := spNumbersPanel;
      Caption := RaceNumbers.Strings[i];
      Width := iBtnWidth;
      Height := iBtnHeight;
      Left := (i mod iColumns) * iBtnWidth;
      Top := (i div iColumns) * iBtnHeight;
      DrawColor := clCream;
      DrawLight := False;
      DrawDropShadow := False;
      with Font do begin
        Size := iBtnHeight div 3;
        Style := [fsBold];
        Color := clBlack;
        Name := strPLATENUMBER_FONT_NAME;
      end;
      // сохраняем RACE_ID в Tag кнопки
      Tag := chlbAthletes.Tag;
      onClick := OnPlateNumberClick;
      // Show;
    end;
  end;
  spNumbersPanel.Show;
end;

procedure TMainForm.lvRacePanelCustomDraw(Sender: TCustomListView;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
  with lvRacePanel.Canvas do begin
    // Brush.Color := clLinen;
    // FillRect(ARect);
  end;
end;

procedure TMainForm.lvRacePanelCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  with Sender.Canvas do begin
    if (StrToInt(Item.SubItems.Strings[2]) mod 2) = 0 then begin
      if (Item.Index mod 2) = 0 then Brush.Color := clOddDark
      else Brush.Color := clOddLight;
    end
    else begin
      if (Item.Index mod 2) = 0 then Brush.Color := clEvenDark
      else Brush.Color := clEvenLight;
    end;
    if Item.SubItems.Count = 5 then Brush.Color := clOverlapped;
    if Item.SubItems.Strings[3] = '1' then begin
      Font.Style := [fsBold, fsUnderline];
    end
    else if Item.SubItems.Strings[3] = '2' then
      Font.Style := [fsUnderline]
    else if Item.SubItems.Strings[3] <> '3' then
      Font.Color := clFontGrayed;
  end;
end;

procedure TMainForm.lvRacePanelCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  with Sender.Canvas do begin
    if (StrToInt(Item.SubItems.Strings[2]) mod 2) = 0 then begin
      if (Item.Index mod 2) = 0 then Brush.Color := clOddDark
      else Brush.Color := clOddLight;
    end
    else begin
      if (Item.Index mod 2) = 0 then Brush.Color := clEvenDark
      else Brush.Color := clEvenLight;
    end;
    if Item.SubItems.Count = 5 then
      Brush.Color := clOverlapped;
    if Item.SubItems.Strings[3] = '1' then begin
      Font.Style := [fsBold, fsUnderline];
    end
    else if Item.SubItems.Strings[3] = '2' then
      Font.Style := [fsUnderline]
    else if Item.SubItems.Strings[3] <> '3' then
      Font.Color := clFontGrayed;
  end;
end;

procedure TMainForm.lvAthletesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  i: Integer;
  lItem: TListItem;
begin
  lvAthStats.Clear;
  lvAthRaces.Clear;
  btnPrintAthletStats.Enabled := False;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text :=
      'select events.event_date, events.name, races.name, races.race_id, '
      + 'races.track_length, races.laps from athletes, races, events, '
      + 'registry where (athletes.athlet_id = ' + IntToStr(Integer(Item.Data))
      + ') and (athletes.athlet_id = registry.athlet_id) and (registry.race_id = races.race_id) '
      + 'and (races.event_id = events.event_id) and (races.status = ''' + strRACE_STATUS_FINISHED
      + ''') order by events.event_date, races.race_id;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    while not(EOF) do begin
      lItem := lvAthRaces.Items.Add;
      with lItem do begin
        Caption := FormatDateTime(strSIMPLE_DATEFORMAT, Fields[0].AsDateTime);
        Data := Pointer(Fields[3].AsInteger);
        SubItems.Add(Fields[1].AsString);
        SubItems.Add(Fields[2].AsString);
        SubItems.Add(IntToStr(Fields[4].AsInteger));
        SubItems.Add(IntToStr(Fields[5].AsInteger));
      end;
      Next;
    end;
  finally
    Free;
  end;
  // выравнивание ширины колонок
  for i := 0 to lvAthRaces.Columns.Count - 3 do begin
    lvAthRaces.Columns[i].Width := ColumnTextWidth;
  end;
end;

procedure TMainForm.lvAthRacesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  lItem: TListItem;
  i, j, iShift, iBestLap, RACE_ID, ATHLET_ID, TRACK_LENGTH, LAPS: Integer;
  strTIME_PREVIOUS, strTIME_CURRENT: string;
  dtLapTime, dtBesLapTime: TDateTime;
  rLapSpeed: extended;
begin
  btnPrintAthletStats.Enabled := true;
  ATHLET_ID := Integer(lvAthletes.Items[lvAthletes.ItemIndex].Data);
  RACE_ID := Integer(Item.Data);
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // параметры заезда
    SQL.Text := 'select laps,track_length from races where race_id='
      + IntToStr(RACE_ID) + ';';
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    Open;
    LAPS := Fields[0].AsInteger;
    TRACK_LENGTH := Fields[1].AsInteger;
    // время старта
    Close;
    SQL.Text := 'select timenote from timenotes where (race_id='
      + IntToStr(RACE_ID) + ') and (platenumber=0);';
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    Open;
    strTIME_PREVIOUS := Fields[0].AsString;
    // времена кругов
    Close;
    SQL.Text :=
      'select timenotes.tn_id, timenotes.timenote from timenotes, registry '
      + 'where (timenotes.race_id=' + IntToStr(RACE_ID)
      + ') and (timenotes.platenumber = registry.platenumber) and (registry.race_id = '
      + 'timenotes.race_id) and (registry.athlet_id = ' + IntToStr(ATHLET_ID)
      + ') order by timenotes.tn_id;';
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    Open;
    FetchAll;
    lvAthStats.Clear;
    i := 1;
    dtBesLapTime := Now;
    while not(EOF) do begin
      lItem := lvAthStats.Items.Add;
      with lItem do begin
        Caption := IntToStr(i);
        strTIME_CURRENT := Fields[1].AsString;
        dtLapTime := StrToTime(strTIME_CURRENT, fs) - StrToTime(strTIME_PREVIOUS, fs);
        Data := Pointer(iORDINARY_LAP_FLAG);
        // ищем лучший круг
        if dtLapTime < dtBesLapTime then begin
          dtBesLapTime := dtLapTime;
          iBestLap := i;
        end;
        SubItems.Add(FormatTimeNote(dtLapTime));
        // скорость на круге
        if TRACK_LENGTH > 0 then begin
          rLapSpeed := (3600 * TRACK_LENGTH / MilliSecondsBetween(StrToTime(strTIME_PREVIOUS, fs),
            StrToTime(strTIME_CURRENT, fs)) * 1000) / 1000;
        end
        else rLapSpeed := 0;
        strTIME_PREVIOUS := strTIME_CURRENT;
        // определяем место на круге
        with TIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text :=
            'select registry.athlet_id, a.lap, a.timenote from ( '
            + 'select platenumber, count(platenumber) as lap, max(timenote) '
            + 'as timenote from (select platenumber, lap, timenote from (select tn_id, timenote, '
            + 'platenumber, (select count(*) from timenotes b where (b.tn_id < a.tn_id) and '
            + '(a.platenumber = b.platenumber) and (race_id = ' + IntToStr(RACE_ID)
            + ')) + 1 as lap from timenotes a where (race_id = ' + IntToStr(RACE_ID)
            + ')) where lap <= ' + IntToStr(i) + ' order by timenote) '
            + 'group by platenumber order by count(platenumber) desc, max(timenote)) a, '
            + 'registry where (a.platenumber = registry.platenumber) and ' + '(registry.race_id = '
            + IntToStr(RACE_ID) + ') order by a.lap desc, a.timenote;';
          LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
          Open;
          FetchAll;
          j := 1;
          while Fields[0].AsInteger <> ATHLET_ID do begin
            inc(j);
            Next;
          end;
          SubItems.Add(IntToStr(j));
        finally
          Free;
        end;
        // проставляем прогресс
        if i > 1 then begin
          iShift := StrToInt(SubItems.Strings[1]) - StrToInt(lvAthStats.Items[i - 2].SubItems.Strings[1]);
          if iShift = 0 then SubItems.Add(strNO_POSITION_CHANGES);
          if iShift > 0 then SubItems.Add(IntToStr(iShift) + ' ' + strARROW_DOWN);
          if iShift < 0 then SubItems.Add(IntToStr(-iShift) + ' ' + strARROW_UP);
        end
        else
          SubItems.Add(strNO_POSITION_CHANGES);
        // скорость на круге
        SubItems.Add(FloatToStrF(rLapSpeed, ffGeneral, 4, 2));
      end;
      Next;
      inc(i);
    end;
    if iBestLap > 0 then lvAthStats.Items[iBestLap - 1].Data := Pointer(iBEST_LAP_FLAG);
  finally
    Free;
  end;
end;

procedure TMainForm.lvAthStatsCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  with Sender.Canvas do begin
    if Integer(Item.Data) = iBEST_LAP_FLAG then Font.Style := [fsBold];
  end;
end;

procedure TMainForm.lvAthStatsCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  with Sender.Canvas do begin
    if Integer(Item.Data) = iBEST_LAP_FLAG then Font.Style := [fsBold];
  end;
end;

procedure TMainForm.miOpenSnapshotClick(Sender: TObject);
var
  strFileName : string;
  RACE_ID : integer;
begin
  RACE_ID := spNumbersPanel.Tag;
  strFileName := eSnapshotsDir.Text + '\' + IntToStr(RACE_ID) + '.'
    + IntToStr(Integer(lvRacePanel.Selected.Data)) + '.'
    + lvRacePanel.Selected.SubItems.Strings[0] + '.png';
  ShellExecute(0, 'Open', PChar(strFileName), nil, nil, 1);
end;

procedure TMainForm.miRagistrationCancelClick(Sender: TObject);
var
  strRaceName, strAthletName, strAthletBirthDate: string;
  EVENT_ID, RACE_ID, ATHLET_ID: Integer;
begin
  EVENT_ID := chlbRaces.Tag;
  strRaceName := lvRegistered.Items[lvRegistered.ItemIndex].Caption;
  strAthletName := lvRegistered.Items[lvRegistered.ItemIndex].SubItems[1];
  strAthletBirthDate := lvRegistered.Items[lvRegistered.ItemIndex].SubItems[2];
  if RusMessageDialog('Отменить регистрацию ' + strAthletName + ' на ' +
    strRaceName + '?', mtConfirmation, mbYesNo, arrDIALOG_CAPTIONS) = mryes then
  begin
    with TIBQuery.Create(nil) do try
      // извлекаем RACE_ID
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select race_id from races where (event_id='
        + IntToStr(EVENT_ID) + ') and (name=''' + strRaceName + ''');';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      RACE_ID := Fields[0].AsInteger;
      // извлекаем ATHLET_ID
      Close;
      SQL.Text :=
        'select athlet_id from athletes where (name=''' + strAthletName
        + ''') and (date_born=''' + strAthletBirthDate + ''');';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      ATHLET_ID := Fields[0].AsInteger;
    finally
      Free;
    end;
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'delete from registry where (race_id=' + IntToStr(RACE_ID)
        + ') and (athlet_id=' + IntToStr(ATHLET_ID) + ');';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    finally
      Free;
    end;
    cbEventRegistrationChange(Self);
  end;
end;

procedure TMainForm.miRPTimenoteDelClick(Sender: TObject);
var
  TN_ID: Integer;
begin
  TN_ID := Integer(lvRacePanel.Items[lvRacePanel.ItemIndex].Data);
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'delete from timenotes where tn_id=' + IntToStr(TN_ID) + ';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
  finally
    Free;
  end;
  RefreshRacePanel(True);
end;

procedure TMainForm.miRPTimenote1SecPlusClick(Sender: TObject);
var
  i, TN_ID: Integer;
begin
  // вычисляем новый TN_ID
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select max(tn_id) from timenotes;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    TN_ID := Fields[0].AsInteger + 1;
  finally
    Free;
  end;
  // вычисляем время +1 сек от времени выбранной отметки
  eTimenote.Text := FormatTimeNote(IncSecond(StrToTime(lvRacePanel.Selected.Caption + '0', fs), 1));
  // сохраняем TN_ID в sPanel7.Tag
  pnlTimenote.Tag := TN_ID;
  // номера
  cbTimenotePlatenumber.Clear;
  for i := 0 to RaceNumbers.Count - 1 do
    cbTimenotePlatenumber.Items.Add(RaceNumbers[i]);
  eTimenote.Enabled := true;
  cbTimenotePlatenumber.DroppedDown := False;
  pnlTimenote.Show;
end;

procedure TMainForm.miRPTimenoteAdd1SecMinusClick(Sender: TObject);
var
  i, TN_ID: Integer;
begin
  // вычисляем новый TN_ID
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select max(tn_id) from timenotes;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    TN_ID := Fields[0].AsInteger + 1;
  finally
    Free;
  end;
  // вычисляем время -1 сек от времени выбранной отметки
  eTimenote.Text := FormatTimeNote(IncSecond(StrToTime(lvRacePanel.Selected.Caption + '0', fs), -1));
  // сохраняем TN_ID в sPanel7.Tag
  pnlTimenote.Tag := TN_ID;
  // номера
  cbTimenotePlatenumber.Clear;
  for i := 0 to RaceNumbers.Count - 1 do cbTimenotePlatenumber.Items.Add(RaceNumbers[i]);
  eTimenote.Enabled := true;
  cbTimenotePlatenumber.DroppedDown := False;
  pnlTimenote.Show;
end;

procedure TMainForm.miRPTimenoteAddNowClick(Sender: TObject);
var
  i, TN_ID: Integer;
begin
  // вычисляем новый TN_ID
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select max(tn_id) from timenotes;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    TN_ID := Fields[0].AsInteger + 1;
  finally
    Free;
  end;
  // подставляем текущее время (чтоб было удобнее менять)
  eTimenote.Text :=  FormatTimeNote(Now() - TIME_START);
  // сохраняем TN_ID в sPanel7.Tag
  pnlTimenote.Tag := TN_ID;
  // номера
  cbTimenotePlatenumber.Clear;
  for i := 0 to RaceNumbers.Count - 1 do cbTimenotePlatenumber.Items.Add(RaceNumbers[i]);
  eTimenote.Enabled := true;
  cbTimenotePlatenumber.DroppedDown := False;
  pnlTimenote.Show;
end;

procedure TMainForm.miRPTimenoteRenumClick(Sender: TObject);
var
  i: Integer;
begin
  // сохраняем TN_ID в sPanel7.Tag
  pnlTimenote.Tag := Integer(lvRacePanel.Items[lvRacePanel.ItemIndex].Data);
  // номера
  cbTimenotePlatenumber.Clear;
  for i := 0 to RaceNumbers.Count - 1 do cbTimenotePlatenumber.Items.Add(RaceNumbers[i]);
  cbTimenotePlatenumber.Text := lvRacePanel.Items[lvRacePanel.ItemIndex].SubItems.Strings[0];
  eTimenote.Text := lvRacePanel.Items[lvRacePanel.ItemIndex].Caption;
  eTimenote.Enabled := False;
  pnlTimenote.Show;
  cbTimenotePlatenumber.SetFocus;
  cbTimenotePlatenumber.DroppedDown := true;
end;

procedure TMainForm.N3Click(Sender: TObject);
var
  ATHLET_ID : integer;
begin
  pnlEditAthlet.Show;
  pnlEditAthlet.Tag := Integer(lvAthletes.Selected.Data);
  ATHLET_ID := pnlEditAthlet.Tag;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select name,date_born,sex,city,team from athletes where athlet_id='
      + IntToStr(ATHLET_ID) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    eAthName.Text := Fields[0].AsString;
    eAthCity.Text := Fields[3].AsString;
    eAthTeam.Text := Fields[4].AsString;
    chbAthMale.Checked := Fields[2].AsString = 'М';
    chbAthFemale.Checked := Fields[2].AsString = 'Ж';
    deAthBirthdate.Date := Fields[1].AsDateTime;
  finally
    Free;
  end;
  eAthName.SetFocus;
end;

procedure TMainForm.btnRaceEditClick(Sender: TObject);
var
  i: Integer;
  lItem: TListItem;
begin
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text :=
      'select race_id,name,laps,track_length from races where event_id='
      + IntToStr(pnlEvent.Tag) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    i := 0;
    while lbEventRaces.ItemIndex > i do begin
      Next;
      inc(i);
    end;
    // race_id храним в sPanel3.Tag
    pnlRace.Tag := Fields[0].AsInteger;
    eRaceName.Text := Fields[1].AsString;
    eRaceTrackLength.Text := Fields[3].AsString;
    eRaceLaps.Text := Fields[2].AsString;
    // загрузка зачётов
    Close;
    SQL.Text :=
      'select cg_id,sex,agemin,agemax,laps from comp_groups where race_id='
      + IntToStr(pnlRace.Tag) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    lvCompGroups.Clear;
    while not(EOF) do begin
      lItem := lvCompGroups.Items.Add;
      with lItem do begin
        Data := Pointer(Fields[0].AsInteger);
        Caption := Fields[1].AsString;
        if Fields[2].AsInteger > 0 then SubItems.Add(IntToStr(Fields[2].AsInteger))
        else SubItems.Add('-');
        if Fields[3].AsInteger > 0 then SubItems.Add(IntToStr(Fields[3].AsInteger))
        else SubItems.Add('-');
        if Fields[4].AsInteger > 0 then SubItems.Add(IntToStr(Fields[4].AsInteger))
        else SubItems.Add('-');
      end;
      Next;
    end;
  finally
    Free;
  end;
  lbEventRaces.Enabled := False;
  btnRaceNew.Enabled := False;
  btnRaceDelete.Enabled := False;
  btnEventSave.Enabled := False;
  btnEventClose.Enabled := False;
  eEventName.Enabled := False;
  dtpEvent.Enabled := False;
  pnlRace.Show;
  // заезд создан, показываем создание подгрупп
  lblCGList.Show;
  btnCGNew.Show;
  btnCGDelete.Show;
  lvCompGroups.Show;
  pnlCGEdit.Show;
end;

procedure TMainForm.btnRaceDeleteClick(Sender: TObject);
var
  i, RACE_ID: Integer;
  bClear: Boolean;
begin
  if lbEventRaces.ItemIndex <> -1 then begin
    if RusMessageDialog('Удалить заезд "' + lbEventRaces.Items.Strings[lbEventRaces.ItemIndex]
      + '"?', mtConfirmation, mbYesNo, arrDIALOG_CAPTIONS) = mryes
    then with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // поиск RACE_ID для удаления
      with TIBQuery.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        SQL.Text :=
          'select race_id,name,laps,track_length,status from races where event_id='
          + IntToStr(pnlEvent.Tag) + ';';
        Open;
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
        FetchAll;
        First;
        i := 0;
        while lbEventRaces.ItemIndex > i do begin
          Next;
          inc(i);
        end;
        RACE_ID := Fields[0].AsInteger;
        bClear := Fields[4].AsString = '';
      finally
        Free;
      end;
      SQL.Text := 'delete from races where race_id=' + IntToStr(RACE_ID) + ';';
      if bClear then ExecQuery
      else ShowMessage(strUNABLE_TO_DELETE_STARTED_RACE);
    finally
      Free;
    end;
    // refresh
    btnEventEditClick(Self);
  end
  else ShowMessage(strRACE_NOT_DELECTED);
end;

procedure TMainForm.btnRaceSaveClick(Sender: TObject);
var
  RACE_ID : integer;
begin
  // если в RACES пусто, берём RACE_ID=1
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select max(race_id) from races';
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    Open;
    if Fields[0].IsNull then RACE_ID := 1 else RACE_ID := Fields[0].AsInteger + 1;
  finally
    Free;
  end;
  // запись данных
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // если создать
    if pnlRace.Tag = 0 then
      SQL.Text :=
        'insert into races(race_id,event_id,name,laps,track_length) '
        + 'values(' + IntToStr(RACE_ID) + ','
        + IntToStr(pnlEvent.Tag) + ',''' + eRaceName.Text + ''','
        + eRaceLaps.Text + ',' + eRaceTrackLength.Text + ');'
      // если изменить
    else
      SQL.Text := 'update races set name=''' + eRaceName.Text + ''',laps='
        + eRaceLaps.Text + ',track_length=' + eRaceTrackLength.Text
        + ' where race_id=' + IntToStr(pnlRace.Tag) + ';';
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    ExecQuery;
    pnlRace.Hide;
  finally
    Free;
  end;
  btnEventSave.Enabled := true;
  btnEventClose.Enabled := true;
  btnRaceNew.Enabled := true;
  btnRaceEdit.Enabled := true;
  btnRaceDelete.Enabled := true;
  lbEventRaces.Enabled := true;
  eEventName.Enabled := true;
  dtpEvent.Enabled := true;
  // refresh
  btnEventEditClick(Self);
end;

procedure TMainForm.btnRaceCloseClick(Sender: TObject);
begin
  pnlRace.Hide;
  btnEventSave.Enabled := true;
  btnEventClose.Enabled := true;
  btnRaceNew.Enabled := true;
  btnRaceEdit.Enabled := true;
  btnRaceDelete.Enabled := true;
  lbEventRaces.Enabled := true;
  eEventName.Enabled := true;
  dtpEvent.Enabled := true;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
var
  i, EVENT_ID: Integer;
begin
  if tsRegistration.Visible then begin
    // Если прееход с регистрации
    EVENT_ID := chlbRaces.Tag;
  end;
  if tsEvent.Visible then begin
    // Если переход со списка соревнований
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text :=
        'select event_id,event_date,name from events order by event_date;';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      First;
      i := 0;
      while lbEvents.ItemIndex > i do begin
        Next;
        inc(i);
      end;
      // event_id храним в sPanel2.Tag
      EVENT_ID := Fields[0].AsInteger;
    finally
      Free;
    end;
  end;
  if tsStart.Visible then begin
    // если с самой себя
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text :=
        'select event_id,event_date,name from events order by event_date;';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      First;
      i := 0;
      while cbEvent.ItemIndex > i do begin
        Next;
        inc(i);
      end;
      // event_id храним в sPanel2.Tag
      EVENT_ID := Fields[0].AsInteger;
    finally
      Free;
    end;
  end;

  // сохраняем event_id в sComboBox4.Tag
  cbRace.Tag := EVENT_ID;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // список мероприятий
    SQL.Text := 'select event_id,event_date,name from events order by event_date;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    cbEvent.Items.Clear;
    i := 0;
    while not(EOF) do begin
      cbEvent.Items.Add(Fields[2].AsString);
      // выбранное мероприятие
      if Fields[0].AsInteger = EVENT_ID then cbEvent.ItemIndex := i;
      inc(i);
      Next;
    end;
    // список заездов
    Close;
    SQL.Text := 'select race_id,laps,track_length,name,status from races where event_id='
      + IntToStr(EVENT_ID) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    cbRace.Items.Clear;
    while not(EOF) do begin
      cbRace.Items.Add(Fields[3].AsString);
      Next;
    end;
    if cbRace.Items.Count > 0 then begin
      cbRace.ItemIndex := 0;
      spRacePanel.Show;
      // refresh
      cbRaceChange(Self);
    end
    else spRacePanel.Hide;
  finally
    Free;
  end;
  tsStart.Show;
  pcStart.ActivePage := tsStartPrep;
  btnAthletes.Font.Style := [];
  btnEvents.Font.Style := [];
  btnRegistration.Font.Style := [];
  btnStart.Font.Style := [fsBold];
  btnSettings.Font.Style := [];
end;

procedure TMainForm.btnAthletNewClick(Sender: TObject);
begin
  eAthletName.Tag := 0;
  eAthletName.Clear;
  eTeam.Clear;
  eCity.Clear;
  chbSexMale.Checked := true;
  chbSexFemale.Checked := False;
  dtpAthlet.Date := Now;
  eAthletName.ReadOnly := False;
  eTeam.ReadOnly := False;
  eCity.ReadOnly := False;
  eAthletSearch.Hide;
  btnAthletSearch.Hide;
end;

procedure TMainForm.btnFindAthletClick(Sender: TObject);
begin
  eAthletSearch.Text := '';
  eAthletSearch.Show;
  btnAthletSearch.Show;
  eAthletSearch.SetFocus;
end;

procedure TMainForm.btnPlatesCountClick(Sender: TObject);
begin
  if ePlatesCount.Text <> '' then
    Config.WriteInteger('General', 'PlateNumbers', StrToInt(ePlatesCount.Text));
  iPlatenumbersCount :=
    Config.ReadInteger('General', 'PlateNumbers', iPLATENUMBERS_COUNT_DEFAULT);
end;

procedure TMainForm.btnPrintAthletStatsClick(Sender: TObject);
begin
  frUserDataset.RangeEnd := reCount;
  frUserDataset.RangeEndCount := lvAthStats.Items.Count;
  frAthletStats.ShowReport;
end;

procedure TMainForm.btnSettingsClick(Sender: TObject);
begin
  btnStart.Enabled := false;
  btnRegistration.Enabled := false;
  btnAthletes.Font.Style := [];
  btnEvents.Font.Style := [];
  btnRegistration.Font.Style := [];
  btnStart.Font.Style := [];
  btnSettings.Font.Style := [fsBold];
  tsSettings.Show;
end;

procedure TMainForm.btnSnapshotDelayClick(Sender: TObject);
begin
  if btnSnapshotDelay.Caption = strSNAPSHOT_DELAY_STOP then begin
    btnSnapshotDelay.Caption := strSNAPSHOT_DELAY_CALIBRATION;
    dtSnapshotClbrStop := Now;
    iSnapshotDelay := MilliSecondsBetween(dtSnapshotClbrStop, dtSnapshotClbrStart);
    eSnapshotDelay.Text := IntToStr(iSnapshotDelay);
    Config.WriteInteger('DVR', 'CameraDelayMS', iSnapshotDelay);
  end;
  if btnSnapshotDelay.Caption = strSNAPSHOT_DELAY_START then begin
    btnSnapshotDelay.Caption := strSNAPSHOT_DELAY_STOP;
    dtSnapshotClbrStart := Now;
  end;
  if btnSnapshotDelay.Caption = strSNAPSHOT_DELAY_CALIBRATION then begin
    btnSnapshotDelay.Caption := strSNAPSHOT_DELAY_START;
  end;
end;

procedure TMainForm.btnRegisterClick(Sender: TObject);
var
  i, EVENT_ID, ATHLET_ID, RACE_ID, REG_ID: Integer;
  SEX: string;
  bRacesSelected: Boolean;
begin
  bRacesSelected := False;
  // сначала смотрим выбраны ли вообще заезды
  for i := 0 to chlbRaces.Items.Count - 1 do
    if chlbRaces.Checked[i] then bRacesSelected := true;
  // проверяем заполнение обязательных полей
  if (eAthletName.Text <> '') and (cbRegisterNumberplate.Text <> '')
    and bRacesSelected
  then begin
    EVENT_ID := chlbRaces.Tag;
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // добавляем (выбираем) участника. признак (новый/неновый) - sEdit5.Tag
      if eAthletName.Tag = 0 then begin
        // если новый участник
        if chbSexMale.Checked then SEX := 'М' else SEX := 'Ж';
        // получаем ATHLET_ID
        with TIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text := 'select max(athlet_id) from athletes;';
          Open;
          LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
          FetchAll;
          ATHLET_ID := Fields[0].AsInteger + 1;
        finally
          Free;
        end;
        SQL.Text :=
          'insert into athletes(athlet_id,name,date_born,sex,team,city) values('
          + IntToStr(ATHLET_ID) + ',''' + eAthletName.Text + ''','''
          + FormatDateTime(strSIMPLE_DATEFORMAT, dtpAthlet.Date)
          + ''',''' + SEX + ''',''' + eTeam.Text + ''',''' + eCity.Text + ''');';
        ExecQuery;
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      end
      else begin
        // если участник выбран через поиск
        ATHLET_ID := eAthletName.Tag;
      end;
      // выбираем гонки для регистрации
      for i := 0 to chlbRaces.Count - 1 do if chlbRaces.Checked[i] then begin
        // извлекаем RACE_ID
        with TIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text :=
            'select race_id,name,track_length,laps from races where event_id='
            + IntToStr(EVENT_ID) + ';';
          Open;
          LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
          FetchAll;
          First;
          while not(EOF) and (chlbRaces.Items.Strings[i] <> Fields[1].AsString) do begin
            Next;
          end;
          RACE_ID := Fields[0].AsInteger;
        finally
          Free;
        end;
        // регистрируем на гонку
        Close;
        // получаем REG_ID
        with TIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text := 'select max(reg_id) from registry;';
          Open;
          LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
          FetchAll;
          REG_ID := Fields[0].AsInteger + 1;
        finally
          Free;
        end;
        SQL.Text :=
          'insert into registry(reg_id,platenumber,athlet_id,race_id) values('
          + IntToStr(REG_ID) + ',' + cbRegisterNumberplate.Text + ','
          + IntToStr(ATHLET_ID) + ',' + IntToStr(RACE_ID) + ');';
        ExecQuery;
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      end;
    finally
      Free;
    end;
    // refresh
    cbEventRegistrationChange(Self);
    btnAthletNewClick(Self);
  end
  else ShowMessage(strREQUIRED_FIELDS_MISSING);
end;

procedure TMainForm.SelectAthlet(Sender: TObject);
var
  ATHLET_ID: Integer;
begin
  ATHLET_ID := (Sender as TMenuItem).Tag;
  // сохраняем ATHLET_ID в sEdit5.Tag для последующего избежания добавления нового участника
  eAthletName.Tag := ATHLET_ID;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text :=
      'select name,date_born,sex,team,city from athletes where athlet_id='
      + IntToStr(ATHLET_ID) + ' order by name;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    eAthletName.Text := Fields[0].AsString;
    eTeam.Text := Fields[3].AsString;
    eCity.Text := Fields[4].AsString;
    dtpAthlet.Date := Fields[1].AsDateTime;
    chbSexMale.Checked := Fields[2].AsString = 'М';
    chbSexFemale.Checked := not(chbSexMale.Checked);
  finally
    Free;
  end;
  eAthletName.ReadOnly := true;
  eTeam.ReadOnly := true;
  eCity.ReadOnly := true;
  eAthletSearch.Hide;
  btnAthletSearch.Hide;
end;

procedure TMainForm.btnAthletSearchClick(Sender: TObject);
var
  mItem: TMenuItem;
  ATHLET_ID: Integer;
  isRegistered: Boolean;
begin
  pmAthletSearch.Items.Clear;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text :=
      'select athlet_id,name,date_born,sex,team,city from athletes where name like ''%'
      + eAthletSearch.Text + '%'' order by name;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    while not(EOF) do begin
      // поиск среди уже зарегистрированных
      ATHLET_ID := Fields[0].AsInteger;
      with TIBQuery.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        SQL.Text :=
          'select * from registry,races where (registry.race_id=races.race_id)'
          + 'and(athlet_id=' + IntToStr(ATHLET_ID)
          + ')and(races.event_id=' + IntToStr(chlbRaces.Tag) + ');';
        Open;
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
        FetchAll;
        isRegistered := RecordCount > 0;
      finally
        Free;
      end;
      if not(isRegistered) then begin
        mItem := TMenuItem.Create(pmAthletSearch);
        mItem.Caption := Fields[1].AsString + ', '
          + FormatDateTime (strSIMPLE_DATEFORMAT, Fields[2].AsDateTime)
          + ' (' + Fields[5].AsString + ')';
        // сохраняем athlet_id в mItem.Tag
        mItem.Tag := ATHLET_ID;
        mItem.onClick := SelectAthlet;
        pmAthletSearch.Items.Add(mItem);
      end;
      Next;
    end;
    pmAthletSearch.Popup(Left + eAthletSearch.Left,
      Top + pnlMainMenu.Height + eAthletName.Top + eAthletName.Height);
  finally
    Free;
  end;
end;

procedure TMainForm.btnAthletesClick(Sender: TObject);
begin
  btnStart.Enabled := false;
  btnRegistration.Enabled := false;
  btnAthletes.Font.Style := [fsBold];
  btnEvents.Font.Style := [];
  btnRegistration.Font.Style := [];
  btnStart.Font.Style := [];
  btnSettings.Font.Style := [];
  tsAthletes.Show;
end;

procedure TMainForm.btnRaceConfirmClick(Sender: TObject);
var
  i, j: Integer;
  Buffer: TStringList;
  str: string;
begin
  btnRaceStart.Enabled := true;
  // исключаем не прошедших проверку
  Buffer := TStringList.Create;
  for i := 0 to chlbAthletes.Count - 1 do begin
    if chlbAthletes.Checked[i] then Buffer.Add(RaceNumbers[i]);
  end;
  RaceNumbers.Clear;
  for i := 0 to Buffer.Count - 1 do RaceNumbers.Add(Buffer[i]);
  Buffer.Free;
  // отмечаем гонку как стартовавшую
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // берём race_id из sCheckListBox2.Tag
    SQL.Text := 'update races set status=''' + strRACE_STATUS_STARTED
      + ''' where race_id=' + IntToStr(chlbAthletes.Tag) + ';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
  finally
    Free;
  end;
  chlbAthletes.Enabled := False;
  lblRaceStatus.Caption := strREADY_TO_RACE;
end;

procedure TMainForm.btnRaceStartClick(Sender: TObject);
begin
  RefreshRacePanel(True);
  tsRacePanel.Show;
  spRacePanel.Enabled := true;
  btnStpwtchFinish.Enabled := true;
  if not(btnStpwtchStart.Enabled) then RepaintNumberButtons(Sender);
end;

procedure TMainForm.btnStpwtchStartClick(Sender: TObject);
var
  RACE_ID, LAST_TN_ID: Integer;
begin
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select max(tn_id) from timenotes;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    LAST_TN_ID := Fields[0].AsInteger;
  finally
    Free;
  end;
  RACE_ID := chlbAthletes.Tag;
  TIME_START := Now();
  // фигарим в базу номер "0" - признак старта заезда
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text :=
      'insert into timenotes(tn_id,race_id,platenumber,timenote) values('
      + IntToStr(LAST_TN_ID + 1) + ',' + IntToStr(RACE_ID)
      + ',0,''' + FormatDateTime(strTIMENOTE_FORMAT, TIME_START) + ''');';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    btnStpwtchStart.Enabled := False;
    Timer.Enabled := true;
  finally
    Free;
  end;
  spRacePanel.Enabled := true;
  btnStpwtchStart.Enabled := False;
  // выводим сколько осталось кругов
  // и запихиваем в Tag кнопки ФИНИШ
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select laps from races where race_id=' + IntToStr(RACE_ID) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    btnStpwtchFinish.Tag := Fields[0].AsInteger;
    btnStpwtchFinish.Caption := IntToStr(btnStpwtchFinish.Tag) + strLAPSTOGO;
    btnStpwtchFinish.Enabled := true;
  finally
    Free;
  end;
  RepaintNumberButtons(Sender);
  // стартуем видео с камеры, если надо
  if chbEnableSnapshots.Checked then begin
    LoadVLCLib;
    StartDVRPlaybackAt(eDVRUrl.Text, pnlDVRPlayback.Handle);
  end;
end;

procedure TMainForm.btnStpwtchFinishClick(Sender: TObject);
var
  i, RACE_ID: Integer;
  strSEX, strAGEMIN, strAGEMAX: string;
  Item: TControl;
begin
  if RusMessageDialog(strCOMPLETE_RACE, mtConfirmation, mbYesNo,
    arrDIALOG_CAPTIONS) = mryes then
  begin
    Timer.Enabled := False;
    // забираем RACE_ID из spNumbersPanel.Tag
    RACE_ID := spNumbersPanel.Tag;
    btnStpwtchStart.Enabled := true;
    Timer.Enabled := False;
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'update races set status=''' + strRACE_STATUS_FINISHED
        + ''' where race_id=' + IntToStr(RACE_ID) + ';';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    finally
      Free;
    end;
    // сохраняем RACE_ID в sComboBox6.Tag
    cbResultsCG.Tag := RACE_ID;
    tsRaceResults.Show;
    btnStpwtchFinish.Enabled := False;
    // refresh
    cbResultsCGChange(Self);
    // останавливаем видео с камеры, если надо
    if chbEnableSnapshots.Checked then begin
      StopDVRPlayback(vlcMediaPlayer);
      FreeLibrary(vlclib);
    end;
  end;
end;

procedure TMainForm.btnDropAllTimenotesClick(Sender: TObject);
begin
  if RusMessageDialog(strDROP_ALL_TIMENOTES, mtConfirmation, mbYesNo,
    arrDIALOG_CAPTIONS) = mryes then
  begin
    // зачиcтка данных ВСЕХ заездов
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // все гонки в процессе переводим в нестартованные
      SQL.Text := 'update races set status='''' where status='''
        + strRACE_STATUS_STARTED + ''';';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      Close;
      // все завершённые гонки в переводим в нестартованные
      SQL.Text := 'update races set status='''' where status='''
        + strRACE_STATUS_FINISHED + ''';';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      Close;
      // вычищаем все временные отметки
      SQL.Text := 'delete from timenotes;';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      // чистка мусора (финт ушами)
      with TIBQuery.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        SQL.Text := 'select count(*) from timenotes;';
        Open;
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      finally
        Free;
      end;
      // конец чистки мусора
    finally
      Free;
    end;
  end;
end;

procedure TMainForm.btnDVRIndicatorClick(Sender: TObject);
begin
  GetSnapshot(vlcMediaPlayer, eSnapshotsDir.Text + '\UserSnapshot-'
    + FormatDateTime(strTIMENOTE_FORMAT, Now) + '.png');
end;

procedure TMainForm.btnDVRTestPlayClick(Sender: TObject);
begin
  LoadVLCLib;
  StartDVRPlaybackAt(eDVRUrl.Text, pnlDRVTest.Handle);
  btnDVRTestPlay.Enabled := false;
  btnDVRTestStop.Enabled := true;
  btnDVRTestSnapshot.Enabled := true;
  btnSnapshotDelay.Enabled := true;
end;

procedure TMainForm.btnDVRTestSnapshotClick(Sender: TObject);
var
  strFileName : string;
begin
  CreateDir(eSnapshotsDir.Text);
  strFileName :=
    eSnapshotsDir.Text + '\TestSnapshot-' + FormatDateTime(strFS_VALID_FORMAT, Now) + '.png';
  // отработка задержки
  LogIt(llDEBUG, 'Snapshot delay ' + IntToStr(iSnapshotDelay) + ' ms');
  Sleep(iSnapshotDelay);
  LogIt(llDEBUG, 'Snapshot at ' + strFileName);
  GetSnapshot(vlcMediaPlayer, strFileName);
  if RusMessageDialog(strVIEW_TEST_SNAPSHOT, mtConfirmation, mbYesNo, arrDIALOG_CAPTIONS) = mryes
  then
    ShellExecute(0, 'Open', PChar(strFileName), nil, nil, 1);
end;

procedure TMainForm.btnDVRTestStopClick(Sender: TObject);
begin
  StopDVRPlayback(vlcMediaPlayer);
  FreeLibrary(vlclib);
  btnDVRTestPlay.Enabled := true;
  btnDVRTestStop.Enabled := false;
  btnDVRTestSnapshot.Enabled := false;
  btnSnapshotDelay.Enabled := false;
end;

procedure TMainForm.btnTimenoteOKClick(Sender: TObject);
var
  i, TN_ID, RACE_ID: Integer;
  strTIMENOTE, StrAbsTime: string;
  bValidData: Boolean;
begin
  // берём TN_ID из sPanel7.Tag
  TN_ID := pnlTimenote.Tag;
  // берём RACE_ID из spNumbersPanel.Tag
  RACE_ID := spNumbersPanel.Tag;
  // проверяем корректность данных
  bValidData := False;
  for i := 0 to RaceNumbers.Count - 1 do
    if RaceNumbers.Strings[i] = cbTimenotePlatenumber.Text then bValidData := true;
  strTIMENOTE := eTimenote.Text;
  if (strTIMENOTE[3] <> ':') or (strTIMENOTE[6] <> ':') or (strTIMENOTE[9] <> '.') then
    bValidData := False;
  // если ОК, пишем в базу
  if bValidData then begin
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // признак добавления/изменения - sEdit10.Enabled
      if eTimenote.Enabled then begin
        // вычисляем и пишем абсолютное время (время старта + время отметки )
        StrAbsTime := FormatDateTime(strTIMENOTE_FORMAT, TIME_START + StrToTime(strTIMENOTE, fs));
        SQL.Text :=
          'insert into timenotes(tn_id,platenumber,race_id,timenote) values('
          + IntToStr(TN_ID) + ',' + cbTimenotePlatenumber.Text + ','
          + IntToStr(RACE_ID) + ',''' + StrAbsTime + ''');'
      end
      else
        SQL.Text := 'update timenotes set platenumber='
          + cbTimenotePlatenumber.Text + ' where TN_ID=' + IntToStr(TN_ID) + ';';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    finally
      Free;
    end;
    RefreshRacePanel(True);
    pnlTimenote.Hide;
  end
  else ShowMessage(strINVALID_TIMENOTE_DATA);
end;

procedure TMainForm.btnTimenoteCancelClick(Sender: TObject);
begin
  pnlTimenote.Hide;
end;

procedure TMainForm.btnCGNewClick(Sender: TObject);
begin
  chbCGMale.Checked := False;
  chbCGFemale.Checked := False;
  chbCGAgeMin.Checked := False;
  chbCGAgeMax.Checked := False;
  eCGAgeMin.Enabled := False;
  eCGAgeMin.Clear;
  eCGAgeMax.Enabled := False;
  eCGAgeMax.Clear;
  eCGLaps.Text := eRaceLaps.Text;
  pnlCGEdit.Show;
  btnCGDelete.Enabled := False;
end;

procedure TMainForm.btnCGDeleteClick(Sender: TObject);
begin
  if lvCompGroups.ItemIndex <> -1 then begin
    if RusMessageDialog(strDELETE_COMP_GROUP, mtConfirmation, mbYesNo,
      arrDIALOG_CAPTIONS) = mryes then
    begin
      with TIBSQL.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        SQL.Text := 'delete from comp_groups where cg_id='
          + IntToStr(Integer(lvCompGroups.Items[lvCompGroups.ItemIndex].Data)) + ';';
        ExecQuery;
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      finally
        Free;
      end;
      // refresh
      btnRaceEditClick(Self);
    end;
  end
  else ShowMessage(strCOMP_GROUP_NOT_SELECTED);
end;

function ScrollBarVisible(Handle: HWnd; Style: Longint): Boolean;
begin
  Result := (GetWindowLong(Handle, GWL_STYLE) and Style) <> 0;
end;

procedure TMainForm.btnEventsClick(Sender: TObject);
begin
  btnAthletes.Font.Style := [];
  btnEvents.Font.Style := [fsBold];
  btnRegistration.Font.Style := [];
  btnStart.Font.Style := [];
  btnSettings.Font.Style := [];
  tsEvent.Show;
end;

procedure TMainForm.btnCGSaveClick(Sender: TObject);
var
  CG_ID, RACE_ID, AGEMIN, AGEMAX, LAPS: Integer;
  SEX: string;
begin
  RACE_ID := pnlRace.Tag;
  // новый CG_ID
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select max(cg_id) from comp_groups;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    CG_ID := Fields[0].AsInteger + 1;
  finally
    Free;
  end;
  SEX := '-';
  if chbCGMale.Checked then SEX := 'М';
  if chbCGFemale.Checked then SEX := 'Ж';
  if chbCGAgeMin.Checked then AGEMIN := StrToInt(eCGAgeMin.Text) else AGEMIN := 0;
  if chbCGAgeMax.Checked then AGEMAX := StrToInt(eCGAgeMax.Text) else AGEMAX := 0;
  if StrToInt(eCGLaps.Text) > StrToInt(eRaceLaps.Text) then eCGLaps.Text := eRaceLaps.Text;
  if eCGLaps.Text <> '' then LAPS := StrToInt(eCGLaps.Text) else LAPS := 0;

  // херачим в базу новую зачётную группу
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text :=
      'insert into comp_groups(cg_id,race_id,sex,agemin,agemax,laps) values('
      + IntToStr(CG_ID) + ',' + IntToStr(RACE_ID)
      + ',''' + SEX + ''',' + IntToStr(AGEMIN) + ',' + IntToStr(AGEMAX)
      + ',' + IntToStr(LAPS) + ');';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
  finally
    Free;
  end;
  pnlCGEdit.Hide;
  btnCGDelete.Enabled := true;
  // refresh
  btnRaceEditClick(Self);
end;

procedure TMainForm.btnCGCloseClick(Sender: TObject);
begin
  pnlCGEdit.Hide;
  btnCGDelete.Enabled := true;
end;

procedure TMainForm.btnRaceResultsClick(Sender: TObject);
begin
  tsRaceResults.Show;
  Timer.Enabled := False;
  spRacePanel.Enabled := true;
  btnStpwtchFinish.Enabled := False;
  // refresh
  cbResultsCGChange(Self);
end;

procedure TMainForm.btnRegistrationClick(Sender: TObject);
var
  i: Integer;
begin
  btnAthletes.Font.Style := [];
  btnEvents.Font.Style := [];
  btnRegistration.Font.Style := [fsBold];
  btnStart.Font.Style := [];
  btnSettings.Font.Style := [];
  tsRegistration.Show;
  cbEventRegistration.ItemIndex := lbEvents.ItemIndex;
  cbEventRegistrationChange(Self);
end;

procedure TMainForm.btnResultsPrintClick(Sender: TObject);
begin
  frUserDataset.RangeEnd := reCount;
  frUserDataset.RangeEndCount := lvResults.Items.Count;
  frResults.ShowReport;
end;

procedure TMainForm.btnEventNewClick(Sender: TObject);
begin
  eEventName.Clear;
  pnlEvent.Tag := 0;
  pnlEventRaces.Hide;
  pnlEvent.Show;
  eEventName.SetFocus;
  lbEvents.Enabled := False;
  btnEventEdit.Enabled := False;
  btnEventDelete.Enabled := False;
end;

procedure TMainForm.btnEventResultsClick(Sender: TObject);
begin
  btnStartClick(Sender);
  cbRaceChange(Sender);
end;

procedure TMainForm.btnEventSaveClick(Sender: TObject);
var
  EVENT_ID : integer;
begin
  // если в EVENTS пусто, берём EVENT_ID=1
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select max(event_id) from events;';
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    Open;
    if Fields[0].IsNull then EVENT_ID := 1 else EVENT_ID := Fields[0].AsInteger + 1;
  finally
    Free;
  end;
  // запись данных
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // если создать
    if pnlEvent.Tag = 0 then
      SQL.Text :=
        'insert into events(event_id,event_date,name) values(' + IntToStr(EVENT_ID) + ','''
        + FormatDateTime(strSIMPLE_DATEFORMAT, dtpEvent.Date) + ''',''' + eEventName.Text + ''')'
      // изменить
    else
      SQL.Text := 'update events set name=''' + eEventName.Text +
        ''',event_date=''' + FormatDateTime(strSIMPLE_DATEFORMAT,
        dtpEvent.Date) + ''' where event_id=' + IntToStr(pnlEvent.Tag) + ';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    pnlEvent.Hide;
  finally
    Free;
  end;
  // обновить список
  tsEventShow(Self);
  lbEvents.Enabled := true;
  btnEventNew.Enabled := true;
  btnEventDelete.Enabled := true;
  btnEventEdit.Enabled := true;
  lbEvents.SetFocus;
end;

procedure TMainForm.btnEventDeleteClick(Sender: TObject);
var
  i, EVENT_ID: Integer;
  bClear: Boolean;
begin
  if RusMessageDialog('Удалить мероприятие "' + lbEvents.Items.Strings
      [lbEvents.ItemIndex] + '"?', mtConfirmation, mbYesNo, arrDIALOG_CAPTIONS) = mryes
  then with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    with TIBQuery.Create(nil) do try
      // поиск EVENT_ID для удаления
      Database := DBase;
      Transaction := DBTran;
      SQL.Text :=
        'select event_id,event_date,name from events order by event_date;';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      First;
      i := 0;
      while lbEvents.ItemIndex > i do begin
        Next;
        inc(i);
      end;
      EVENT_ID := Fields[0].AsInteger;
      // проверка статуса гонок
      Close;
      SQL.Text := 'select status from races where event_id=' + IntToStr(EVENT_ID) + ';';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      bClear := true;
      while not(EOF) do begin
        bClear := (bClear) and (Fields[0].AsString = '');
        Next;
      end;
    finally
      Free;
    end;
    if bClear then begin
      SQL.Text := 'delete from races where event_id=' + IntToStr(EVENT_ID)
        + ';';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      Close;
      SQL.Text := 'delete from events where event_id=' + IntToStr(EVENT_ID)
        + ';';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    end
    else ShowMessage(strUNABLE_TO_DELETE_STARTED_EVENT);
  finally
    Free;
  end;
end;

procedure TMainForm.btnEventEditClick(Sender: TObject);
var
  i: Integer;
begin
  lbEventRaces.Clear;
  lbEvents.Enabled := False;
  btnEventNew.Enabled := False;
  btnEventDelete.Enabled := False;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text :=
      'select event_id,event_date,name from events order by event_date;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    i := 0;
    while lbEvents.ItemIndex > i do begin
      Next;
      inc(i);
    end;
    eEventName.Text := Fields[2].AsString;
    dtpEvent.Date := Fields[1].AsDateTime;
    // event_id храним в sPanel2.Tag
    pnlEvent.Tag := Fields[0].AsInteger;
    // выбираем заезды
    Close;
    SQL.Text :=
      'select race_id,name,track_length,laps from races where event_id='
      + IntToStr(pnlEvent.Tag) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    while not(EOF) do begin
      lbEventRaces.Items.Add(Fields[1].AsString + ' ('  + IntToStr(Fields[3].AsInteger)
        + 'кр. по ' + IntToStr(Fields[2].AsInteger) + 'м)');
      Next;
    end;
  finally
    Free;
  end;
  pnlEvent.Show;
  pnlEventRaces.Show;
end;

procedure TMainForm.btnEditAthCloseClick(Sender: TObject);
begin
  pnlEditAthlet.Hide;
end;

procedure TMainForm.btnEditAthSaveClick(Sender: TObject);
var
  ATHLET_ID : integer;
  strSEX : string;
begin
  ATHLET_ID := pnlEditAthlet.Tag;
  if chbAthMale.Checked then strSEX := 'М' else strSEX := 'Ж';
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'update athletes set name=''' + eAthName.Text + ''', team='''
      + eAthTeam.Text + ''', city=''' + eAthCity.Text + ''', sex=''' + strSEX
      + ''', date_born=''' + FormatDateTime(strSIMPLE_DATEFORMAT, deAthBirthdate.Date)
      + ''' where athlet_id=' + IntToStr(ATHLET_ID) + ';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
  finally
    Free;
  end;
  pnlEditAthlet.Hide;
  //refresh
  tsAthletes.OnShow(Self);
end;

procedure TMainForm.btnEventCloseClick(Sender: TObject);
begin
  pnlEvent.Hide;
  lbEvents.Enabled := true;
  btnEventNew.Enabled := true;
  btnEventDelete.Enabled := true;
  btnEventEdit.Enabled := true;
  lbEvents.SetFocus;
end;

procedure TMainForm.btnRaceNewClick(Sender: TObject);
begin
  eRaceName.Clear;
  eRaceTrackLength.Clear;
  eRaceLaps.Clear;
  pnlRace.Tag := 0;
  pnlRace.Show;
  btnEventSave.Enabled := False;
  btnEventClose.Enabled := False;
  lvCompGroups.Clear;
  eRaceName.SetFocus;
  // пока не создан заезд, прячем создание подгрупп
  lblCGList.Hide;
  btnCGNew.Hide;
  btnCGDelete.Hide;
  lvCompGroups.Hide;
  pnlCGEdit.Hide;
end;

procedure TMainForm.chbSexMaleClick(Sender: TObject);
begin
  chbSexFemale.Checked := not(chbSexMale.Checked);
end;

procedure TMainForm.chbSexFemaleClick(Sender: TObject);
begin
  chbSexMale.Checked := not(chbSexFemale.Checked);
end;

procedure TMainForm.chbCGMaleClick(Sender: TObject);
begin
  chbCGFemale.Checked := not(chbCGMale.Checked);
end;

procedure TMainForm.chbEnableSnapshotsClick(Sender: TObject);
begin
  Config.WriteBool('DVR', 'Enabled', chbEnableSnapshots.Checked);
  eDVRUrl.Enabled := chbEnableSnapshots.Checked;
  eSnapshotsDir.Enabled := chbEnableSnapshots.Checked;
  btnDVRTestPlay.Enabled := chbEnableSnapshots.Checked;
  btnDVRIndicator.Enabled := chbEnableSnapshots.Checked;
end;

procedure TMainForm.chbCGFemaleClick(Sender: TObject);
begin
  chbCGMale.Checked := not(chbCGFemale.Checked);
end;

procedure TMainForm.chbCGAgeMinClick(Sender: TObject);
begin
  eCGAgeMin.Enabled := chbCGAgeMin.Checked;
  if chbCGAgeMin.Checked then eCGAgeMin.SetFocus;
end;

procedure TMainForm.chbAthFemaleClick(Sender: TObject);
begin
  chbAthMale.Checked := not(chbAthFemale.Checked);
end;

procedure TMainForm.chbAthMaleClick(Sender: TObject);
begin
  chbAthFemale.Checked := not(chbAthMale.Checked);
end;

procedure TMainForm.chbCGAgeMaxClick(Sender: TObject);
begin
  eCGAgeMax.Enabled := chbCGAgeMax.Checked;
  if chbCGAgeMax.Checked then eCGAgeMax.SetFocus;
end;

procedure TMainForm.cbEventRegistrationChange(Sender: TObject);
var
  EVENT_ID, i, j: Integer;
  lItem: TListItem;
begin
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select event_id,event_date,name from events order by event_date;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    i := 0;
    while cbEventRegistration.ItemIndex > i do begin
      Next;
      inc(i);
    end;
    EVENT_ID := Fields[0].AsInteger;
    // сохраним EVENT_ID в sCheckListBox1.Tag
    chlbRaces.Tag := EVENT_ID;
    // список заездов
    Close;
    // выбираем только те заезды, дял которых поле STATUS пустое (т.е. не начатые)
    SQL.Text := 'select race_id,name,track_length,laps from races where (event_id='
      + IntToStr(EVENT_ID) + ') and ((status = '''') or (status is null));';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    chlbRaces.Clear;
    while not(EOF) do begin
      chlbRaces.Items.Add(Fields[1].AsString);
      Next;
    end;
    // выбираем недоступные для регистрации заезды
    Close;
    SQL.Text := 'select race_id,name,track_length,laps from races where (event_id='
      + IntToStr(EVENT_ID) + ') and (status <> '''') and not(status is null);';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    lbUnavailableRaces.Clear;
    while not(EOF) do begin
      lbUnavailableRaces.Items.Add(Fields[1].AsString);
      Next;
    end;
    // список уже зарегистрировавшихся, выдача свободных номеров
    cbRegisterNumberplate.Items.Clear;
    for i := 1 to iPlatenumbersCount do cbRegisterNumberplate.Items.Add(IntToStr(i));
    Close;
    SQL.Text :=
      'select distinct registry.platenumber, athletes.name, athletes.date_born, races.name, races.race_id '
      + 'from registry, athletes, races, events where (registry.race_id = races.race_id) and (races.event_id = events.event_id)'
      + 'and (athletes.athlet_id = registry.athlet_id) and (races.event_id = ' + IntToStr(EVENT_ID)
      + ') order by races.race_id, registry.platenumber;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    lvRegistered.Items.Clear;
    while not(EOF) do begin
      lItem := lvRegistered.Items.Add;
      with lItem do begin
        j := 0;
        for j := 0 to cbRegisterNumberplate.Items.Count - 1 do
          if cbRegisterNumberplate.Items.Strings[j] = IntToStr(Fields[0].AsInteger) then
            cbRegisterNumberplate.Items.Delete(j);
        Caption := Fields[3].AsString;
        SubItems.Add(IntToStr(Fields[0].AsInteger));
        SubItems.Add(Fields[1].AsString);
        SubItems.Add(Fields[2].AsString);
      end; // with lItem
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TMainForm.cbEventChange(Sender: TObject);
var
  EVENT_ID: Integer;
begin
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select event_id,event_date,name from events order by event_date;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    while not(EOF) do begin
      if Fields[2].AsString = cbEvent.Text then EVENT_ID := Fields[0].AsInteger;
      Next;
    end;
    Close;
    SQL.Text :=
      'select race_id,laps,track_length,name,status from races where event_id='
      + IntToStr(EVENT_ID) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    cbRace.Items.Clear;
    // схраняем EVENT_ID в sComboBox4.Tag
    cbRace.Tag := EVENT_ID;
    while not(EOF) do begin
      cbRace.Items.Add(Fields[3].AsString);
      Next;
    end;
    if cbRace.Items.Count > 0 then begin
      cbRace.ItemIndex := 0;
      spRacePanel.Show;
      // refresh
      cbRaceChange(Self);
      RefreshRacePanel(True);
    end
    else spRacePanel.Hide;
  finally
    Free;
  end;
end;

procedure TMainForm.cbRaceChange(Sender: TObject);
var
  EVENT_ID, RACE_ID, LAPS: Integer;
  STATUS: string;
begin
  EVENT_ID := cbRace.Tag;
  pcStart.Show;
  tsStartPrep.Show;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ищем race_id
    SQL.Text :=
      'select race_id,laps,track_length,name,status from races where event_id='
      + IntToStr(EVENT_ID) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    while not(EOF) do begin
      if cbRace.Text = Fields[3].AsString then begin
        RACE_ID := Fields[0].AsInteger;
        LAPS := Fields[1].AsInteger;
        STATUS := Fields[4].AsString;
      end;
      Next;
    end;
    // загружаем участников
    // параллельно заполняем массив номеров для предстартовой проверки
    Close;
    SQL.Text :=
      'select registry.platenumber, athletes.name from registry, athletes '
      + 'where (registry.athlet_id = athletes.athlet_id) and (registry.race_id = '
      + IntToStr(RACE_ID) + ') order by registry.platenumber;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    chlbAthletes.Clear;
    RaceNumbers.Clear;
    while not(EOF) do begin
      chlbAthletes.Items.Add(IntToStr(Fields[0].AsInteger) + ' - ' + Fields[1].AsString);
      chlbAthletes.Checked[chlbAthletes.Items.Count - 1] := true;
      RaceNumbers.Add(IntToStr(Fields[0].AsInteger));
      Next;
    end;
  finally
    Free;
  end;
  // проверка статуса гонки
  if STATUS = strRACE_STATUS_STARTED then begin
    lblRaceStatus.Caption := strREADY_TO_RACE;
    chlbAthletes.Enabled := False;
    btnRaceConfirm.Enabled := False;
    btnRaceStart.Enabled := true;
    btnRaceResults.Enabled := False;
    btnStpwtchStart.Enabled := true;
    btnStpwtchFinish.Enabled := true;
    spRacePanel.Enabled := False;
    spRacePanel.Show;
  end;
  if STATUS = strRACE_STATUS_FINISHED then begin
    lblRaceStatus.Caption := strRACE_FINISHED;
    chlbAthletes.Enabled := False;
    btnRaceConfirm.Enabled := False;
    btnRaceStart.Enabled := False;
    btnRaceResults.Enabled := true;
    spRacePanel.Enabled := true;
    btnStpwtchStart.Enabled := False;
    btnStpwtchFinish.Enabled := False;
    Timer.Enabled := False;
    spRacePanel.Show;
  end;
  if STATUS = '' then begin
    lblRaceStatus.Caption := strPRERACE_CHECK_REQUIRED;
    chlbAthletes.Enabled := true;
    btnRaceConfirm.Enabled := true;
    btnRaceStart.Enabled := False;
    btnRaceResults.Enabled := False;
    spRacePanel.Enabled := False;
    btnStpwtchStart.Enabled := False;
    btnStpwtchFinish.Enabled := False;
    Timer.Enabled := False;
    spRacePanel.Hide;
  end;
  // сохраняем race_id в sCheckListBox2.Tag и spNumbersPanel.Tag
  chlbAthletes.Tag := RACE_ID;
  spNumbersPanel.Tag := RACE_ID;
  cbResultsCG.Tag := RACE_ID;
  // refresh
  sTimerLabel.Caption := strTIMER_CAPTION;
  RefreshRacePanel(True);
end;

procedure TMainForm.cbResultsCGChange(Sender: TObject);
var
  i, RACE_ID, iPlace, iLeaderLaps, iAthleteLaps, PLATENUMBER, iAGE, iAGEMIN,
    iAGEMAX, iLAPS: Integer;
  strTIMENOTE, strTIMESTART, strTIMELEADER, strShift, strSEX: string;
  bToApplyFilter, bIsFiltered: Boolean;
  dtShift: TDateTime;
  lItem: TListItem;
begin
  lvResults.Hide;
  spbResults.Show;
  // берём RACE_ID из sComboBox6.Tag
  RACE_ID := cbResultsCG.Tag;
  bToApplyFilter := cbResultsCG.ItemIndex > 0;
  lvResults.Items.Clear;
  // выборка результата гонки. номера с количенством кругов и временем по абсолюту
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // время старта
    SQL.Text := 'select timenote from timenotes where (platenumber = 0) '
      + 'and (race_id = ' + IntToStr(RACE_ID) + ');';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    strTIMESTART := Fields[0].AsString;
    // параметры фильтрации, если тербуется
    if bToApplyFilter then begin
      Close;
      // изображаем такой-же запрос как и в sComboBox6, пробегаемся по нему до ItemIndex
      // и находим нужные поля
      SQL.Text := 'select sex,agemin,agemax,laps from comp_groups where race_id='
        + IntToStr(RACE_ID) + ' order by sex,agemin;';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      i := 1;
      while i < cbResultsCG.ItemIndex do begin
        Next;
        inc(i);
      end;
      strSEX := Fields[0].AsString;
      iAGEMIN := Fields[1].AsInteger;
      iAGEMAX := Fields[2].AsInteger;
      iLAPS := Fields[3].AsInteger;
    end;
    Close;
    // выборка в абсолюте, либо после определённого количества кругов
    // по зачёту выбранной подгруппы
    if (bToApplyFilter) and (iLAPS <> 0) then
      SQL.Text := 'select platenumber, count(platenumber), '
        + 'max(timenote) from (select platenumber, lap, timenote from (select tn_id, timenote, '
        + 'platenumber, (select count(*) from timenotes b where (b.tn_id < a.tn_id) and '
        + '(a.platenumber = b.platenumber) and (race_id = ' + IntToStr(RACE_ID)
        + ')) + 1 as lap from timenotes a where (race_id = ' + IntToStr(RACE_ID)
        + ')) where lap <= ' + IntToStr(iLAPS) + ' order by timenote) group by platenumber order by count(platenumber) '
        + 'desc, max(timenote);'
      // или если абсолют
    else
      SQL.Text := 'select platenumber, count(platenumber), max(timenote) from timenotes '
        + 'where race_id = ' + IntToStr(RACE_ID) + ' group by platenumber order by '
        + 'count(platenumber) desc, max(timenote);';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    spbResults.Position := 0;
    spbResults.Max := RecordCount;
    iPlace := 1;
    iLeaderLaps := Fields[1].AsInteger;
    while not(EOF) do begin
      PLATENUMBER := Fields[0].AsInteger;
      iAthleteLaps := Fields[1].AsInteger;
      strTIMENOTE := Fields[2].AsString;
      // Отсекаем признак старта заезда
      if PLATENUMBER <> 0 then begin
        with TIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text :=
            'select name,date_born,sex,team,city from athletes, registry '
            + 'where (registry.athlet_id = athletes.athlet_id) and (registry.platenumber = '
            + IntToStr(PLATENUMBER) + ') and (registry.race_id = ' + IntToStr(RACE_ID) + ')';
          Open;
          LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
          bIsFiltered := true;
          // применяем фильтрацию если необходимо
          if bToApplyFilter then begin
            // возраст по состоянию на 31 декабря текущего года
            iAGE := YearsBetween(StrToDate('31.12.' + FormatDateTime('yyyy', Now), fs),
              Fields[1].AsDateTime);
            bIsFiltered := iAGEMIN < iAGE;
            bIsFiltered := bIsFiltered and ((iAGEMAX = 0) or (iAGE < iAGEMAX));
            // пол
            bIsFiltered := bIsFiltered and ((strSEX = '') or (strSEX = Fields[2].AsString));
          end;
          // если прошло фильтрацию либо это абсолют, то выводим
          if bIsFiltered then begin
            lItem := lvResults.Items.Add;
            with lItem do begin
              Caption := IntToStr(iPlace);
              SubItems.Add(Fields[0].AsString);
              SubItems.Add(IntToStr(PLATENUMBER));
              if iLeaderLaps - iAthleteLaps = 0 then begin
                if iPlace = 1 then begin
                  // если первый - время от старта
                  dtShift := StrToTime(strTIMENOTE, fs) - StrToTime(strTIMESTART, fs);
                  strShift := FormatTimeNote(dtShift);
                  strTIMELEADER := strTIMENOTE;
                end
                else begin
                  // если не первый - отставание от лидера
                  dtShift := StrToTime(strTIMENOTE, fs) - StrToTime(strTIMELEADER, fs);
                  strShift := '+' + FormatTimeNote(dtShift);
                end;
                SubItems.Add(strShift);
              end
              else SubItems.Add('+' + IntToStr(iLeaderLaps - iAthleteLaps) + ' кр');
              SubItems.Add(Fields[4].AsString);
              SubItems.Add(Fields[3].AsString);
              inc(iPlace);
            end;
          end;
        finally
          Free;
        end;
      end;
      Next;
      spbResults.StepIt;
    end;
  finally
    Free;
  end;
  // выравнивание ширины колонок
  lvResults.Columns[0].Width := ColumnHeaderWidth;
  for i := 1 to lvResults.Columns.Count - 2 do begin
    lvResults.Columns[i].Width := ColumnTextWidth
  end;
  lvResults.Columns[lvResults.Columns.Count - 1].Width := ColumnHeaderWidth;
  spbResults.Hide;
  lvResults.Show;
end;

procedure TMainForm.cbLogLevelChange(Sender: TObject);
begin
  logLevel := cbLogLevel.ItemIndex;
  Config.WriteInteger('Logging', 'Level', logLevel);
end;

procedure TMainForm.cbPrintersChange(Sender: TObject);
begin
  Config.WriteString('General', 'PDFPrinter', Printer.Printers[Printer.PrinterIndex]);
end;

procedure TMainForm.eAthletSearchChange(Sender: TObject);
begin
  btnAthletSearch.Enabled := eAthletSearch.Text <> '';
end;

procedure TMainForm.eAthletSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    btnAthletSearchClick(Self);
  if Key = 27 then begin
    eAthletSearch.Hide;
    btnAthletSearch.Hide;
  end;
end;

procedure TMainForm.eDVRUrlChange(Sender: TObject);
begin
  Config.WriteString('DVR', 'URL', eDVRUrl.Text);
end;

procedure TMainForm.eSnapshotsDirChange(Sender: TObject);
begin
  Config.WriteString('DVR', 'SnapshotsDir', eSnapshotsDir.Text);
end;

procedure TMainForm.lbEventsDblClick(Sender: TObject);
begin
  btnRegistrationClick(Self);
end;

procedure TMainForm.lbEventsEnter(Sender: TObject);
begin
  btnRegistration.Enabled := true;
  btnEventResults.Enabled := true;
  btnStart.Enabled := true;
end;

procedure TMainForm.spNumbersPanelResize(Sender: TObject);
begin
  if (pcStart.ActivePage = tsRacePanel) and (pcMain.ActivePage = tsStart) then
    RepaintNumberButtons(Sender);
end;

procedure TMainForm.sSkinManagerAfterChange(Sender: TObject);
begin
  Config.WriteString('General', 'Skin', sSkinManager.SkinName);
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  sTimerLabel.Caption := FormatTimeNote(Now() - TIME_START);
end;

procedure TMainForm.tsRacePanelShow(Sender: TObject);
begin
  spRacePanel.Show;
end;

procedure TMainForm.tsRaceResultsShow(Sender: TObject);
var
  RACE_ID: Integer;
  strSEX, strAGEMIN, strAGEMAX, strLAPS: string;
begin
  btnStpwtchStart.Enabled := False;
  spRacePanel.Show;
  RACE_ID := cbResultsCG.Tag;
  with cbResultsCG do begin
    Items.Clear;
    Items.Add(strABSOLUTE);
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select sex,agemin,agemax,laps from comp_groups where race_id='
        + IntToStr(RACE_ID) + ' order by sex,agemin;';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      while not(EOF) do begin
        if Fields[0].AsString = 'Ж' then strSEX := 'Женщины';
        if Fields[0].AsString = 'М' then strSEX := 'Мужчины';
        if Fields[0].AsString = '-' then strSEX := 'Все';
        if Fields[1].AsInteger = 0 then strAGEMIN := ''
        else
          strAGEMIN := ' от ' + IntToStr(Fields[1].AsInteger);
        if Fields[2].AsInteger = 0 then strAGEMAX := ''
        else
          strAGEMAX := ' до ' + IntToStr(Fields[2].AsInteger);
        if Fields[3].AsInteger = 0 then strLAPS := ''
        else
          strLAPS := ' (' + IntToStr(Fields[3].AsInteger) + ' кр)';
        Items.Add(strSEX + strAGEMIN + strAGEMAX + strLAPS);
        Next;
      end;
    finally
      Free;
    end;
    ItemIndex := 0;
  end;
end;

procedure TMainForm.tsRegistrationShow(Sender: TObject);
begin
  cbEventRegistration.Items.Clear;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text :=
      'select event_id,event_date,name from events order by event_date;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    while not(EOF) do begin
      cbEventRegistration.Items.Add(Fields[2].AsString);
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TMainForm.tsSettingsShow(Sender: TObject);
begin
  cbLogLevel.ItemIndex := logLevel;
  ePlatesCount.Text := IntToStr(iPlatenumbersCount);
end;

procedure TMainForm.tsStartPrepShow(Sender: TObject);
begin
  spRacePanel.Hide;
end;

procedure TMainForm.tsAthletesShow(Sender: TObject);
var
  i, iWidth, ScrollBarWidth: Integer;
  lItem: TListItem;
begin
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text :=
      'select athlet_id,name,date_born,city,team from athletes order by name;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    lvAthletes.Items.Clear;
    while not(EOF) do begin
      lItem := lvAthletes.Items.Add;
      with lItem do begin
        Data := Pointer(Fields[0].AsInteger);
        Caption := Fields[1].AsString;
        SubItems.Add(FormatDateTime(strSIMPLE_DATEFORMAT, Fields[2].AsDateTime));
        SubItems.Add(Fields[3].AsString);
        SubItems.Add(Fields[4].AsString);
      end;
      Next;
    end;
  finally
    Free;
  end;
  // выравниваие ширины колонок
  iWidth := 0;
  for i := 0 to lvAthletes.Columns.Count - 2 do begin
    lvAthletes.Columns[i].Width := ColumnHeaderWidth;
    iWidth := iWidth + lvAthletes.Columns[i].Width;
  end;
  iWidth := iWidth + lvAthletes.Columns[lvAthletes.Columns.Count - 1].Width;
  if ScrollBarVisible(lvAthletes.Handle, WS_VSCROLL) then
    ScrollBarWidth := GetSystemMetrics(SM_CXVSCROLL)
  else
    ScrollBarWidth := 0;
  lvAthletes.Width := iWidth + ScrollBarWidth + lvAthletes.Columns.Count;
  pnlAthletes.Width := iWidth + ScrollBarWidth + lvAthletes.Columns.Count;
end;

procedure TMainForm.tsEventShow(Sender: TObject);
begin
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text :=
      'select event_id,event_date,name from events order by event_date;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    lbEvents.Clear;
    while not(EOF) do begin
      lbEvents.Items.Add('[' + FormatDateTime(strSIMPLE_DATEFORMAT, Fields[1].AsDateTime)
        + '] ' + Fields[2].AsString);
      Next;
    end;
  finally
    Free;
  end;
end;

end.
