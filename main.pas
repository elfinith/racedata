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
  strDB_CONNECTION_ERROR = 'Ошибка при соединении с БД';
  strRACE_STATUS_STARTED = 'В процессе';
  strRACE_STATUS_FINISHED = 'Завершено';
  strREQUIRED_FIELDS_MISSING = 'Пропущены обязательные для заполнения поля';
  strUNABLE_TO_DELETE_STARTED_RACE = 'Невозможно удалить уже начатый заезд';
  strUNABLE_TO_DELETE_STARTED_EVENT = 'Невозможно удалить мероприятие с проведёнными заездами';
  strREADY_TO_RACE = 'Готовы к старту';
  strRACE_FINISHED = 'Гонка закончена';
  strPRERACE_CHECK_REQUIRED = 'Требуется предстартовая проверка';
  strINVALID_TIMENOTE_DATA = 'Неверные данные о временной отметке';
  strDELETE_COMP_GROUP = 'Удалить зачётную подгруппу?';
  strRACE_NOT_DELECTED = 'Не выбран заезд';
  strCOMP_GROUP_NOT_SELECTED = 'Не выбрана зачётная подгруппа';
  strCOMPLETE_RACE = 'Завершить гонку и перейти к итоговой таблице?';
  strABSOLUTE = 'Абсолютный зачёт';
  strLAPSTOGO = ' кругов до финиша';
  strLASTLAP = 'Последний круг';
  strEXEC_SQL = 'SQL: ';

  // розовый (св-т)
  clLinen = TColor($faf0e6);
  clMistyRose = TColor($ffe4e1);
  // голубой (св-т)
  clAliceBlue = TColor($f0f8ff);
  clLavender = TColor($e6e6fa);
  // серый
  clGainsboro = TColor($dcdcdc);

