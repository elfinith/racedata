unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, ComCtrls, ExtCtrls, sPanel,
  sButton, sListBox, sLabel, sEdit, IBDatabase, DB, IBSQL, IBQuery, sComboBox,
  sCheckListBox, sCheckBox, sScrollBar, Menus, sSkinProvider, ImgList,
  FreeButton, acTitleBar, DateUtils, SPageControl, sListView, Mask, sMaskEdit,
  sCustomComboEdit, sToolEdit, acProgressBar, IniFiles, sSplitter;

const
  llNOLOG = 0;
  llERROR = 1;
  llWARNING = 2;
  llDEBUG = 3;
  iORDINARY_LAP_FLAG = 1;
  iBEST_LAP_FLAG = 2;
  PLATENUMBERS_COUNT = 50;
  strTIMER_CAPTION = '00:00:00.00';
  strPLATENUMBER_FONT_NAME = 'Century Gothic';
  strDEFAULT_SKIN_NAME = 'Clean card (internal)';
  strTIMENOTE_FORMAT = 'hh:mm:ss.zzz';
  strSIMPLEDATEFORMAT = 'dd/mm/yyyy';
  strDB_CONNECTION_ERROR = '������ ��� ���������� � ��';
  strRACE_STATUS_STARTED = '� ��������';
  strRACE_STATUS_FINISHED = '���������';
  strREQUIRED_FIELDS_MISSING = '��������� ������������ ��� ���������� ����';
  strUNABLE_TO_DELETE_STARTED_RACE = '���������� ������� ��� ������� �����';
  strUNABLE_TO_DELETE_STARTED_EVENT = '���������� ������� ����������� � ����������� ��������';
  strREADY_TO_RACE = '������ � ������';
  strRACE_FINISHED = '����� ���������';
  strPRERACE_CHECK_REQUIRED = '��������� ������������� ��������';
  strINVALID_TIMENOTE_DATA = '�������� ������ � ��������� �������';
  strDELETE_COMP_GROUP = '������� �������� ���������?';
  strRACE_NOT_DELECTED = '�� ������ �����';
  strCOMP_GROUP_NOT_SELECTED = '�� ������� �������� ���������';
  strCOMPLETE_RACE = '��������� ����� � ������� � �������� �������?';
  strABSOLUTE = '���������� �����';
  strLAPSTOGO = ' ������ �� ������';
  strLASTLAP = '��������� ����';
  strFINISH = '�����';
  strEXEC_SQL = 'SQL: ';

  // ������� (��-�)
  clLinen = TColor($faf0e6);
  clMistyRose = TColor($ffe4e1);
  // ������� (��-�)
  clAliceBlue = TColor($f0f8ff);
  clLavender = TColor($e6e6fa);
  // �����
  clGainsboro = TColor($dcdcdc);

type
  TMainForm = class(TForm)
    sSkinManager: TsSkinManager;
    pnlMainMenu: TsPanel;
    btnEvents: TsBitBtn;
    btnAthletes: TsBitBtn;
    btnRegistration: TsBitBtn;
    pcMain: TSPageControl;
    tsRegistration: TSTabSheet;
    tsEvent: TSTabSheet;
    tsStart: TSTabSheet;
    lbEvents: TsListBox;
    btnEventNew: TsBitBtn;
    lblDateEvent: TsLabelFX;
    pnlEvent: TsPanel;
    eEventName: TsEdit;
    lblEventName: TsLabel;
    lblEventDate: TsLabel;
    dtpEvent: TSDateEdit;
    btnEventDelete: TsBitBtn;
    btnEventEdit: TsBitBtn;
    btnEventSave: TsBitBtn;
    btnEventClose: TsBitBtn;
    DBase: TIBDatabase;
    DBTran: TIBTransaction;
    pnlEventRaces: TsPanel;
    btnRaceDelete: TsBitBtn;
    btnRaceEdit: TsBitBtn;
    btnRaceNew: TsBitBtn;
    lbEventRaces: TsListBox;
    lblEventRaces: TsLabelFX;
    pnlRace: TsPanel;
    lblRaceLaps: TsLabel;
    lblRaceTrackLength: TsLabel;
    lblRaceName: TsLabel;
    eRaceLaps: TsEdit;
    eRaceName: TsEdit;
    eRaceTrackLength: TsEdit;
    btnRaceClose: TsBitBtn;
    btnRaceSave: TsBitBtn;
    btnStart: TsBitBtn;
    btnAthletNew: TsBitBtn;
    chlbRaces: TsCheckListBox;
    sComboBox1: TsComboBox;
    lblRegisterEventName: TsLabelFX;
    lblRegisterRaces: TsLabel;
    cbRegisterNumberplate: TsComboBox;
    lblRegisterPlatenumber: TsLabel;
    btnSettings: TsBitBtn;
    eAthletName: TsEdit;
    chbSexMale: TsCheckBox;
    chbSexFemale: TsCheckBox;
    lblRegisterAthletName: TsLabel;
    btnRegister: TsBitBtn;
    lblRegisteredList: TsLabelFX;
    lvRegistered: TSListView;
    lblRegisterSex: TsLabel;
    lblAthletBirthdate: TsLabel;
    dtpAthlet: TSDateEdit;
    lblTeam: TsLabel;
    eTeam: TsEdit;
    eCity: TsEdit;
    lblCity: TsLabel;
    btnFindAthlet: TsBitBtn;
    eAthletSearch: TsEdit;
    btnAthletSearch: TsBitBtn;
    PopupMenu1: TPopupMenu;
    sSkinProvider: TsSkinProvider;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    ImageList1: TImageList;
    lblEvent: TsLabelFX;
    cbEvent: TsComboBox;
    cbRace: TsComboBox;
    lblRace: TsLabel;
    tsAthletes: TSTabSheet;
    tsSettings: TSTabSheet;
    Timer: TTimer;
    btnDropAllTimenotes: TsBitBtn;
    pmRPMenu: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    lblCGList: TsLabelFX;
    lvCompGroups: TSListView;
    btnCGNew: TsBitBtn;
    btnCGDelete: TsBitBtn;
    pnlCGEdit: TsPanel;
    chbCGAgeMax: TsCheckBox;
    eCGAgeMax: TsEdit;
    eCGAgeMin: TsEdit;
    chbCGAgeMin: TsCheckBox;
    lblCGAge: TsLabel;
    chbCGFemale: TsCheckBox;
    chbCGMale: TsCheckBox;
    lblCGSex: TsLabel;
    btnCGSave: TsBitBtn;
    btnCGClose: TsBitBtn;
    eCGLaps: TsEdit;
    lblCGLabs: TsLabel;
    spRace: TsPanel;
    pcStart: TSPageControl;
    tsStartPrep: TSTabSheet;
    lblAthletes: TsLabel;
    lblRaceStatus: TsLabelFX;
    chlbAthletes: TsCheckListBox;
    btnRaceConfirm: TsBitBtn;
    btnRaceStart: TsBitBtn;
    btnRaceResults: TsBitBtn;
    tsRacePanel: TSTabSheet;
    spNumbersPanel: TsPanel;
    tsRaceResults: TSTabSheet;
    lblResultsCG: TsLabel;
    cbResultsCG: TsComboBox;
    lvResults: TSListView;
    btnResultsPrint: TsBitBtn;
    btnResultsSave: TsBitBtn;
    spRacePanel: TsPanel;
    sTimerLabel: TsLabel;
    btnStpwtchStart: TsBitBtn;
    btnStpwtchFinish: TsBitBtn;
    lvRacePanel: TSListView;
    pnlTimenote: TsPanel;
    btnTimenoteOK: TsBitBtn;
    btnTimenoteCancel: TsBitBtn;
    eTimenote: TsEdit;
    cbTimenotePlatenumber: TsComboBox;
    spbResults: TsProgressBar;
    lvAthletes: TsListView;
    sSplitter1: TsSplitter;
    pnlAthletStats: TsPanel;
    lblAthletRaces: TsLabelFX;
    lvAthRaces: TsListView;
    cbLogLevel: TsComboBox;
    lblLogLevel: TsLabel;
    lvAthStats: TsListView;
    lblAthletRaceStats: TsLabel;
    procedure btnRegistrationClick(Sender: TObject);
    procedure btnEventsClick(Sender: TObject);
    procedure btnAthletesClick(Sender: TObject);
    procedure btnEventNewClick(Sender: TObject);
    procedure btnEventEditClick(Sender: TObject);
    procedure btnEventCloseClick(Sender: TObject);
    procedure btnEventSaveClick(Sender: TObject);
    procedure tsEventShow(Sender: TObject);
    procedure btnRaceNewClick(Sender: TObject);
    procedure btnRaceSaveClick(Sender: TObject);
    procedure btnRaceCloseClick(Sender: TObject);
    procedure lbEventsEnter(Sender: TObject);
    procedure btnRaceEditClick(Sender: TObject);
    procedure btnRaceDeleteClick(Sender: TObject);
    procedure btnEventDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tsRegistrationShow(Sender: TObject);
    procedure sComboBox1Change(Sender: TObject);
    procedure chbSexFemaleClick(Sender: TObject);
    procedure chbSexMaleClick(Sender: TObject);
    procedure btnRegisterClick(Sender: TObject);
    procedure btnAthletNewClick(Sender: TObject);
    procedure btnFindAthletClick(Sender: TObject);
    procedure eAthletSearchChange(Sender: TObject);
    procedure btnAthletSearchClick(Sender: TObject);
    procedure eAthletSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbEventsDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure cbEventChange(Sender: TObject);
    procedure btnRaceConfirmClick(Sender: TObject);
    procedure cbRaceChange(Sender: TObject);
    procedure btnRaceStartClick(Sender: TObject);
    procedure spNumbersPanelResize(Sender: TObject);
    procedure btnStpwtchStartClick(Sender: TObject);
    procedure lvRacePanelCustomDraw(Sender: TCustomListView; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure lvRacePanelCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvRacePanelCustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure btnStpwtchFinishClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure btnDropAllTimenotesClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure btnTimenoteCancelClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure btnTimenoteOKClick(Sender: TObject);
    procedure btnCGNewClick(Sender: TObject);
    procedure btnCGSaveClick(Sender: TObject);
    procedure btnCGCloseClick(Sender: TObject);
    procedure chbCGMaleClick(Sender: TObject);
    procedure chbCGFemaleClick(Sender: TObject);
    procedure chbCGAgeMinClick(Sender: TObject);
    procedure chbCGAgeMaxClick(Sender: TObject);
    procedure btnCGDeleteClick(Sender: TObject);
    procedure btnRaceResultsClick(Sender: TObject);
    procedure tsRaceResultsShow(Sender: TObject);
    procedure cbResultsCGChange(Sender: TObject);
    procedure tsStartPrepShow(Sender: TObject);
    procedure tsRacePanelShow(Sender: TObject);
    procedure tsAthletesShow(Sender: TObject);
    procedure sSkinManagerAfterChange(Sender: TObject);
    procedure lvAthletesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure cbLogLevelChange(Sender: TObject);
    procedure tsSettingsShow(Sender: TObject);
    procedure lvAthRacesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvAthStatsCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvAthStatsCustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      var DefaultDraw: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    fs: TFormatSettings;
    RaceNumbers : TStringList;
    TIME_START : TDateTime;
    logLevel : integer;
    strLogFilename : string;
    Config : TIniFile;
    bDoRacePanelRefresh, bDoNBRepaintLater : boolean;
    procedure SelectAthlet(Sender: TObject);
    procedure RepaintNumberButtons(Sender: TObject);
    procedure OnPlateNumberClick(Sender: TObject);
    procedure RefreshRacePanel;
    procedure LogIt(errLever: integer; strMessage : string);

  end;

  RPUpdThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure DoWork;
    procedure Execute; override;
  end;

var
  MainForm: TMainForm;
  rpThread : RPUpdThread;
  function ScrollBarVisible(Handle : HWnd; Style : Longint) : Boolean;

implementation

{$R *.dfm}

procedure RPUpdThread.Execute;
begin
  FreeOnTerminate := true;
  Synchronize(DoWork);
end;

procedure RPUpdThread.DoWork;
begin
//  if not(MainForm.bDoRacePanelRefresh) then
  with MainForm do begin
    RefreshRacePanel;
    LogIt(llDEBUG, 'RPUpdThread.Free, ThreadID = ' + IntToStr(ThreadID) + #13#10);
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
  captionIndex := 0;
  // ������� �� �������� � �������
  for i := 0 to aMsgDlg.ComponentCount - 1 do begin
    // ���� ������
    if (aMsgDlg.Components[i] is TButton) then begin
      dlgButton := TButton(aMsgDlg.Components[i]);
      if CaptionIndex > High(Captions) then Break;
      // ��������� ����� ��������� �� ������ ������� ����������
      dlgButton.Caption := Captions[CaptionIndex];
      inc(CaptionIndex);
    end;
  end;
  Result := aMsgDlg.ShowModal;
end;

procedure TMainForm.LogIt(errLever: integer; strMessage : string);
var
  F : TextFile;
  dt, strLogLevel : string;
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
      llERROR : strLogLevel := 'ERROR';
      llWARNING : strLogLevel := 'WARNING';
      llDEBUG : strLogLevel := 'DEBUG';
    end;
    Write(F, dt + ' [' + strLogLevel + '] ' + strMessage);
    CloseFile(F);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Config := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
  logLevel := Config.ReadInteger('Logging', 'Level', llNOLOG);
  strLogFilename := ExtractFilePath(Application.ExeName) + Config.ReadString('Logging', 'Filename', 'racedata.log');
  sSkinManager.SkinName := Config.ReadString('General', 'Skin', strDEFAULT_SKIN_NAME);
  DBase.DatabaseName := ExtractFilePath(Application.ExeName) + 'DBASE.FDB';
  try
    DBase.Connected := True;
    DBTran.Active := True;
  except
    ShowMessage(strDB_CONNECTION_ERROR);
    LogIt(llERROR, strDB_CONNECTION_ERROR);
  end;
  RaceNumbers := TStringList.Create;
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, fs);
  with fs do begin
    TimeSeparator := ':';
    DecimalSeparator:='.';
    ShortTimeFormat := strTIMENOTE_FORMAT;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  tsEvent.Show;
end;

procedure TMainForm.OnPlateNumberClick(Sender: TObject);
var
  PLATENUMBER, RACE_ID, LAST_TN_ID : integer;
begin
  // ��������� ��������� �� �����
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
      SQL.Text := 'insert into timenotes(tn_id,race_id,platenumber,timenote) values('
        + IntToStr(LAST_TN_ID + 1) + ',' + IntToStr(RACE_ID) + ',' + IntToStr(PLATENUMBER)
        + ',''' + FormatDateTime(strTIMENOTE_FORMAT, Now()) + ''');';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    finally
      Free;
    end;
    // ���� ���������� ����� ���������� �������� ������, ��������� �����
    if not(bDoRacePanelRefresh) then begin
      // ���������� ���� �������� ����������
      bDoRacePanelRefresh := true;
      rpThread := RPUpdThread.Create(False);
      LogIt(llDEBUG, 'RPUpdThread.Create, ThreadID = ' + IntToStr(rpThread.ThreadID) + #13#10);
    end;
  end;
end;

procedure TMainForm.RefreshRacePanel;
var
  i, j, k, iPosCnt, iLapsOffset, iPanelWidth, ScrollBarWidth,
    RACE_ID, TN_ID, PLATENUMBER, iLapsCompleted, iLapsToGo : integer;
  TIMENOTE, RACETIME : TDateTime;
  strTIME_START : string;
  lItem : TListItem;
begin
  lvRacePanel.Clear;
  // ���� RACE_ID �� sspNumbersPanel.Tag
  RACE_ID := spNumbersPanel.Tag;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ����� ������
    SQL.Text := 'select timenote from timenotes where (platenumber = 0) '
      + 'and (race_id = ' + IntToStr(RACE_ID) + ');';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    if RecordCount > 0 then begin
      btnStpwtchStart.Enabled := false;
      strTIME_START := Fields[0].AsString;
      TIME_START := StrToTime(strTIME_START, fs);
      btnStpwtchStart.Caption := '����� ������: ' + Copy(strTIME_START, 1, 11);
//      Timer.Enabled := true;
    end
    else begin
      btnStpwtchStart.Enabled := true;
      btnStpwtchStart.Caption := '�����';
    end;
    // ������� �������
    Close;
    SQL.Text := 'select timenotes.tn_id, athletes.name, timenotes.platenumber, '
      + 'timenotes.timenote from athletes, registry, timenotes where (athletes.athlet_id = '
      + 'registry.athlet_id) and (registry.platenumber = timenotes.platenumber) and '
      + '(registry.race_id = timenotes.race_id) and (timenotes.race_id = ' + IntToStr(RACE_ID)
      + ') order by timenotes.timenote;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    while not(EOF) do begin
      TN_ID := Fields[0].AsInteger;
      PLATENUMBER := Fields[2].AsInteger;
      TIMENOTE := StrToTime(Fields[3].AsString, fs);
      RACETIME := TIMENOTE - TIME_START;
      lItem := lvRacePanel.Items.Add;
      with lItem do begin
        // ��������� TN_ID � Item.Data
        Data := Pointer(TN_ID);
        // �������� ��������, ���� �� ����������
        Caption := Copy(FormatDateTime(strTIMENOTE_FORMAT, RACETIME), 1, 11);
        SubItems.Add(IntToStr(PLATENUMBER));
        SubItems.Add(Fields[1].AsString);
        // ������� �����
        with TIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text := 'select count(tn_id) from timenotes where '
            + '(tn_id < ' + IntToStr(TN_ID) + ') and (platenumber=' + IntToStr(PLATENUMBER)
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
    // ����������� �������
    with lvRacePanel.Items do begin
      if Count <> 0 then begin
        iPosCnt := 1;
        Item[0].SubItems.Add('1');
        for i := 1 to Count - 1 do begin
          iPosCnt := 0;
          iLapsOffset := 0;
          // ���������� ���� ��� ������ �����
          for j := i downto 0 do begin
            // ������� ������� �� ��������� ����� ��� ��������� � ���� �����
            if Item[i].SubItems.Strings[2] = Item[j].SubItems.Strings[2] then inc(iPosCnt);
            // ������� ������������ ������� � ������ �� ��� ����� ������������
            k := StrToInt(Item[j].SubItems.Strings[2]) - StrToInt(Item[i].SubItems.Strings[2]);
            if iLapsOffset < k then iLapsOffset := k;
            // ������ ��������� ������� ���� ������
            if iLapsCompleted < StrToInt(Item[j].SubItems.Strings[2]) then
              iLapsCompleted := StrToInt(Item[j].SubItems.Strings[2]);
          end;
          Item[i].SubItems.Add(intToStr(iPosCnt));
          if iLapsOffset > 0 then Item[i].SubItems.Add('-' + IntToStr(iLapsOffset));
        end;
      end;
    end; // with ListView2.Items
    // ������������ ������ �������, �������� ������ ������ �� ��������
    iPanelWidth := 0;
    for i := 0 to lvRacePanel.Columns.Count - 2 do begin
      lvRacePanel.Columns[i].Width := ColumnHeaderWidth;
      iPanelWidth := iPanelWidth + lvRacePanel.Columns[i].Width;
    end;
    iPanelWidth := iPanelWidth + lvRacePanel.Columns[lvRacePanel.Columns.Count - 1].Width;
    if ScrollBarVisible(lvRacePanel.Handle, WS_VSCROLL) then
      ScrollBarWidth := GetSystemMetrics(SM_CXVSCROLL)
    else ScrollBarWidth := 0;
    spRacePanel.Width := iPanelWidth + ScrollBarWidth + lvRacePanel.Columns.Count;
    // ��������� � �����
    SendMessage(lvRacePanel.Handle, WM_VSCROLL, SB_BOTTOM, 0);
  finally
    Free;
  end;
  // ������� ������� ������ ��������
  iLapsToGo := btnStpwtchFinish.Tag - iLapsCompleted;
  if iLapsToGo > 1 then btnStpwtchFinish.Caption :=
    IntToStr(btnStpwtchFinish.Tag - iLapsCompleted) + strLAPSTOGO;
  if iLapsToGo = 1 then btnStpwtchFinish.Caption := strLASTLAP;
  if iLapsToGo < 1 then btnStpwtchFinish.Caption := strFINISH;
  // ������� ���� �������� ����������
  bDoRacePanelRefresh := false;
end;

procedure TMainForm.RepaintNumberButtons(Sender: TObject);
var
  i, iBtnNum, iBtnWidth, iBtnHeight, iRows, iColumns, iFldWidth, iFldHeight, maxBtnSize : integer;
  k : real;
  Item : TControl;
begin
  // ���������� ���������� ���������� ����
  iFldWidth := spNumbersPanel.Width;
  iFldHeight := spNumbersPanel.Height;
  iBtnNum := RaceNumbers.Count;
  // https://toster.ru/q/165393
  // ������� ������������ ������� ��������
  maxBtnSize := trunc(sqrt(iFldHeight * iFldWidth / iBtnNum));
  // ���������� � ������� ���������� i ���������� ��� � ������� K=(������ div i)*(������ div i)
  // ���� K �� ������ ����� ���������� ���������
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
  // �������� ������ ������
  for i := spNumbersPanel.ControlCount - 1 downto 0 do begin
    Item := spNumbersPanel.Controls[i];
    Item.Free;
  end;
  // ���������
  for i := 0 to iBtnNum - 1 do begin
    with TFreeButton.Create(spNumbersPanel) do begin
      Parent := spNumbersPanel;
      Caption := RaceNumbers.Strings[i];
      Width := iBtnWidth;
      Height := iBtnHeight;
      Left := (i mod iColumns) * iBtnWidth;
      Top := (i div iColumns) * iBtnHeight;
      DrawColor := clCream;
      DrawLight := false;
      DrawDropShadow := false;
      with Font do begin
        Size := iBtnHeight div 3;
        Style := [fsBold];
        Color := clBlack;
        Name := strPLATENUMBER_FONT_NAME;
      end;
      // ��������� RACE_ID � Tag ������
      Tag := chlbAthletes.Tag;
      onClick := OnPlateNumberClick;
//      Show;
    end;
  end;
  spNumbersPanel.Show;
end;

procedure TMainForm.lvRacePanelCustomDraw(Sender: TCustomListView;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
  with lvRacePanel.Canvas do begin
//    Brush.Color := clLinen;
//    FillRect(ARect);
  end;
end;

procedure TMainForm.lvRacePanelCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  with Sender.Canvas do begin
    if (StrToInt(Item.SubItems.Strings[2]) mod 2) = 0 then begin
      if (Item.Index mod 2) = 0 then Brush.Color := clMistyRose
      else Brush.Color := clLinen;
    end
    else begin
      if (Item.Index mod 2) = 0 then Brush.Color := clLavender
      else Brush.Color := clAliceBlue;
    end;
    if Item.SubItems.Count = 5 then Brush.Color := clGainsboro;

    if Item.SubItems.Strings[3] = '1' then begin
      Font.Style := [fsBold, fsUnderline];
    end
    else if Item.SubItems.Strings[3] = '2' then Font.Style := [fsUnderline]
    else if Item.SubItems.Strings[3] <> '3' then Font.Color := $808080;
  end;
end;

procedure TMainForm.lvRacePanelCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  with Sender.Canvas do begin
    if (StrToInt(Item.SubItems.Strings[2]) mod 2) = 0 then begin
      if (Item.Index mod 2) = 0 then Brush.Color := clMistyRose
      else Brush.Color := clLinen;
    end
    else begin
      if (Item.Index mod 2) = 0 then Brush.Color := clLavender
      else Brush.Color := clAliceBlue;
    end;
    if Item.SubItems.Count = 5 then Brush.Color := clGainsboro;
    if Item.SubItems.Strings[3] = '1' then begin
      Font.Style := [fsBold, fsUnderline];
    end
    else if Item.SubItems.Strings[3] = '2' then Font.Style := [fsUnderline]
    else if Item.SubItems.Strings[3] <> '3' then Font.Color := $808080;
  end;
end;

procedure TMainForm.lvAthletesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  i : integer;
  lItem : TListItem;
begin
  lvAthStats.Clear;
  lvAthRaces.Clear;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select events.event_date, events.name, races.name, races.race_id, '
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
        Caption := FormatDateTime(strSIMPLEDATEFORMAT,Fields[0].AsDateTime);
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
  // ������������ ������ �������
  for i := 0 to lvAthRaces.Columns.Count - 3 do begin
    lvAthRaces.Columns[i].Width := ColumnTextWidth;
  end;
end;

procedure TMainForm.lvAthRacesSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  lItem : TListItem;
  i, j, iShift, iBestLap, RACE_ID, ATHLET_ID, TRACK_LENGTH, LAPS : integer;
  strTIME_PREVIOUS, strTIME_CURRENT : string;
  dtLapTime, dtBesLapTime : TDateTime;
  rLapSpeed : extended;
begin
  ATHLET_ID := Integer(lvAthletes.Items[lvAthletes.ItemIndex].Data);
  RACE_ID := Integer(Item.Data);
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ��������� ������
    SQL.Text := 'select laps,track_length from races where race_id=' + IntToStr(RACE_ID) + ';';
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    Open;
    LAPS := Fields[0].AsInteger;
    TRACK_LENGTH := Fields[1].AsInteger;
    // ����� ������
    Close;
    SQL.Text := 'select timenote from timenotes where (race_id=' + IntToStr(RACE_ID)
      + ') and (platenumber=0);';
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    Open;
    strTIME_PREVIOUS := Fields[0].AsString;
    // ������� ������
    Close;
    SQL.Text := 'select timenotes.tn_id, timenotes.timenote from timenotes, registry '
      + 'where (timenotes.race_id=' + IntToStr(RACE_ID)
      + ') and (timenotes.platenumber = registry.platenumber) and (registry.race_id = '
      + 'timenotes.race_id) and (registry.athlet_id = '
      + IntToStr(ATHLET_ID) + ') order by timenotes.tn_id;';
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
        // ���� ������ ����
        if dtLapTime < dtBesLapTime then begin
          dtBesLapTime := dtLapTime;
          iBestLap := i;
        end;
        SubItems.Add(Copy(FormatDateTime(strTIMENOTE_FORMAT, dtLapTime), 1, 11));
        // �������� �� �����
        if TRACK_LENGTH > 0 then begin
          rLapSpeed := (3600 * TRACK_LENGTH / MilliSecondsBetween(StrToTime(strTIME_PREVIOUS, fs),
            StrToTime(strTIME_CURRENT, fs)) * 1000) / 1000;
        end
        else rLapSpeed := 0;
        strTIME_PREVIOUS := strTIME_CURRENT;
        // ���������� ����� �� �����
        with TIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text := 'select registry.athlet_id, a.lap, a.timenote from ( '
            + 'select platenumber, count(platenumber) as lap, max(timenote) '
            + 'as timenote from (select platenumber, lap, timenote from (select tn_id, timenote, '
            + 'platenumber, (select count(*) from timenotes b where (b.tn_id < a.tn_id) and '
            + '(a.platenumber = b.platenumber) and (race_id = ' + IntToStr(RACE_ID)
            + ')) + 1 as lap from timenotes a where (race_id = ' + IntToStr(RACE_ID)
            + ')) where lap <= ' + IntToStr(i) + ' order by timenote) '
            + 'group by platenumber order by count(platenumber) desc, max(timenote)) a, '
            + 'registry where (a.platenumber = registry.platenumber) and '
            + '(registry.race_id = ' + IntToStr(RACE_ID) + ') order by a.lap desc, a.timenote;';
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
        // ����������� ��������
        if i > 1 then begin
          iShift := StrToInt(SubItems.Strings[1]) - StrToInt(lvAthStats.Items[i - 2].SubItems.Strings[1]);
          if iShift = 0 then SubItems.Add('-');
          if iShift > 0 then SubItems.Add('+' + IntToStr(iShift));
          if iShift < 0 then SubItems.Add(IntToStr(iShift));
        end
        else SubItems.Add('-');
        // �������� �� �����
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

procedure TMainForm.N1Click(Sender: TObject);
var
  strRaceName, strAthletName, strAthletBirthDate : string;
  EVENT_ID, RACE_ID, ATHLET_ID : integer;
begin
  EVENT_ID := chlbRaces.Tag;
  strRaceName := lvRegistered.Items[lvRegistered.ItemIndex].Caption;
  strAthletName := lvRegistered.Items[lvRegistered.ItemIndex].SubItems[1];
  strAthletBirthDate := lvRegistered.Items[lvRegistered.ItemIndex].SubItems[2];
  if RusMessageDialog('�������� ����������� ' + strAthletName + ' �� ' + strRaceName + '?',
    mtConfirmation, mbYesNo, ['��', '������']) = mryes
  then begin
    with TIBQuery.Create(nil) do try
      // ��������� RACE_ID
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select race_id from races where (event_id=' + IntToStr(EVENT_ID)
        + ') and (name=''' + strRaceName + ''');';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      RACE_ID := Fields[0].AsInteger;
      // ��������� ATHLET_ID
      Close;
      SQL.Text := 'select athlet_id from athletes where (name=''' + strAthletName
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
        + ') and (athlet_id=' + intToStr(ATHLET_ID) + ');';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    finally
      Free;
    end;
  sComboBox1Change(Self);
  end;
end;

procedure TMainForm.N2Click(Sender: TObject);
var
  TN_ID : integer;
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
  RefreshRacePanel;
end;

procedure TMainForm.N3Click(Sender: TObject);
var
  i, TN_ID : integer;
begin
  // ��������� ����� TN_ID
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
  // ����������� ������� ����� (���� ���� ������� ������)
  eTimenote.Text := Copy(FormatDateTime(strTIMENOTE_FORMAT, Now() - TIME_START),1,11);
  // ��������� TN_ID � sPanel7.Tag
  pnlTimenote.Tag := TN_ID;
  // ������
  cbTimenotePlatenumber.Clear;
  for i := 0 to RaceNumbers.Count - 1 do cbTimenotePlatenumber.Items.Add(RaceNumbers[i]);
  eTimenote.Enabled := true;
  cbTimenotePlatenumber.DroppedDown := false;
  pnlTimenote.Show;
end;

procedure TMainForm.N4Click(Sender: TObject);
var
  i : integer;
begin
  // ��������� TN_ID � sPanel7.Tag
  pnlTimenote.Tag := Integer(lvRacePanel.Items[lvRacePanel.ItemIndex].Data);
  // ������
  cbTimenotePlatenumber.Clear;
  for i := 0 to RaceNumbers.Count - 1 do cbTimenotePlatenumber.Items.Add(RaceNumbers[i]);
  cbTimenotePlatenumber.Text := lvRacePanel.Items[lvRacePanel.ItemIndex].SubItems.Strings[0];
  eTimenote.Text := lvRacePanel.Items[lvRacePanel.ItemIndex].Caption;
  eTimenote.Enabled := false;
  pnlTimenote.Show;
  cbTimenotePlatenumber.SetFocus;
  cbTimenotePlatenumber.DroppedDown := true;
end;

procedure TMainForm.btnRaceEditClick(Sender: TObject);
var
  i : integer;
  lItem : TListItem;
begin
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select race_id,name,laps,track_length from races where event_id='
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
    // race_id ������ � sPanel3.Tag
    pnlRace.Tag := Fields[0].AsInteger;
    eRaceName.Text := Fields[1].AsString;
    eRaceTrackLength.Text := Fields[3].AsString;
    eRaceLaps.Text := Fields[2].AsString;
    // �������� �������
    Close;
    SQL.Text := 'select cg_id,sex,agemin,agemax,laps from comp_groups where race_id='
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
  lbEventRaces.Enabled := false;
  btnRaceNew.Enabled := false;
  btnRaceDelete.Enabled := false;
  btnEventSave.Enabled := false;
  btnEventClose.Enabled := false;
  eEventName.Enabled := false;
  dtpEvent.Enabled := false;
  pnlRace.Show;
end;

procedure TMainForm.btnRaceDeleteClick(Sender: TObject);
var
  i, RACE_ID : integer;
  bClear : boolean;
begin
  if lbEventRaces.ItemIndex <> -1 then begin
    if MessageDlg('������� ����� "' + lbEventRaces.Items.Strings[lbEventRaces.ItemIndex]
        + '"?', mtConfirmation, [mbyes, mbno], 0) = mryes then with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // ����� RACE_ID ��� ��������
      with TIBQuery.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        SQL.Text := 'select race_id,name,laps,track_length,status from races where event_id='
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
      if bClear then ExecQuery else ShowMessage(strUNABLE_TO_DELETE_STARTED_RACE);
    finally
      Free;
    end;
    // refresh
    btnEventEditClick(Self);
  end
  else ShowMessage(strRACE_NOT_DELECTED);
end;

procedure TMainForm.btnRaceSaveClick(Sender: TObject);
begin
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ���� �������
    if pnlRace.Tag = 0 then SQL.Text := 'insert into races(race_id,event_id,name,laps,track_length) '
      + 'values((select max(race_id) from races) + 1,' + IntToStr(pnlEvent.Tag) + ','''
      + eRaceName.Text + ''',' + eRaceLaps.Text + ',' + eRaceTrackLength.Text +  ');'
    // ���� ��������
    else SQL.Text := 'update races set name=''' + eRaceName.Text + ''',laps='
      + eRaceLaps.Text + ',track_length=' + eRaceTrackLength.Text + ' where race_id=' + IntToStr(pnlRace.Tag) + ';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
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
  i, EVENT_ID : integer;
begin
  if tsRegistration.Visible then begin
    // ���� ������� � �����������
    EVENT_ID := chlbRaces.Tag;
  end;
  if tsEvent.Visible then begin
    // ���� ������� �� ������ ������������
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select event_id,event_date,name from events order by event_date;';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      First;
      i := 0;
      while lbEvents.ItemIndex > i do begin
        Next;
        inc(i);
      end;
      // event_id ������ � sPanel2.Tag
      EVENT_ID := Fields[0].AsInteger;
    finally
      Free;
    end;
  end;
  if tsStart.Visible then begin
    // ���� � ����� ����
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select event_id,event_date,name from events order by event_date;';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      First;
      i := 0;
      while cbEvent.ItemIndex > i do begin
        Next;
        inc(i);
      end;
      // event_id ������ � sPanel2.Tag
      EVENT_ID := Fields[0].AsInteger;
    finally
      Free;
    end;
  end;

  // ��������� event_id � sComboBox4.Tag
  cbRace.Tag := EVENT_ID;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ������ �����������
    SQL.Text := 'select event_id,event_date,name from events order by event_date;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    cbEvent.Items.Clear;
    i := 0;
    while not(EOF) do begin
      cbEvent.Items.Add(Fields[2].AsString);
      // ��������� �����������
      if Fields[0].AsInteger = EVENT_ID then cbEvent.ItemIndex := i;
      inc(i);
      Next;
    end;
    // ������ �������
    Close;
    SQL.Text := 'select race_id,laps,track_length,name,status from races where event_id=' + IntToStr(EVENT_ID) + ';';
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
  eTeam.Clear;
  chbSexMale.Checked := true;
  chbSexFemale.Checked := false;
  dtpAthlet.Date := Now;
  eAthletName.ReadOnly := false;
  eTeam.ReadOnly := false;
  eCity.ReadOnly := false;
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

procedure TMainForm.btnSettingsClick(Sender: TObject);
begin
  btnAthletes.Font.Style := [];
  btnEvents.Font.Style := [];
  btnRegistration.Font.Style := [];
  btnStart.Font.Style := [];
  btnSettings.Font.Style := [fsBold];
  tsSettings.Show;
end;

procedure TMainForm.btnRegisterClick(Sender: TObject);
var
  i, EVENT_ID, ATHLET_ID, RACE_ID, REG_ID : integer;
  SEX : string;
  bRacesSelected : boolean;
begin
  bRacesSelected := false;
  // ������� ������� ������� �� ������ ������
  for i := 0 to chlbRaces.Items.Count - 1 do
    if chlbRaces.Checked[i] then bRacesSelected := true;
  // ��������� ���������� ������������ �����
  if (eAthletName.Text <> '') and (cbRegisterNumberplate.Text <> '') and bRacesSelected then begin
    EVENT_ID := chlbRaces.Tag;
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // ��������� (��������) ���������. ������� (�����/�������) - sEdit5.Tag
      if eAthletName.Tag = 0 then begin
        // ���� ����� ��������
        if chbSexMale.Checked then SEX := '�' else SEX := '�';
        // �������� ATHLET_ID
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
        SQL.Text := 'insert into athletes(athlet_id,name,date_born,sex,team,city) values('
          + IntToStr(ATHLET_ID) + ',''' + eAthletName.Text + ''','''
          + FormatDateTime(strSIMPLEDATEFORMAT, dtpAthlet.Date) + ''',''' + SEX + ''','''
          + eTeam.Text + ''',''' + eCity.Text + ''');';
        ExecQuery;
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      end
      else begin
        // ���� �������� ������ ����� �����
        ATHLET_ID := eAthletName.Tag;
      end;
      // �������� ����� ��� �����������
      for i := 0 to chlbRaces.Count - 1 do if chlbRaces.Checked[i] then begin
        // ��������� RACE_ID
        with tIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text := 'select race_id,name,track_length,laps from races where event_id='
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
        // ������������ �� �����
        Close;
        // �������� REG_ID
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
        SQL.Text := 'insert into registry(reg_id,platenumber,athlet_id,race_id) values('
          + IntToStr(REG_ID) + ',' + cbRegisterNumberplate.Text + ','
          + IntToStr(ATHLET_ID) + ',' + IntToStr(RACE_ID) + ');';
        ExecQuery;
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      end;
    finally
      Free;
    end;
    // refresh
    sComboBox1Change(Self);
    btnAthletNewClick(Self);
  end
  else ShowMessage(strREQUIRED_FIELDS_MISSING);
end;

procedure TMainForm.SelectAthlet(Sender: TObject);
var
  ATHLET_ID : integer;
begin
  ATHLET_ID := (Sender as TMenuItem).Tag;
  // ��������� ATHLET_ID � sEdit5.Tag ��� ������������ ��������� ���������� ������ ���������
  eAthletName.Tag := ATHLET_ID;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select name,date_born,sex,team,city from athletes where athlet_id='
      + IntToStr(ATHLET_ID) + ' order by name;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    eAthletName.Text := Fields[0].AsString;
    eTeam.Text := Fields[3].AsString;
    eCity.Text := Fields[4].AsString;
    dtpAthlet.Date := Fields[1].AsDateTime;
    chbSexMale.Checked := Fields[2].AsString = '�';
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
  mItem : TMenuItem;
  ATHLET_ID : integer;
  isRegistered : boolean;
begin
  PopupMenu1.Items.Clear;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select athlet_id,name,date_born,sex,team,city from athletes where name like ''%'
      + eAthletSearch.Text + '%'' order by name;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    while not(EOF) do begin
      // ����� ����� ��� ������������������
      ATHLET_ID := Fields[0].AsInteger;
      with TIBQuery.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        SQL.Text := 'select * from registry,races where (registry.race_id=races.race_id)'
          + 'and(athlet_id=' + IntToStr(ATHLET_ID) + ')and(races.event_id='
          + IntToStr(chlbRaces.Tag) + ');';
        Open;
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
        FetchAll;
        isRegistered := RecordCount > 0;
      finally
        Free;
      end;
      if not(isRegistered) then begin
        mItem := TMenuItem.Create(Self);
        mItem.Caption := Fields[1].AsString + ', '
          + FormatDateTime(strSIMPLEDATEFORMAT, Fields[2].AsDateTime) + ' (' + Fields[5].AsString + ')';
        // ��������� athlet_id � mItem.Tag
        mItem.Tag := ATHLET_ID;
        mItem.OnClick := SelectAthlet;
        PopupMenu1.Items.Add(mItem);
      end;
      Next;
    end;
    PopupMenu1.Popup(Left + eAthletSearch.Left, Top + pnlMainMenu.Height + eAthletName.Top + eAthletName.Height);
  finally
    Free;
  end;
end;

procedure TMainForm.btnAthletesClick(Sender: TObject);
begin
  btnAthletes.Font.Style := [fsBold];
  btnEvents.Font.Style := [];
  btnRegistration.Font.Style := [];
  btnStart.Font.Style := [];
  btnSettings.Font.Style := [];
  tsAthletes.Show;
end;

procedure TMainForm.btnRaceConfirmClick(Sender: TObject);
var
  i, j : integer;
  Buffer : TStringList;
  str : string;
begin
  btnRaceStart.Enabled := true;
  // ��������� �� ��������� ��������
  Buffer := TStringList.Create;
  for i := 0 to chlbAthletes.Count - 1 do begin
    if chlbAthletes.Checked[i] then Buffer.Add(RaceNumbers[i]);
  end;
  RaceNumbers.Clear;
  for i := 0 to Buffer.Count - 1 do RaceNumbers.Add(Buffer[i]);
  Buffer.Free;
  // �������� ����� ��� ������������
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ���� race_id �� sCheckListBox2.Tag
    SQL.Text := 'update races set status=''' + strRACE_STATUS_STARTED
      + ''' where race_id=' + IntToStr(chlbAthletes.Tag) + ';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
  finally
    Free;
  end;
  chlbAthletes.Enabled := false;
  lblRaceStatus.Caption := strREADY_TO_RACE;
end;

procedure TMainForm.btnRaceStartClick(Sender: TObject);
begin
  RefreshRacePanel;
  tsRacePanel.Show;
  spRacePanel.Enabled := true;
  btnStpwtchFinish.Enabled := true;
  if not(btnStpwtchStart.Enabled) then RepaintNumberButtons(Sender);

end;

procedure TMainForm.btnStpwtchStartClick(Sender: TObject);
var
  RACE_ID, LAST_TN_ID : integer;
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
  // ������� � ���� ����� "0" - ������� ������ ������
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'insert into timenotes(tn_id,race_id,platenumber,timenote) values('
      + IntToStr(LAST_TN_ID + 1) + ',' + IntToStr(RACE_ID) + ',0,'''
      + FormatDateTime(strTIMENOTE_FORMAT, TIME_START) + ''');';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    btnStpwtchStart.Enabled := false;
    Timer.Enabled := true;
  finally
    Free;
  end;
  spRacePanel.Enabled := true;
  btnStpwtchStart.Enabled := false;
  // ������� ������� �������� ������
  // � ���������� � Tag ������ �����
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
end;

procedure TMainForm.btnStpwtchFinishClick(Sender: TObject);
var
  i, RACE_ID : integer;
  strSEX, strAGEMIN, strAGEMAX: string;
  Item : TControl;
begin
  if RusMessageDialog(strCOMPLETE_RACE, mtConfirmation, mbYesNo, ['��', '������']) = mryes
  then begin
    Timer.Enabled := false;
    // �������� RACE_ID �� spNumbersPanel.Tag
    RACE_ID := spNumbersPanel.Tag;
    btnStpwtchStart.Enabled := true;
    Timer.Enabled := false;
    with tIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'update races set status=''' +
        strRACE_STATUS_FINISHED + ''' where race_id=' + IntToStr(RACE_ID) + ';';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    finally
      Free;
    end;
    // ��������� RACE_ID � sComboBox6.Tag
    cbResultsCG.Tag := RACE_ID;
    tsRaceResults.Show;
    btnStpwtchFinish.Enabled := false;
    // refresh
    cbResultsCGChange(Self);
  end;
end;

procedure TMainForm.btnDropAllTimenotesClick(Sender: TObject);
begin
  // ������� ������ ���� �������
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ��� ����� � �������� ��������� � ��������������
    SQL.Text := 'update races set status='''' where status=''' + strRACE_STATUS_STARTED + ''';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    Close;
    // ��� ����������� ����� � ��������� � ��������������
    SQL.Text := 'update races set status='''' where status=''' + strRACE_STATUS_FINISHED + ''';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    Close;
    // �������� ��� ��������� �������
    SQL.Text := 'delete from timenotes;';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    // ������ ������ (���� �����)
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select count(*) from timenotes;';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    finally
      Free;
    end;
    // ����� ������ ������
  finally
    Free;
  end;
end;

procedure TMainForm.btnTimenoteOKClick(Sender: TObject);
var
  i, TN_ID, RACE_ID : integer;
  strTIMENOTE, StrAbsTime : string;
  bValidData : boolean;
begin
  // ���� TN_ID �� sPanel7.Tag
  TN_ID := pnlTimenote.Tag;
  // ���� RACE_ID �� spNumbersPanel.Tag
  RACE_ID := spNumbersPanel.Tag;
  // ��������� ������������ ������
  bValidData := false;
  for i := 0 to RaceNumbers.Count - 1 do
    if RaceNumbers.Strings[i] = cbTimenotePlatenumber.Text then bValidData := true;
  strTIMENOTE := eTimenote.Text;
  if (strTIMENOTE[3] <> ':') or (strTIMENOTE[6] <> ':') or (strTIMENOTE[9] <> '.')
  then bValidData := false;
  // ���� ��, ����� � ����
  if bValidData then begin
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // ������� ����������/��������� - sEdit10.Enabled
      if eTimenote.Enabled then begin
        // ��������� � ����� ���������� ����� (����� ������ + ����� ������� )
        strAbsTime := FormatDateTime(strTIMENOTE_FORMAT, TIME_START + StrToTime(strTIMENOTE, fs));
        SQL.Text := 'insert into timenotes(tn_id,platenumber,race_id,timenote) values('
          + IntToStr(TN_ID) + ',' + cbTimenotePlatenumber.Text + ',' + IntToStr(RACE_ID) + ','''
          + strAbsTime + ''');'
      end
      else SQL.Text := 'update timenotes set platenumber=' + cbTimenotePlatenumber.Text
        + ' where TN_ID=' + IntToStr(TN_ID) + ';';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    finally
      Free;
    end;
    RefreshRacePanel;
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
  chbCGMale.Checked := false;
  chbCGFemale.Checked := false;
  chbCGAgeMin.Checked := false;
  chbCGAgeMax.Checked := false;
  eCGAgeMin.Enabled := false;
  eCGAgeMin.Clear;
  eCGAgeMax.Enabled := false;
  eCGAgeMax.Clear;
  eCGLaps.Text := eRaceLaps.Text;
  pnlCGEdit.Show;
  btnCGDelete.Enabled := false;
end;

procedure TMainForm.btnCGDeleteClick(Sender: TObject);
begin
  if lvCompGroups.ItemIndex <> -1 then begin
    if RusMessageDialog(strDELETE_COMP_GROUP, mtConfirmation, mbYesNo, ['��', '������']) = mryes
    then begin
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

function ScrollBarVisible(Handle : HWnd; Style : Longint) : Boolean;
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
  CG_ID, RACE_ID, AGEMIN, AGEMAX, LAPS : integer;
  SEX : string;
begin
  RACE_ID := pnlRace.Tag;
  // ����� CG_ID
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
  if chbCGMale.Checked then SEX := '�';
  if chbCGFemale.Checked then SEX := '�';
  if chbCGAgeMin.Checked then AGEMIN := StrToInt(eCGAgeMin.Text) else AGEMIN := 0;
  if chbCGAgeMax.Checked then AGEMAX := StrToInt(eCGAgeMax.Text) else AGEMAX := 0;
  if eCGLaps.Text <> '' then LAPS := StrToInt(eCGLaps.Text) else LAPS := 0;

  // ������� � ���� ����� �������� ������
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'insert into comp_groups(cg_id,race_id,sex,agemin,agemax,laps) values('
      + IntToStr(CG_ID) + ',' + IntToStr(RACE_ID) + ',''' + SEX + ''','
      + IntToStr(AGEMIN) + ',' + IntToStr(AGEMAX) + ',' + IntToStr(LAPS) + ');';
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
//  RefreshRacePanel;
  Timer.Enabled := false;
  spRacePanel.Enabled := true;
  btnStpwtchFinish.Enabled := false;
  // refresh
  cbResultsCGChange(Self);
end;

procedure TMainForm.btnRegistrationClick(Sender: TObject);
var
  i : integer;
begin
  btnAthletes.Font.Style := [];
  btnEvents.Font.Style := [];
  btnRegistration.Font.Style := [fsBold];
  btnStart.Font.Style := [];
  btnSettings.Font.Style := [];
  tsRegistration.Show;
  sComboBox1.ItemIndex := lbEvents.ItemIndex;
  sComboBox1Change(Self);
end;

procedure TMainForm.btnEventNewClick(Sender: TObject);
begin
  eEventName.Clear;
  pnlEvent.Tag := 0;
  pnlEventRaces.Hide;
  pnlEvent.Show;
  eEventName.SetFocus;
  lbEvents.Enabled := false;
  btnEventEdit.Enabled := false;
  btnEventDelete.Enabled := false;
end;

procedure TMainForm.btnEventSaveClick(Sender: TObject);
begin
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ���� �������
    if pnlEvent.Tag = 0 then SQL.Text :=
      'insert into events(event_id,event_date,name) values((select max(event_id) from events) + 1,'''
      + FormatDateTime(strSIMPLEDATEFORMAT, dtpEvent.Date) + ''','''
      + eEventName.Text + ''')'
    // ��������
    else
      SQL.Text := 'update events set name=''' + eEventName.Text +  ''',event_date='''
        + FormatDateTime(strSIMPLEDATEFORMAT, dtpEvent.Date) + ''' where event_id='
        + IntToStr(pnlEvent.Tag) + ';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    pnlEvent.Hide;
  finally
    Free;
  end;
  // �������� ������
  tsEventShow(Self);
  lbEvents.Enabled := true;
  btnEventNew.Enabled := true;
  btnEventDelete.Enabled := true;
  btnEventEdit.Enabled := true;
  lbEvents.SetFocus;
end;

procedure TMainForm.btnEventDeleteClick(Sender: TObject);
var
  i, EVENT_ID : integer;
  bClear : boolean;
begin
  if MessageDlg('������� ����������� "' + lbEvents.Items.Strings[lbEvents.ItemIndex]
      + '"?', mtConfirmation, [mbyes, mbno], 0) = mryes then with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    with TIBQuery.Create(nil) do try
      // ����� EVENT_ID ��� ��������
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select event_id,event_date,name from events order by event_date;';
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
      // �������� ������� �����
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
      SQL.Text := 'delete from races where event_id=' + IntToStr(EVENT_ID) + ';';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      Close;
      SQL.Text := 'delete from events where event_id=' + IntToStr(EVENT_ID) + ';';
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
  i : integer;
begin
  lbEventRaces.Clear;
  lbEvents.Enabled := false;
  btnEventNew.Enabled := false;
  btnEventDelete.Enabled := false;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select event_id,event_date,name from events order by event_date;';
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
    // event_id ������ � sPanel2.Tag
    pnlEvent.Tag := Fields[0].AsInteger;
    // �������� ������
    Close;
    SQL.Text := 'select race_id,name,track_length,laps from races where event_id='
      + IntToStr(pnlEvent.Tag) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    while not(EOF) do begin
      lbEventRaces.Items.Add(Fields[1].AsString + ' (' + IntToStr(Fields[3].AsInteger)
        + '��. �� ' + IntToStr(Fields[2].AsInteger) + '�)');
      Next;
    end;
  finally
    Free;
  end;
  pnlEvent.Show;
  pnlEventRaces.Show;
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
  btnEventSave.Enabled := false;
  btnEventClose.Enabled := false;
  eRaceName.SetFocus;
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

procedure TMainForm.chbCGFemaleClick(Sender: TObject);
begin
  chbCGMale.Checked := not(chbCGFemale.Checked);
end;

procedure TMainForm.chbCGAgeMinClick(Sender: TObject);
begin
  eCGAgeMin.Enabled := chbCGAgeMin.Checked;
  if chbCGAgeMin.Checked then eCGAgeMin.SetFocus;
end;

procedure TMainForm.chbCGAgeMaxClick(Sender: TObject);
begin
  eCGAgeMax.Enabled := chbCGAgeMax.Checked;
  if chbCGAgeMax.Checked then eCGAgeMax.SetFocus;
end;

procedure TMainForm.sComboBox1Change(Sender: TObject);
var
  EVENT_ID, i, j : integer;
  lItem : TListItem;
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
    while sComboBox1.ItemIndex > i do begin
      Next;
      inc(i);
    end;
    EVENT_ID := Fields[0].AsInteger;
    // �������� EVENT_ID � sCheckListBox1.Tag
    chlbRaces.Tag := EVENT_ID;
    // ������ �������
    Close;
    SQL.Text := 'select race_id,name,track_length,laps from races where event_id='
      + IntToStr(EVENT_ID) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    chlbRaces.Clear;
    while not(EOF) do begin
      chlbRaces.Items.Add(Fields[1].AsString);
      Next;
    end;
    // ������ ��� ��������������������, ������ ��������� �������
    cbRegisterNumberplate.Items.Clear;
    for i := 1 to PLATENUMBERS_COUNT do cbRegisterNumberplate.Items.Add(IntToStr(i));
    Close;
    SQL.Text := 'select distinct registry.platenumber, athletes.name, athletes.date_born, races.name, races.race_id '
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
          if cbRegisterNumberplate.Items.Strings[j] = IntToStr(Fields[0].AsInteger)
          then cbRegisterNumberplate.Items.Delete(j);
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
  EVENT_ID : integer;
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
    SQL.Text := 'select race_id,laps,track_length,name,status from races where event_id='
      + IntToStr(EVENT_ID) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    cbRace.Items.Clear;
    // �������� EVENT_ID � sComboBox4.Tag
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
      RefreshRacePanel;
    end
    else spRacePanel.Hide;
  finally
    Free;
  end;
end;

procedure TMainForm.cbRaceChange(Sender: TObject);
var
  EVENT_ID, RACE_ID, LAPS : integer;
  STATUS : string;
begin
  EVENT_ID := cbRace.Tag;
  pcStart.Show;
  tsStartPrep.Show;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ���� race_id
    SQL.Text := 'select race_id,laps,track_length,name,status from races where event_id='
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
    // ��������� ����������
    // ����������� ��������� ������ ������� ��� ������������� ��������
    Close;
    SQL.Text := 'select registry.platenumber, athletes.name from registry, athletes '
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
  // �������� ������� �����
  if STATUS = strRACE_STATUS_STARTED then begin
    lblRaceStatus.Caption := strREADY_TO_RACE;
    chlbAthletes.Enabled := false;
    btnRaceConfirm.Enabled := false;
    btnRaceStart.Enabled := true;
    btnRaceResults.Enabled := false;
    btnStpwtchStart.Enabled := true;
    btnStpwtchFinish.Enabled := true;
    spRacePanel.Enabled := false;
    spRacePanel.Show;
  end;
  if STATUS = strRACE_STATUS_FINISHED then begin
    lblRaceStatus.Caption := strRACE_FINISHED;
    chlbAthletes.Enabled := false;
    btnRaceConfirm.Enabled := false;
    btnRaceStart.Enabled := false;
    btnRaceResults.Enabled := true;
    spRacePanel.Enabled := true;
    btnStpwtchStart.Enabled := false;
    btnStpwtchFinish.Enabled := false;
    Timer.Enabled := false;
    spRacePanel.Show;
  end;
  if STATUS = '' then begin
    lblRaceStatus.Caption := strPRERACE_CHECK_REQUIRED;
    chlbAthletes.Enabled := true;
    btnRaceConfirm.Enabled := true;
    btnRaceStart.Enabled := false;
    btnRaceResults.Enabled := false;
    spRacePanel.Enabled := false;
    btnStpwtchStart.Enabled := false;
    btnStpwtchFinish.Enabled := false;
    Timer.Enabled := false;
    spRacePanel.Hide;
  end;
  // ��������� race_id � sCheckListBox2.Tag � spNumbersPanel.Tag
  chlbAthletes.Tag := RACE_ID;
  spNumbersPanel.Tag := RACE_ID;
  cbResultsCG.Tag := RACE_ID;
  // refresh
  sTimerLabel.Caption := strTIMER_CAPTION;
  RefreshRacePanel;
end;

procedure TMainForm.cbResultsCGChange(Sender: TObject);
var
  i, RACE_ID, iPlace, iLeaderLaps, iAthleteLaps, PLATENUMBER, iAGE, iAGEMIN, iAGEMAX, iLAPS : integer;
  strTIMENOTE, strTIMESTART, strTIMELEADER, strShift, strSEX : string;
  bToApplyFilter, bIsFiltered : boolean;
  dtShift : TDateTime;
  lItem : TListItem;
begin
  lvResults.Hide;
  spbResults.Show;
  // ���� RACE_ID �� sComboBox6.Tag
  RACE_ID := cbResultsCG.Tag;
  bToApplyFilter := cbResultsCG.ItemIndex > 0;
  lvResults.Items.Clear;
  // ������� ��������� �����. ������ � ������������ ������ � �������� �� ��������
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ����� ������
    SQL.Text := 'select timenote from timenotes where (platenumber = 0) '
      + 'and (race_id = ' + IntToStr(RACE_ID) + ');';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    strTIMESTART := Fields[0].AsString;
    // ��������� ����������, ���� ���������
    if bToApplyFilter then begin
      Close;
      // ���������� �����-�� ������ ��� � � sComboBox6, ����������� �� ���� �� ItemIndex
      // � ������� ������ ����
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
    // ������� � ��������, ���� ����� ������������ ���������� ������
    // �� ������ ��������� ���������
    if (bToApplyFilter) and (iLAPS <> 0) then SQL.Text := 'select platenumber, count(platenumber), '
      + 'max(timenote) from (select platenumber, lap, timenote from (select tn_id, timenote, '
      + 'platenumber, (select count(*) from timenotes b where (b.tn_id < a.tn_id) and '
      + '(a.platenumber = b.platenumber) and (race_id = ' + IntToStr(RACE_ID)
      + ')) + 1 as lap from timenotes a where (race_id = ' + IntToStr(RACE_ID) + ')) where lap <= '
      + IntToStr(iLAPS) + ' order by timenote) group by platenumber order by count(platenumber) '
      + 'desc, max(timenote);'
    // ��� ���� �������
    else SQL.Text := 'select platenumber, count(platenumber), max(timenote) from timenotes '
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
      // �������� ������� ������ ������
      if PLATENUMBER <> 0 then begin
        with TIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text := 'select name,date_born,sex,team,city from athletes, registry '
            + 'where (registry.athlet_id = athletes.athlet_id) and (registry.platenumber = '
            + IntToStr(PLATENUMBER) + ') and (registry.race_id = ' + IntToStr(RACE_ID) + ')';
          Open;
          LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
          bIsFiltered := true;
          // ��������� ���������� ���� ����������
          if bToApplyFilter then begin
            // �������
            iAGE := YearsBetween(StrToDate('31.12.' + FormatDateTime('yyyy', Now),fs),
              Fields[1].AsDateTime);
            bIsFiltered := iAGEMIN < iAGE;
            bIsFiltered := bIsFiltered and ((iAGEMAX = 0) or (iAGE < iAGEMAX));
            // ���
            bIsFiltered := bIsFiltered and ((strSEX = '') or (strSEX = Fields[2].AsString));
          end;
          // ���� ������ ���������� ���� ��� �������, �� �������
          if bIsFiltered then begin
            lItem := lvResults.Items.Add;
            with lItem do begin
              Caption := IntToStr(iPlace);
              SubItems.Add(Fields[0].AsString);
              SubItems.Add(IntToStr(PLATENUMBER));
              if iLeaderLaps - iAthleteLaps = 0 then begin
                if iPlace = 1 then begin
                  // ���� ������ - ����� �� ������
                  dtShift := StrToTime(strTIMENOTE, fs) - StrToTime(strTIMESTART, fs);
                  strShift := Copy(FormatDateTime(strTIMENOTE_FORMAT, dtShift),1,11);
                  strTIMELEADER := strTIMENOTE;
                end
                else begin
                  // ���� �� ������ - ���������� �� ������
                  dtShift := StrToTime(strTIMENOTE, fs) - StrToTime(strTIMELEADER, fs);
                  strShift := '+' + Copy(FormatDateTime(strTIMENOTE_FORMAT, dtShift),1,11);
                end;
                SubItems.Add(strShift);
              end
              else SubItems.Add('+' + IntToStr(iLeaderLaps - iAthleteLaps) + ' ��');
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
  // ������������ ������ �������
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

procedure TMainForm.eAthletSearchChange(Sender: TObject);
begin
  btnAthletSearch.Enabled := eAthletSearch.Text <> '';
end;

procedure TMainForm.eAthletSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then btnAthletSearchClick(Self);
  if Key = 27 then begin
    eAthletSearch.Hide;
    btnAthletSearch.Hide;
  end;
end;

procedure TMainForm.lbEventsDblClick(Sender: TObject);
begin
  btnRegistrationClick(Self);
end;

procedure TMainForm.lbEventsEnter(Sender: TObject);
begin
  btnRegistration.Enabled := true;
  btnStart.Enabled := true;
end;

procedure TMainForm.spNumbersPanelResize(Sender: TObject);
begin
  if (pcStart.ActivePage = tsRacePanel) and (pcMain.ActivePage = tsStart)
  then RepaintNumberButtons(Sender);
end;

procedure TMainForm.sSkinManagerAfterChange(Sender: TObject);
begin
  Config.WriteString('General', 'Skin', sSkinManager.SkinName);
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  sTimerLabel.Caption := Copy(FormatDateTime(strTIMENOTE_FORMAT, Now() - TIME_START), 1, 11);
end;

procedure TMainForm.tsRacePanelShow(Sender: TObject);
begin
  spRacePanel.Show;
end;

procedure TMainForm.tsRaceResultsShow(Sender: TObject);
var
  RACE_ID : integer;
  strSEX, strAGEMIN, strAGEMAX, strLAPS : string;
begin
  btnStpwtchStart.Enabled := false;
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
        if Fields[0].AsString = '�' then strSEX := '�������';
        if Fields[0].AsString = '�' then strSEX := '�������';
        if Fields[0].AsString = '-' then strSEX := '���';
        if Fields[1].AsInteger = 0 then strAGEMIN := ''
        else strAGEMIN := ' �� ' + IntToStr(Fields[1].AsInteger);
        if Fields[2].AsInteger = 0 then strAGEMAX := ''
        else strAGEMAX := ' �� ' + IntToStr(Fields[2].AsInteger);
        if Fields[3].AsInteger = 0 then strLAPS := ''
        else strLAPS := ' (' + IntToStr(Fields[3].AsInteger) + ' ��)';
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
  sComboBox1.Items.Clear;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select event_id,event_date,name from events order by event_date;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    while not(EOF) do begin
      sComboBox1.Items.Add(Fields[2].AsString);
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TMainForm.tsSettingsShow(Sender: TObject);
begin
  cbLogLevel.ItemIndex := logLevel;
end;

procedure TMainForm.tsStartPrepShow(Sender: TObject);
begin
  spRacePanel.Hide;
end;

procedure TMainForm.tsAthletesShow(Sender: TObject);
var
  i, iWidth ,ScrollBarWidth : integer;
  lItem : TListItem;
begin
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select athlet_id,name,date_born,team,city from athletes order by name;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    lvAthletes.Items.Clear;
    while not(EOF) do begin
      lItem := lvAthletes.Items.Add;
      with lItem do begin
        Data := Pointer(Fields[0].AsInteger);
        Caption := Fields[1].AsString;
        SubItems.Add(FormatDateTime(strSIMPLEDATEFORMAT, Fields[2].AsDateTime));
        SubItems.Add(Fields[3].AsString);
        SubItems.Add(Fields[4].AsString);
      end;
      Next;
    end;
  finally
    Free;
  end;
  // ����������� ������ �������
  iWidth := 0;
  for i := 0 to lvAthletes.Columns.Count - 2 do begin
    lvAthletes.Columns[i].Width := ColumnHeaderWidth;
    iWidth := iWidth + lvAthletes.Columns[i].Width;
  end;
  iWidth := iWidth + lvAthletes.Columns[lvAthletes.Columns.Count - 1].Width;
  if ScrollBarVisible(lvAthletes.Handle, WS_VSCROLL) then
    ScrollBarWidth := GetSystemMetrics(SM_CXVSCROLL)
  else ScrollBarWidth := 0;
  lvAthletes.Width := iWidth + ScrollBarWidth + lvAthletes.Columns.Count;
end;

procedure TMainForm.tsEventShow(Sender: TObject);
begin
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select event_id,event_date,name from events order by event_date;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    lbEvents.Clear;
    while not(EOF) do begin
      lbEvents.Items.Add('[' + FormatDateTime(strSIMPLEDATEFORMAT, Fields[1].AsDateTime) + '] '
        + Fields[2].AsString);
      Next;
    end;
  finally
    Free;
  end;
end;

end.