type
  TMainForm = class(TForm)
    sSkinManager: TsSkinManager;
    sPanel1: TsPanel;
    sBitBtn2: TsBitBtn;
    sBitBtn1: TsBitBtn;
    sBitBtn3: TsBitBtn;
    PageControl1: TSPageControl;
    tsRegistration: TSTabSheet;
    tsEvent: TSTabSheet;
    tsStart: TSTabSheet;
    sListBox1: TsListBox;
    sBitBtn4: TsBitBtn;
    sLabelFX1: TsLabelFX;
    sPanel2: TsPanel;
    sEdit1: TsEdit;
    sLabel2: TsLabel;
    sLabel1: TsLabel;
    DateTimePicker1: TSDateEdit;
    sBitBtn6: TsBitBtn;
    sBitBtn7: TsBitBtn;
    sBitBtn5: TsBitBtn;
    sBitBtn8: TsBitBtn;
    DBase: TIBDatabase;
    DBTran: TIBTransaction;
    sPanel4: TsPanel;
    sBitBtn11: TsBitBtn;
    sBitBtn10: TsBitBtn;
    sBitBtn9: TsBitBtn;
    sListBox2: TsListBox;
    sLabelFX2: TsLabelFX;
    sPanel3: TsPanel;
    sLabel5: TsLabel;
    sLabel4: TsLabel;
    sLabel3: TsLabel;
    sEdit4: TsEdit;
    sEdit2: TsEdit;
    sEdit3: TsEdit;
    sBitBtn13: TsBitBtn;
    sBitBtn12: TsBitBtn;
    sBitBtn14: TsBitBtn;
    sBitBtn15: TsBitBtn;
    sCheckListBox1: TsCheckListBox;
    sComboBox1: TsComboBox;
    sLabelFX3: TsLabelFX;
    sLabel6: TsLabel;
    sComboBox2: TsComboBox;
    sLabel7: TsLabel;
    sBitBtn17: TsBitBtn;
    sEdit5: TsEdit;
    sCheckBox1: TsCheckBox;
    sCheckBox2: TsCheckBox;
    sLabel8: TsLabel;
    sBitBtn18: TsBitBtn;
    sLabelFX4: TsLabelFX;
    ListView1: TSListView;
    sLabel9: TsLabel;
    sLabel10: TsLabel;
    DateTimePicker2: TSDateEdit;
    sLabel11: TsLabel;
    sEdit6: TsEdit;
    sEdit7: TsEdit;
    sLabel12: TsLabel;
    sBitBtn16: TsBitBtn;
    sEdit8: TsEdit;
    sBitBtn19: TsBitBtn;
    PopupMenu1: TPopupMenu;
    sSkinProvider: TsSkinProvider;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    ImageList1: TImageList;
    sLabelFX5: TsLabelFX;
    sComboBox3: TsComboBox;
    sComboBox4: TsComboBox;
    sLabel13: TsLabel;
    tsAthletes: TSTabSheet;
    tsSettings: TSTabSheet;
    Timer: TTimer;
    sBitBtn25: TsBitBtn;
    pmRPMenu: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    sLabelFX7: TsLabelFX;
    lvCompGroups: TSListView;
    sBitBtn28: TsBitBtn;
    sBitBtn29: TsBitBtn;
    sPanel9: TsPanel;
    sCheckBox6: TsCheckBox;
    sEdit11: TsEdit;
    sEdit9: TsEdit;
    sCheckBox5: TsCheckBox;
    sLabel15: TsLabel;
    sCheckBox4: TsCheckBox;
    sCheckBox3: TsCheckBox;
    sLabel16: TsLabel;
    sBitBtn30: TsBitBtn;
    sBitBtn31: TsBitBtn;
    sEdit12: TsEdit;
    sLabel18: TsLabel;
    spRace: TsPanel;
    PageControl2: TSPageControl;
    tsStartPrep: TSTabSheet;
    sLabel14: TsLabel;
    sLabelFX6: TsLabelFX;
    sCheckListBox2: TsCheckListBox;
    sBitBtn20: TsBitBtn;
    sBitBtn21: TsBitBtn;
    sBitBtn32: TsBitBtn;
    tsRacePanel: TSTabSheet;
    spNumbersPanel: TsPanel;
    tsRaceResults: TSTabSheet;
    sLabel17: TsLabel;
    sComboBox6: TsComboBox;
    lvResults: TSListView;
    sBitBtn33: TsBitBtn;
    sBitBtn34: TsBitBtn;
    spRacePanel: TsPanel;
    sTimerLabel: TsLabel;
    sBitBtn22: TsBitBtn;
    sBitBtn23: TsBitBtn;
    sBitBtn24: TsBitBtn;
    ListView2: TSListView;
    sPanel7: TsPanel;
    sBitBtn26: TsBitBtn;
    sBitBtn27: TsBitBtn;
    sEdit10: TsEdit;
    sComboBox5: TsComboBox;
    spbResults: TsProgressBar;
    lvAthletes: TsListView;
    sSplitter1: TsSplitter;
    sPanel5: TsPanel;
    sLabelFX8: TsLabelFX;
    lvAthRaces: TsListView;
    sComboBox7: TsComboBox;
    sLabel19: TsLabel;
    lvAthStats: TsListView;
    sLabel20: TsLabel;
    procedure sBitBtn3Click(Sender: TObject);
    procedure sBitBtn2Click(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure sBitBtn4Click(Sender: TObject);
    procedure sBitBtn7Click(Sender: TObject);
    procedure sBitBtn8Click(Sender: TObject);
    procedure sBitBtn5Click(Sender: TObject);
    procedure tsEventShow(Sender: TObject);
    procedure sBitBtn9Click(Sender: TObject);
    procedure sBitBtn12Click(Sender: TObject);
    procedure sBitBtn13Click(Sender: TObject);
    procedure sListBox1Enter(Sender: TObject);
    procedure sBitBtn10Click(Sender: TObject);
    procedure sBitBtn11Click(Sender: TObject);
    procedure sBitBtn6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tsRegistrationShow(Sender: TObject);
    procedure sComboBox1Change(Sender: TObject);
    procedure sCheckBox2Click(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure sBitBtn18Click(Sender: TObject);
    procedure sBitBtn15Click(Sender: TObject);
    procedure sBitBtn16Click(Sender: TObject);
    procedure sEdit8Change(Sender: TObject);
    procedure sBitBtn19Click(Sender: TObject);
    procedure sEdit8KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sListBox1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure sBitBtn14Click(Sender: TObject);
    procedure sComboBox3Change(Sender: TObject);
    procedure sBitBtn20Click(Sender: TObject);
    procedure sComboBox4Change(Sender: TObject);
    procedure sBitBtn21Click(Sender: TObject);
    procedure spNumbersPanelResize(Sender: TObject);
    procedure sBitBtn22Click(Sender: TObject);
    procedure sBitBtn24Click(Sender: TObject);
    procedure ListView2CustomDraw(Sender: TCustomListView; const ARect: TRect;
      var DefaultDraw: Boolean);
    procedure ListView2CustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ListView2CustomDrawSubItem(Sender: TCustomListView;
      Item: TListItem; SubItem: Integer; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure sBitBtn23Click(Sender: TObject);
    procedure sBitBtn17Click(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure sBitBtn25Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure sBitBtn27Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure sBitBtn26Click(Sender: TObject);
    procedure sBitBtn28Click(Sender: TObject);
    procedure sBitBtn30Click(Sender: TObject);
    procedure sBitBtn31Click(Sender: TObject);
    procedure sCheckBox3Click(Sender: TObject);
    procedure sCheckBox4Click(Sender: TObject);
    procedure sCheckBox5Click(Sender: TObject);
    procedure sCheckBox6Click(Sender: TObject);
    procedure sBitBtn29Click(Sender: TObject);
    procedure sBitBtn32Click(Sender: TObject);
    procedure tsRaceResultsShow(Sender: TObject);
    procedure sComboBox6Change(Sender: TObject);
    procedure tsStartPrepShow(Sender: TObject);
    procedure tsRacePanelShow(Sender: TObject);
    procedure tsAthletesShow(Sender: TObject);
    procedure sSkinManagerAfterChange(Sender: TObject);
    procedure lvAthletesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure sComboBox7Change(Sender: TObject);
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
  // перебор по объектам в диалоге
  for i := 0 to aMsgDlg.ComponentCount - 1 do begin
    // если кнопка
    if (aMsgDlg.Components[i] is TButton) then begin
      dlgButton := TButton(aMsgDlg.Components[i]);
      if CaptionIndex > High(Captions) then Break;
      // загружаем новый заголовок из нашего массива заголовков
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
  // проверяем стартовал ли заезд
  if not(sBitBtn22.Enabled) then begin
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
    // если предыдущий поток обновления завершил работу, запускаем новый
    if not(bDoRacePanelRefresh) then begin
      // выставляем флаг процесса обновления
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
  ListView2.Clear;
  // берём RACE_ID из sspNumbersPanel.Tag
  RACE_ID := spNumbersPanel.Tag;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // время старта
    SQL.Text := 'select timenote from timenotes where (platenumber = 0) '
      + 'and (race_id = ' + IntToStr(RACE_ID) + ');';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    if RecordCount > 0 then begin
      sBitBtn22.Enabled := false;
      strTIME_START := Fields[0].AsString;
      TIME_START := StrToTime(strTIME_START, fs);
      sBitBtn22.Caption := 'Время старта: ' + Copy(strTIME_START, 1, 11);
//      Timer.Enabled := true;
    end
    else begin
      sBitBtn22.Enabled := true;
      sBitBtn22.Caption := 'СТАРТ';
    end;
    // времена засечек
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
      lItem := ListView2.Items.Add;
      with lItem do begin
        // сохраняем TN_ID в Item.Data
        Data := Pointer(TN_ID);
        // отсекаем тысячные, чтоб не захламлять
        Caption := Copy(FormatDateTime(strTIMENOTE_FORMAT, RACETIME), 1, 11);
        SubItems.Add(IntToStr(PLATENUMBER));
        SubItems.Add(Fields[1].AsString);
        // считаем круги
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
    // проставляем позиции
    with ListView2.Items do begin
      if Count <> 0 then begin
        iPosCnt := 1;
        Item[0].SubItems.Add('1');
        for i := 1 to Count - 1 do begin
          iPosCnt := 0;
          iLapsOffset := 0;
          // преебираем всех кто прошёл ранее
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
          Item[i].SubItems.Add(intToStr(iPosCnt));
          if iLapsOffset > 0 then Item[i].SubItems.Add('-' + IntToStr(iLapsOffset));
        end;
      end;
    end; // with ListView2.Items
    // выравнивание ширины колонок, подгонка ширины панели по колонкам
    iPanelWidth := 0;
    for i := 0 to ListView2.Columns.Count - 2 do begin
      ListView2.Columns[i].Width := ColumnHeaderWidth;
      iPanelWidth := iPanelWidth + ListView2.Columns[i].Width;
    end;
    iPanelWidth := iPanelWidth + ListView2.Columns[ListView2.Columns.Count - 1].Width;
    if ScrollBarVisible(ListView2.Handle, WS_VSCROLL) then
      ScrollBarWidth := GetSystemMetrics(SM_CXVSCROLL)
    else ScrollBarWidth := 0;
    spRacePanel.Width := iPanelWidth + ScrollBarWidth + ListView2.Columns.Count;
    // прокрутка в конец
    SendMessage(ListView2.Handle, WM_VSCROLL, SB_BOTTOM, 0);
  finally
    Free;
  end;
  // выводим сколько кругов осталось
  iLapsToGo := sBitBtn23.Tag - iLapsCompleted;
  if iLapsToGo > 1 then sBitBtn23.Caption :=
    IntToStr(sBitBtn23.Tag - iLapsCompleted) + strLAPSTOGO;
  if iLapsToGo = 1 then sBitBtn23.Caption := strLASTLAP;
  if iLapsToGo < 1 then sBitBtn23.Caption := 'ФИНИШ';
  // снимаем флаг процесса обновления
  bDoRacePanelRefresh := false;
end;

procedure TMainForm.RepaintNumberButtons(Sender: TObject);
var
  i, iBtnNum, iBtnWidth, iBtnHeight, iRows, iColumns, iFldWidth, iFldHeight, maxBtnSize : integer;
  k : real;
  Item : TControl;
begin
  // вычисление параметров кнопочного поля
  iFldWidth := spNumbersPanel.Width;
  iFldHeight := spNumbersPanel.Height;
  iBtnNum := RaceNumbers.Count;
  // https://toster.ru/q/165393
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
      DrawLight := false;
      DrawDropShadow := false;
      with Font do begin
        Size := iBtnHeight div 3;
        Style := [fsBold];
        Color := clBlack;
        Name := strPLATENUMBER_FONT_NAME;
      end;
      // сохраняем RACE_ID в Tag кнопки
      Tag := sCheckListBox2.Tag;
      onClick := OnPlateNumberClick;
//      Show;
    end;
  end;
  spNumbersPanel.Show;
end;

procedure TMainForm.ListView2CustomDraw(Sender: TCustomListView;
  const ARect: TRect; var DefaultDraw: Boolean);
begin
  with ListView2.Canvas do begin
//    Brush.Color := clLinen;
//    FillRect(ARect);
  end;
end;

procedure TMainForm.ListView2CustomDrawItem(Sender: TCustomListView;
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

procedure TMainForm.ListView2CustomDrawSubItem(Sender: TCustomListView;
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
    SQL.Text := 'select events.event_date, events.name, races.name, races.race_id from athletes, races, events, '
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
      end;
      Next;
    end;
  finally
    Free;
  end;
  // выравнивание ширины колонок
  for i := 0 to lvAthRaces.Columns.Count - 1 do begin
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
    // параметры заезда
    SQL.Text := 'select laps,track_length from races where race_id=' + IntToStr(RACE_ID) + ';';
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    Open;
    LAPS := Fields[0].AsInteger;
    TRACK_LENGTH := Fields[1].AsInteger;
    // время старта
    Close;
    SQL.Text := 'select timenote from timenotes where (race_id=' + IntToStr(RACE_ID)
      + ') and (platenumber=0);';
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    Open;
    strTIME_PREVIOUS := Fields[0].AsString;
    // времена кругов
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
        // ищем лучший круг
        if dtLapTime < dtBesLapTime then begin
          dtBesLapTime := dtLapTime;
          iBestLap := i;
        end;
        SubItems.Add(FormatDateTime(strTIMENOTE_FORMAT, dtLapTime));
        // скорость на круге
        if TRACK_LENGTH > 0 then begin
          rLapSpeed := (3600 * TRACK_LENGTH / SecondsBetween(StrToTime(strTIME_CURRENT, fs),
            StrToTime(strTIME_PREVIOUS, fs))) / 1000;
        end
        else rLapSpeed := 0;
        strTIME_PREVIOUS := strTIME_CURRENT;
        // определяем место на круге
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
        // проставляем прогресс
        if i > 1 then begin
          iShift := StrToInt(SubItems.Strings[1]) - StrToInt(lvAthStats.Items[i - 2].SubItems.Strings[1]);
          if iShift = 0 then SubItems.Add('-');
          if iShift > 0 then SubItems.Add('+' + IntToStr(iShift));
          if iShift < 0 then SubItems.Add(IntToStr(iShift));
        end
        else SubItems.Add('-');
        // скорость на круге
        SubItems.Add(FloatToStrF(rLapSpeed,ffGeneral, 6, 3));
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
  EVENT_ID := sCheckListBox1.Tag;
  strRaceName := ListView1.Items[ListView1.ItemIndex].Caption;
  strAthletName := ListView1.Items[ListView1.ItemIndex].SubItems[1];
  strAthletBirthDate := ListView1.Items[ListView1.ItemIndex].SubItems[2];
  if RusMessageDialog('Отменить регистрацию ' + strAthletName + ' на ' + strRaceName + '?',
    mtConfirmation, mbYesNo, ['ОК', 'Отмена']) = mryes
  then begin
    with TIBQuery.Create(nil) do try
      // извлекаем RACE_ID
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select race_id from races where (event_id=' + IntToStr(EVENT_ID)
        + ') and (name=''' + strRaceName + ''');';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      RACE_ID := Fields[0].AsInteger;
      // извлекаем ATHLET_ID
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
  TN_ID := Integer(ListView2.Items[ListView2.ItemIndex].Data);
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
  sEdit10.Text := Copy(FormatDateTime(strTIMENOTE_FORMAT, Now() - TIME_START),1,11);
  // сохраняем TN_ID в sPanel7.Tag
  sPanel7.Tag := TN_ID;
  // номера
  sComboBox5.Clear;
  for i := 0 to RaceNumbers.Count - 1 do sComboBox5.Items.Add(RaceNumbers[i]);
  sEdit10.Enabled := true;
  sComboBox5.DroppedDown := false;
  sPanel7.Show;
end;

procedure TMainForm.N4Click(Sender: TObject);
var
  i : integer;
begin
  // сохраняем TN_ID в sPanel7.Tag
  sPanel7.Tag := Integer(ListView2.Items[ListView2.ItemIndex].Data);
  // номера
  sComboBox5.Clear;
  for i := 0 to RaceNumbers.Count - 1 do sComboBox5.Items.Add(RaceNumbers[i]);
  sComboBox5.Text := ListView2.Items[ListView2.ItemIndex].SubItems.Strings[0];
  sEdit10.Text := ListView2.Items[ListView2.ItemIndex].Caption;
  sEdit10.Enabled := false;
  sPanel7.Show;
  sComboBox5.SetFocus;
  sComboBox5.DroppedDown := true;
end;

procedure TMainForm.sBitBtn10Click(Sender: TObject);
var
  i : integer;
  lItem : TListItem;
begin
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select race_id,name,laps,track_length from races where event_id='
      + IntToStr(sPanel2.Tag) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    i := 0;
    while sListBox2.ItemIndex > i do begin
      Next;
      inc(i);
    end;
    // race_id храним в sPanel3.Tag
    sPanel3.Tag := Fields[0].AsInteger;
    sEdit2.Text := Fields[1].AsString;
    sEdit3.Text := Fields[3].AsString;
    sEdit4.Text := Fields[2].AsString;
    // загрузка зачётов
    Close;
    SQL.Text := 'select cg_id,sex,agemin,agemax,laps from comp_groups where race_id='
      + IntToStr(sPanel3.Tag) + ';';
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
  sListBox2.Enabled := false;
  sBitBtn9.Enabled := false;
  sBitBtn11.Enabled := false;
  sBitBtn5.Enabled := false;
  sBitBtn8.Enabled := false;
  sEdit1.Enabled := false;
  DateTimePicker1.Enabled := false;
  sPanel3.Show;
end;

procedure TMainForm.sBitBtn11Click(Sender: TObject);
var
  i, RACE_ID : integer;
  bClear : boolean;
begin
  if sListBox2.ItemIndex <> -1 then begin
    if MessageDlg('Удалить заезд "' + sListBox2.Items.Strings[sListBox2.ItemIndex]
        + '"?', mtConfirmation, [mbyes, mbno], 0) = mryes then with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // поиск RACE_ID для удаления
      with TIBQuery.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        SQL.Text := 'select race_id,name,laps,track_length,status from races where event_id='
          + IntToStr(sPanel2.Tag) + ';';
        Open;
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
        FetchAll;
        First;
        i := 0;
        while sListBox2.ItemIndex > i do begin
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
    sBitBtn7Click(Self);
  end
  else ShowMessage(strRACE_NOT_DELECTED);
end;

procedure TMainForm.sBitBtn12Click(Sender: TObject);
begin
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // если создать
    if sPanel3.Tag = 0 then SQL.Text := 'insert into races(race_id,event_id,name,laps,track_length) '
      + 'values((select max(race_id) from races) + 1,' + IntToStr(sPanel2.Tag) + ','''
      + sEdit2.Text + ''',' + sEdit4.Text + ',' + sEdit3.Text +  ');'
    // если изменить
    else SQL.Text := 'update races set name=''' + sEdit2.Text + ''',laps='
      + sEdit4.Text + ',track_length=' + sEdit3.Text + ' where race_id=' + IntToStr(sPanel3.Tag) + ';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    sPanel3.Hide;
  finally
    Free;
  end;
  sBitBtn5.Enabled := true;
  sBitBtn8.Enabled := true;
  sBitBtn9.Enabled := true;
  sBitBtn10.Enabled := true;
  sBitBtn11.Enabled := true;
  sListBox2.Enabled := true;
  sEdit1.Enabled := true;
  DateTimePicker1.Enabled := true;
  // refresh
  sBitBtn7Click(Self);
end;

procedure TMainForm.sBitBtn13Click(Sender: TObject);
begin
  sPanel3.Hide;
  sBitBtn5.Enabled := true;
  sBitBtn8.Enabled := true;
  sBitBtn9.Enabled := true;
  sBitBtn10.Enabled := true;
  sBitBtn11.Enabled := true;
  sListBox2.Enabled := true;
  sEdit1.Enabled := true;
  DateTimePicker1.Enabled := true;
end;

procedure TMainForm.sBitBtn14Click(Sender: TObject);
var
  i, EVENT_ID : integer;
begin
  if tsRegistration.Visible then begin
    // Если прееход с регистрации
    EVENT_ID := sCheckListBox1.Tag;
  end;
  if tsEvent.Visible then begin
    // Если переход со списка соревнований
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select event_id,event_date,name from events order by event_date;';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      First;
      i := 0;
      while sListBox1.ItemIndex > i do begin
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
      SQL.Text := 'select event_id,event_date,name from events order by event_date;';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      First;
      i := 0;
      while sComboBox3.ItemIndex > i do begin
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
  sComboBox4.Tag := EVENT_ID;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // список мероприятий
    SQL.Text := 'select event_id,event_date,name from events order by event_date;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    sComboBox3.Items.Clear;
    i := 0;
    while not(EOF) do begin
      sComboBox3.Items.Add(Fields[2].AsString);
      // выбранное мероприятие
      if Fields[0].AsInteger = EVENT_ID then sComboBox3.ItemIndex := i;
      inc(i);
      Next;
    end;
    // список заездов
    Close;
    SQL.Text := 'select race_id,laps,track_length,name,status from races where event_id=' + IntToStr(EVENT_ID) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    sComboBox4.Items.Clear;
    while not(EOF) do begin
      sComboBox4.Items.Add(Fields[3].AsString);
      Next;
    end;
    if sComboBox4.Items.Count > 0 then begin
      sComboBox4.ItemIndex := 0;
      spRacePanel.Show;
      // refresh
      sComboBox4Change(Self);
    end
    else spRacePanel.Hide;
  finally
    Free;
  end;

  tsStart.Show;
  PageControl2.ActivePage := tsStartPrep;
  sBitBtn1.Font.Style := [];
  sBitBtn2.Font.Style := [];
  sBitBtn3.Font.Style := [];
  sBitBtn14.Font.Style := [fsBold];
  sBitBtn17.Font.Style := [];
end;

procedure TMainForm.sBitBtn15Click(Sender: TObject);
begin
  sEdit5.Tag := 0;
  sEdit5.Clear;
  sEdit6.Clear;
  sEdit6.Clear;
  sCheckBox1.Checked := true;
  sCheckBox2.Checked := false;
  DateTimePicker2.Date := Now;
  sEdit5.ReadOnly := false;
  sEdit6.ReadOnly := false;
  sEdit7.ReadOnly := false;
  sEdit8.Hide;
  sBitBtn19.Hide;
end;

procedure TMainForm.sBitBtn16Click(Sender: TObject);
begin
  sEdit8.Text := '';
  sEdit8.Show;
  sBitBtn19.Show;
  sEdit8.SetFocus;
end;

procedure TMainForm.sBitBtn17Click(Sender: TObject);
begin
  sBitBtn1.Font.Style := [];
  sBitBtn2.Font.Style := [];
  sBitBtn3.Font.Style := [];
  sBitBtn14.Font.Style := [];
  sBitBtn17.Font.Style := [fsBold];
  tsSettings.Show;
end;

procedure TMainForm.sBitBtn18Click(Sender: TObject);
var
  i, EVENT_ID, ATHLET_ID, RACE_ID, REG_ID : integer;
  SEX : string;
  bRacesSelected : boolean;
begin
  bRacesSelected := false;
  // сначала смотрим выбраны ли вообще заезды
  for i := 0 to sCheckListBox1.Items.Count - 1 do
    if sCheckListBox1.Checked[i] then bRacesSelected := true;
  // проверяем заполнение обязательных полей
  if (sEdit5.Text <> '') and (sComboBox2.Text <> '') and bRacesSelected then begin
    EVENT_ID := sCheckListBox1.Tag;
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // добавляем (выбираем) участника. признак (новый/неновый) - sEdit5.Tag
      if sEdit5.Tag = 0 then begin
        // если новый участник
        if sCheckBox1.Checked then SEX := 'М' else SEX := 'Ж';
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
        SQL.Text := 'insert into athletes(athlet_id,name,date_born,sex,team,city) values('
          + IntToStr(ATHLET_ID) + ',''' + sEdit5.Text + ''','''
          + FormatDateTime(strSIMPLEDATEFORMAT, DateTimePicker2.Date) + ''',''' + SEX + ''','''
          + sEdit6.Text + ''',''' + sEdit7.Text + ''');';
        ExecQuery;
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      end
      else begin
        // если участник выбран через поиск
        ATHLET_ID := sEdit5.Tag;
      end;
      // выбираем гонки для регистрации
      for i := 0 to sCheckListBox1.Count - 1 do if sCheckListBox1.Checked[i] then begin
        // извлекаем RACE_ID
        with tIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text := 'select race_id,name,track_length,laps from races where event_id='
            + IntToStr(EVENT_ID) + ';';
          Open;
          LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
          FetchAll;
          First;
          while not(EOF) and (sCheckListBox1.Items.Strings[i] <> Fields[1].AsString) do begin
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
        SQL.Text := 'insert into registry(reg_id,platenumber,athlet_id,race_id) values('
          + IntToStr(REG_ID) + ',' + sComboBox2.Text + ','
          + IntToStr(ATHLET_ID) + ',' + IntToStr(RACE_ID) + ');';
        ExecQuery;
        LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      end;
    finally
      Free;
    end;
    // refresh
    sComboBox1Change(Self);
    sBitBtn15Click(Self);
  end
  else ShowMessage(strREQUIRED_FIELDS_MISSING);
end;

procedure TMainForm.SelectAthlet(Sender: TObject);
var
  ATHLET_ID : integer;
begin
  ATHLET_ID := (Sender as TMenuItem).Tag;
  // сохраняем ATHLET_ID в sEdit5.Tag для последующего избежания добавления нового участника
  sEdit5.Tag := ATHLET_ID;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select name,date_born,sex,team,city from athletes where athlet_id='
      + IntToStr(ATHLET_ID) + ' order by name;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    sEdit5.Text := Fields[0].AsString;
    sEdit6.Text := Fields[3].AsString;
    sEdit7.Text := Fields[4].AsString;
    DateTimePicker2.Date := Fields[1].AsDateTime;
    sCheckBox1.Checked := Fields[2].AsString = 'М';
    sCheckBox2.Checked := not(sCheckBox1.Checked);
  finally
    Free;
  end;
  sEdit5.ReadOnly := true;
  sEdit6.ReadOnly := true;
  sEdit7.ReadOnly := true;
  sEdit8.Hide;
  sBitBtn19.Hide;
end;


procedure TMainForm.sBitBtn19Click(Sender: TObject);
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
      + sEdit8.Text + '%'' order by name;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    while not(EOF) do begin
      // поиск среди уже зарегистрированных
      ATHLET_ID := Fields[0].AsInteger;
      with TIBQuery.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        SQL.Text := 'select * from registry,races where (registry.race_id=races.race_id)'
          + 'and(athlet_id=' + IntToStr(ATHLET_ID) + ')and(races.event_id='
          + IntToStr(sCheckListBox1.Tag) + ');';
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
        // сохраняем athlet_id в mItem.Tag
        mItem.Tag := ATHLET_ID;
        mItem.OnClick := SelectAthlet;
        PopupMenu1.Items.Add(mItem);
      end;
      Next;
    end;
    PopupMenu1.Popup(Left + sEdit8.Left, Top + sPanel1.Height + sEdit5.Top + sEdit5.Height);
  finally
    Free;
  end;
end;

procedure TMainForm.sBitBtn1Click(Sender: TObject);
begin
  sBitBtn1.Font.Style := [fsBold];
  sBitBtn2.Font.Style := [];
  sBitBtn3.Font.Style := [];
  sBitBtn14.Font.Style := [];
  sBitBtn17.Font.Style := [];
  tsAthletes.Show;
end;

procedure TMainForm.sBitBtn20Click(Sender: TObject);
var
  i, j : integer;
  Buffer : TStringList;
  str : string;
begin
  sBitBtn21.Enabled := true;
  // исключаем не прошедших проверку
  Buffer := TStringList.Create;
  for i := 0 to sCheckListBox2.Count - 1 do begin
    if sCheckListBox2.Checked[i] then Buffer.Add(RaceNumbers[i]);
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
      + ''' where race_id=' + IntToStr(sCheckListBox2.Tag) + ';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
  finally
    Free;
  end;
  sCheckListBox2.Enabled := false;
  sLabelFX6.Caption := strREADY_TO_RACE;
end;

procedure TMainForm.sBitBtn21Click(Sender: TObject);
begin
  RefreshRacePanel;
  tsRacePanel.Show;
  spRacePanel.Enabled := true;
  sBitBtn23.Enabled := true;
  if not(sBitBtn22.Enabled) then RepaintNumberButtons(Sender);

end;

procedure TMainForm.sBitBtn22Click(Sender: TObject);
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
  RACE_ID := sCheckListBox2.Tag;
  TIME_START := Now();
  // фигарим в базу номер "0" - признак старта заезда
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'insert into timenotes(tn_id,race_id,platenumber,timenote) values('
      + IntToStr(LAST_TN_ID + 1) + ',' + IntToStr(RACE_ID) + ',0,'''
      + FormatDateTime(strTIMENOTE_FORMAT, TIME_START) + ''');';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    sBitBtn22.Enabled := false;
    Timer.Enabled := true;
  finally
    Free;
  end;
  spRacePanel.Enabled := true;
  sBitBtn22.Enabled := false;
  // выводим сколько осталось кругов
  // и запихиваем в Tag кнопки ФИНИШ
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select laps from races where race_id=' + IntToStr(RACE_ID) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    sBitBtn23.Tag := Fields[0].AsInteger;
    sBitBtn23.Caption := IntToStr(sBitBtn23.Tag) + strLAPSTOGO;
    sBitBtn23.Enabled := true;
  finally
    Free;
  end;
  RepaintNumberButtons(Sender);
end;

procedure TMainForm.sBitBtn23Click(Sender: TObject);
var
  i, RACE_ID : integer;
  strSEX, strAGEMIN, strAGEMAX: string;
  Item : TControl;
begin
  if RusMessageDialog(strCOMPLETE_RACE, mtConfirmation, mbYesNo, ['ОК', 'Отмена']) = mryes
  then begin
    Timer.Enabled := false;
    // забираем RACE_ID из spNumbersPanel.Tag
    RACE_ID := spNumbersPanel.Tag;
    sBitBtn22.Enabled := true;
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
    // сохраняем RACE_ID в sComboBox6.Tag
    sComboBox6.Tag := RACE_ID;
    tsRaceResults.Show;
    sBitBtn23.Enabled := false;
    // refresh
    sComboBox6Change(Self);
  end;
end;

procedure TMainForm.sBitBtn24Click(Sender: TObject);
begin
  RefreshRacePanel;
end;

procedure TMainForm.sBitBtn25Click(Sender: TObject);
begin
  // зачитка данных ВСЕХ заездов
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // все гонки в процессе переводим в нестартованные
    SQL.Text := 'update races set status='''' where status=''' + strRACE_STATUS_STARTED + ''';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    Close;
    // все завершённые гонки в переводим в нестартованные
    SQL.Text := 'update races set status='''' where status=''' + strRACE_STATUS_FINISHED + ''';';
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

procedure TMainForm.sBitBtn26Click(Sender: TObject);
var
  i, TN_ID, RACE_ID : integer;
  strTIMENOTE, StrAbsTime : string;
  bValidData : boolean;
begin
  // берём TN_ID из sPanel7.Tag
  TN_ID := sPanel7.Tag;
  // берём RACE_ID из spNumbersPanel.Tag
  RACE_ID := spNumbersPanel.Tag;
  // проверяем корректность данных
  bValidData := false;
  for i := 0 to RaceNumbers.Count - 1 do
    if RaceNumbers.Strings[i] = sComboBox5.Text then bValidData := true;
  strTIMENOTE := sEdit10.Text;
  if (strTIMENOTE[3] <> ':') or (strTIMENOTE[6] <> ':') or (strTIMENOTE[9] <> '.')
  then bValidData := false;
  // если ОК, пишем в базу
  if bValidData then begin
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // признак добавления/изменения - sEdit10.Enabled
      if sEdit10.Enabled then begin
        // вычисляем и пишем абсолютное время (время старта + время отметки )
        strAbsTime := FormatDateTime(strTIMENOTE_FORMAT, TIME_START + StrToTime(strTIMENOTE, fs));
        SQL.Text := 'insert into timenotes(tn_id,platenumber,race_id,timenote) values('
          + IntToStr(TN_ID) + ',' + sComboBox5.Text + ',' + IntToStr(RACE_ID) + ','''
          + strAbsTime + ''');'
      end
      else SQL.Text := 'update timenotes set platenumber=' + sComboBox5.Text
        + ' where TN_ID=' + IntToStr(TN_ID) + ';';
      ExecQuery;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    finally
      Free;
    end;
    RefreshRacePanel;
    sPanel7.Hide;
  end
  else ShowMessage(strINVALID_TIMENOTE_DATA);
end;

procedure TMainForm.sBitBtn27Click(Sender: TObject);
begin
  sPanel7.Hide;
end;

procedure TMainForm.sBitBtn28Click(Sender: TObject);
begin
  sCheckBox3.Checked := false;
  sCheckBox4.Checked := false;
  sCheckBox5.Checked := false;
  sCheckBox6.Checked := false;
  sEdit9.Enabled := false;
  sEdit9.Clear;
  sEdit11.Enabled := false;
  sEdit11.Clear;
  sEdit12.Text := sEdit4.Text;
  sPanel9.Show;
  sBitBtn29.Enabled := false;
end;

procedure TMainForm.sBitBtn29Click(Sender: TObject);
begin
  if lvCompGroups.ItemIndex <> -1 then begin
    if RusMessageDialog(strDELETE_COMP_GROUP, mtConfirmation, mbYesNo, ['ОК', 'Отмена']) = mryes
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
      sBitBtn10Click(Self);
    end;
  end
  else ShowMessage(strCOMP_GROUP_NOT_SELECTED);
end;

function ScrollBarVisible(Handle : HWnd; Style : Longint) : Boolean;
begin
  Result := (GetWindowLong(Handle, GWL_STYLE) and Style) <> 0;
end;

procedure TMainForm.sBitBtn2Click(Sender: TObject);
begin
  sBitBtn1.Font.Style := [];
  sBitBtn2.Font.Style := [fsBold];
  sBitBtn3.Font.Style := [];
  sBitBtn14.Font.Style := [];
  sBitBtn17.Font.Style := [];
  tsEvent.Show;
end;

procedure TMainForm.sBitBtn30Click(Sender: TObject);
var
  CG_ID, RACE_ID, AGEMIN, AGEMAX, LAPS : integer;
  SEX : string;
begin
  RACE_ID := sPanel3.Tag;
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
  if sCheckBox3.Checked then SEX := 'М';
  if sCheckBox4.Checked then SEX := 'Ж';
  if sCheckBox5.Checked then AGEMIN := StrToInt(sEdit9.Text) else AGEMIN := 0;
  if sCheckBox6.Checked then AGEMAX := StrToInt(sEdit11.Text) else AGEMAX := 0;
  if sEdit12.Text <> '' then LAPS := StrToInt(sEdit12.Text) else LAPS := 0;

  // херачим в базу новую зачётную группу
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
  sPanel9.Hide;
  sBitBtn29.Enabled := true;
  // refresh
  sBitBtn10Click(Self);
end;

procedure TMainForm.sBitBtn31Click(Sender: TObject);
begin
  sPanel9.Hide;
  sBitBtn29.Enabled := true;
end;

procedure TMainForm.sBitBtn32Click(Sender: TObject);
begin
  tsRaceResults.Show;
//  RefreshRacePanel;
  Timer.Enabled := false;
  spRacePanel.Enabled := true;
  sBitBtn23.Enabled := false;
  // refresh
  sComboBox6Change(Self);
end;

procedure TMainForm.sBitBtn3Click(Sender: TObject);
var
  i : integer;
begin
  sBitBtn1.Font.Style := [];
  sBitBtn2.Font.Style := [];
  sBitBtn3.Font.Style := [fsBold];
  sBitBtn14.Font.Style := [];
  sBitBtn17.Font.Style := [];
  tsRegistration.Show;
  sComboBox1.ItemIndex := sListBox1.ItemIndex;
  sComboBox1Change(Self);
end;

procedure TMainForm.sBitBtn4Click(Sender: TObject);
begin
  sEdit1.Clear;
  sPanel2.Tag := 0;
  sPanel4.Hide;
  sPanel2.Show;
  sEdit1.SetFocus;
  sListBox1.Enabled := false;
  sBitBtn7.Enabled := false;
  sBitBtn6.Enabled := false;
end;

procedure TMainForm.sBitBtn5Click(Sender: TObject);
begin
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // если создать
    if sPanel2.Tag = 0 then SQL.Text :=
      'insert into events(event_id,event_date,name) values((select max(event_id) from events) + 1,'''
      + FormatDateTime(strSIMPLEDATEFORMAT, DateTimePicker1.Date) + ''','''
      + sEdit1.Text + ''')'
    // изменить
    else
      SQL.Text := 'update events set name=''' + sEdit1.Text +  ''',event_date='''
        + FormatDateTime(strSIMPLEDATEFORMAT, DateTimePicker1.Date) + ''' where event_id='
        + IntToStr(sPanel2.Tag) + ';';
    ExecQuery;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    sPanel2.Hide;
  finally
    Free;
  end;
  // обновить список
  tsEventShow(Self);
  sListBox1.Enabled := true;
  sBitBtn4.Enabled := true;
  sBitBtn6.Enabled := true;
  sBitBtn7.Enabled := true;
  sListBox1.SetFocus;
end;

procedure TMainForm.sBitBtn6Click(Sender: TObject);
var
  i, EVENT_ID : integer;
  bClear : boolean;
begin
  if MessageDlg('Удалить мероприятие "' + sListBox1.Items.Strings[sListBox1.ItemIndex]
      + '"?', mtConfirmation, [mbyes, mbno], 0) = mryes then with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    with TIBQuery.Create(nil) do try
      // поиск EVENT_ID для удаления
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select event_id,event_date,name from events order by event_date;';
      Open;
      LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
      FetchAll;
      First;
      i := 0;
      while sListBox1.ItemIndex > i do begin
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

procedure TMainForm.sBitBtn7Click(Sender: TObject);
var
  i : integer;
begin
  sListBox2.Clear;
  sListBox1.Enabled := false;
  sBitBtn4.Enabled := false;
  sBitBtn6.Enabled := false;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select event_id,event_date,name from events order by event_date;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    i := 0;
    while sListBox1.ItemIndex > i do begin
      Next;
      inc(i);
    end;
    sEdit1.Text := Fields[2].AsString;
    DateTimePicker1.Date := Fields[1].AsDateTime;
    // event_id храним в sPanel2.Tag
    sPanel2.Tag := Fields[0].AsInteger;
    // выбираем заезды
    Close;
    SQL.Text := 'select race_id,name,track_length,laps from races where event_id='
      + IntToStr(sPanel2.Tag) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    while not(EOF) do begin
      sListBox2.Items.Add(Fields[1].AsString + ' (' + IntToStr(Fields[3].AsInteger)
        + 'кр. по ' + IntToStr(Fields[2].AsInteger) + 'м)');
      Next;
    end;
  finally
    Free;
  end;
  sPanel2.Show;
  sPanel4.Show;
end;

procedure TMainForm.sBitBtn8Click(Sender: TObject);
begin
  sPanel2.Hide;
  sListBox1.Enabled := true;
  sBitBtn4.Enabled := true;
  sBitBtn6.Enabled := true;
  sBitBtn7.Enabled := true;
  sListBox1.SetFocus;
end;

procedure TMainForm.sBitBtn9Click(Sender: TObject);
begin
  sEdit2.Clear;
  sEdit3.Clear;
  sEdit4.Clear;
  sPanel3.Tag := 0;
  sPanel3.Show;
  sBitBtn5.Enabled := false;
  sBitBtn8.Enabled := false;
  sEdit2.SetFocus;
end;

procedure TMainForm.sCheckBox1Click(Sender: TObject);
begin
  sCheckBox2.Checked := not(sCheckBox1.Checked);
end;

procedure TMainForm.sCheckBox2Click(Sender: TObject);
begin
  sCheckBox1.Checked := not(sCheckBox2.Checked);
end;

procedure TMainForm.sCheckBox3Click(Sender: TObject);
begin
  sCheckBox4.Checked := not(sCheckBox3.Checked);
end;

procedure TMainForm.sCheckBox4Click(Sender: TObject);
begin
  sCheckBox3.Checked := not(sCheckBox4.Checked);
end;

procedure TMainForm.sCheckBox5Click(Sender: TObject);
begin
  sEdit9.Enabled := sCheckBox5.Checked;
  if sCheckBox5.Checked then sEdit9.SetFocus;
end;

procedure TMainForm.sCheckBox6Click(Sender: TObject);
begin
  sEdit11.Enabled := sCheckBox6.Checked;
  if sCheckBox6.Checked then sEdit11.SetFocus;
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
    // сохраним EVENT_ID в sCheckListBox1.Tag
    sCheckListBox1.Tag := EVENT_ID;
    // список заездов
    Close;
    SQL.Text := 'select race_id,name,track_length,laps from races where event_id='
      + IntToStr(EVENT_ID) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    sCheckListBox1.Clear;
    while not(EOF) do begin
      sCheckListBox1.Items.Add(Fields[1].AsString);
      Next;
    end;
    // список уже зарегистрировавшихся, выдача свободных номеров
    sComboBox2.Items.Clear;
    for i := 1 to PLATENUMBERS_COUNT do sComboBox2.Items.Add(IntToStr(i));
    Close;
    SQL.Text := 'select distinct registry.platenumber, athletes.name, athletes.date_born, races.name, races.race_id '
      + 'from registry, athletes, races, events where (registry.race_id = races.race_id) and (races.event_id = events.event_id)'
      + 'and (athletes.athlet_id = registry.athlet_id) and (races.event_id = ' + IntToStr(EVENT_ID)
      + ') order by races.race_id, registry.platenumber;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    ListView1.Items.Clear;
    while not(EOF) do begin
      lItem := ListView1.Items.Add;
      with lItem do begin
        j := 0;
        for j := 0 to sComboBox2.Items.Count - 1 do
          if sComboBox2.Items.Strings[j] = IntToStr(Fields[0].AsInteger)
          then sComboBox2.Items.Delete(j);
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

procedure TMainForm.sComboBox3Change(Sender: TObject);
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
      if Fields[2].AsString = SComboBox3.Text then EVENT_ID := Fields[0].AsInteger;
      Next;
    end;
    Close;
    SQL.Text := 'select race_id,laps,track_length,name,status from races where event_id='
      + IntToStr(EVENT_ID) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    sComboBox4.Items.Clear;
    // схраняем EVENT_ID в sComboBox4.Tag
    sComboBox4.Tag := EVENT_ID;
    while not(EOF) do begin
      sComboBox4.Items.Add(Fields[3].AsString);
      Next;
    end;
    if sComboBox4.Items.Count > 0 then begin
      sComboBox4.ItemIndex := 0;
      spRacePanel.Show;
      // refresh
      sComboBox4Change(Self);
      RefreshRacePanel;
    end
    else spRacePanel.Hide;
  finally
    Free;
  end;
end;

procedure TMainForm.sComboBox4Change(Sender: TObject);
var
  EVENT_ID, RACE_ID, LAPS : integer;
  STATUS : string;
begin
  EVENT_ID := sComboBox4.Tag;
  PageControl2.Show;
  tsStartPrep.Show;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ищем race_id
    SQL.Text := 'select race_id,laps,track_length,name,status from races where event_id='
      + IntToStr(EVENT_ID) + ';';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    while not(EOF) do begin
      if sComboBox4.Text = Fields[3].AsString then begin
        RACE_ID := Fields[0].AsInteger;
        LAPS := Fields[1].AsInteger;
        STATUS := Fields[4].AsString;
      end;
      Next;
    end;
    // загружаем участников
    // параллельно заполняем массив номеров для предстартовой проверки
    Close;
    SQL.Text := 'select registry.platenumber, athletes.name from registry, athletes '
      + 'where (registry.athlet_id = athletes.athlet_id) and (registry.race_id = '
      + IntToStr(RACE_ID) + ') order by registry.platenumber;';
    Open;
    LogIt(llDEBUG, strEXEC_SQL + SQL.Text);
    FetchAll;
    First;
    sCheckListBox2.Clear;
    RaceNumbers.Clear;
    while not(EOF) do begin
      sCheckListBox2.Items.Add(IntToStr(Fields[0].AsInteger) + ' - ' + Fields[1].AsString);
      sCheckListBox2.Checked[sCheckListBox2.Items.Count - 1] := true;
      RaceNumbers.Add(IntToStr(Fields[0].AsInteger));
      Next;
    end;
  finally
    Free;
  end;
  // проверка статуса гонки
  if STATUS = strRACE_STATUS_STARTED then begin
    sLabelFX6.Caption := strREADY_TO_RACE;
    sCheckListBox2.Enabled := false;
    sBitBtn20.Enabled := false;
    sBitBtn21.Enabled := true;
    sBitBtn32.Enabled := false;
    sBitBtn22.Enabled := true;
    sBitBtn23.Enabled := true;
    spRacePanel.Enabled := false;
    spRacePanel.Show;
  end;
  if STATUS = strRACE_STATUS_FINISHED then begin
    sLabelFX6.Caption := strRACE_FINISHED;
    sCheckListBox2.Enabled := false;
    sBitBtn20.Enabled := false;
    sBitBtn21.Enabled := false;
    sBitBtn32.Enabled := true;
    spRacePanel.Enabled := true;
    sBitBtn22.Enabled := false;
    sBitBtn23.Enabled := false;
    Timer.Enabled := false;
    spRacePanel.Show;
  end;
  if STATUS = '' then begin
    sLabelFX6.Caption := strPRERACE_CHECK_REQUIRED;
    sCheckListBox2.Enabled := true;
    sBitBtn20.Enabled := true;
    sBitBtn21.Enabled := false;
    sBitBtn32.Enabled := false;
    spRacePanel.Enabled := false;
    sBitBtn22.Enabled := false;
    sBitBtn23.Enabled := false;
    Timer.Enabled := false;
    spRacePanel.Hide;
  end;
  // сохраняем race_id в sCheckListBox2.Tag и spNumbersPanel.Tag
  sCheckListBox2.Tag := RACE_ID;
  spNumbersPanel.Tag := RACE_ID;
  sComboBox6.Tag := RACE_ID;
  // refresh
  sTimerLabel.Caption := strTIMER_CAPTION;
  RefreshRacePanel;
end;

procedure TMainForm.sComboBox6Change(Sender: TObject);
var
  i, RACE_ID, iPlace, iLeaderLaps, iAthleteLaps, PLATENUMBER, iAGE, iAGEMIN, iAGEMAX, iLAPS : integer;
  strTIMENOTE, strTIMESTART, strTIMELEADER, strShift, strSEX : string;
  bToApplyFilter, bIsFiltered : boolean;
  dtShift : TDateTime;
  lItem : TListItem;
begin
  lvResults.Hide;
  spbResults.Show;
  // берём RACE_ID из sComboBox6.Tag
  RACE_ID := sComboBox6.Tag;
  bToApplyFilter := sComboBox6.ItemIndex > 0;
  lvResults.Items.Clear;
  // выборка резултата гонки. номера с количенством кругов и временем по абсолюту
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
      while i < sComboBox6.ItemIndex do begin
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
    if (bToApplyFilter) and (iLAPS <> 0) then SQL.Text := 'select platenumber, count(platenumber), '
      + 'max(timenote) from (select platenumber, lap, timenote from (select tn_id, timenote, '
      + 'platenumber, (select count(*) from timenotes b where (b.tn_id < a.tn_id) and '
      + '(a.platenumber = b.platenumber) and (race_id = ' + IntToStr(RACE_ID)
      + ')) + 1 as lap from timenotes a where (race_id = ' + IntToStr(RACE_ID) + ')) where lap <= '
      + IntToStr(iLAPS) + ' order by timenote) group by platenumber order by count(platenumber) '
      + 'desc, max(timenote);'
    // или если абсолют
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
      // Отсекаем признак старта заезда
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
          // применяем фильтрацию если необходимо
          if bToApplyFilter then begin
            // возраст
            iAGE := YearsBetween(StrToDate('31.12.' + FormatDateTime('yyyy', Now),fs),
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
                  strShift := Copy(FormatDateTime(strTIMENOTE_FORMAT, dtShift),1,11);
                  strTIMELEADER := strTIMENOTE;
                end
                else begin
                  // если не первый - отставание от лидера
                  dtShift := StrToTime(strTIMENOTE, fs) - StrToTime(strTIMELEADER, fs);
                  strShift := '+' + Copy(FormatDateTime(strTIMENOTE_FORMAT, dtShift),1,11);
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

procedure TMainForm.sComboBox7Change(Sender: TObject);
begin
  logLevel := sComboBox7.ItemIndex;
  Config.WriteInteger('Logging', 'Level', logLevel);
end;

procedure TMainForm.sEdit8Change(Sender: TObject);
begin
  sBitBtn19.Enabled := sEdit8.Text <> '';
end;

procedure TMainForm.sEdit8KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then sBitBtn19Click(Self);
  if Key = 27 then begin
    sEdit8.Hide;
    sBitBtn19.Hide;
  end;
end;

procedure TMainForm.sListBox1DblClick(Sender: TObject);
begin
  sBitBtn3Click(Self);
end;

procedure TMainForm.sListBox1Enter(Sender: TObject);
begin
  sBitBtn3.Enabled := true;
  sBitBtn14.Enabled := true;
end;

procedure TMainForm.spNumbersPanelResize(Sender: TObject);
begin
  if (PageControl2.ActivePage = tsRacePanel) and (PageControl1.ActivePage = tsStart)
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
  sBitBtn22.Enabled := false;
  spRacePanel.Show;
  RACE_ID := sComboBox6.Tag;
  with sComboBox6 do begin
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
        else strAGEMIN := ' от ' + IntToStr(Fields[1].AsInteger);
        if Fields[2].AsInteger = 0 then strAGEMAX := ''
        else strAGEMAX := ' до ' + IntToStr(Fields[2].AsInteger);
        if Fields[3].AsInteger = 0 then strLAPS := ''
        else strLAPS := ' (' + IntToStr(Fields[3].AsInteger) + ' кр)';
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
  sComboBox7.ItemIndex := logLevel;
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
  // выравниваие ширины колонок
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
    sListBox1.Clear;
    while not(EOF) do begin
      sListBox1.Items.Add('[' + FormatDateTime(strSIMPLEDATEFORMAT, Fields[1].AsDateTime) + '] '
        + Fields[2].AsString);
      Next;
    end;
  finally
    Free;
  end;
end;

end.

