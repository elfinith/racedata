unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, ComCtrls, ExtCtrls, sPanel,
  sButton, sListBox, sLabel, sEdit, IBDatabase, DB, IBSQL, IBQuery, sComboBox,
  sCheckListBox, sCheckBox, sScrollBar, Menus, sSkinProvider, ImgList,
  FreeButton, acTitleBar, DateUtils;

const
  PLATENUMBERS_COUNT = 50;
  strPLATENUMBER_FONT_NAME = 'Century Gothic';
  strTIMENOTE_FORMAT = 'hh:mm:ss.zzz';
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
    sPanel1: TsPanel;
    sBitBtn2: TsBitBtn;
    sBitBtn1: TsBitBtn;
    sBitBtn3: TsBitBtn;
    PageControl1: TPageControl;
    tsRegistration: TTabSheet;
    tsEvent: TTabSheet;
    tsStart: TTabSheet;
    sListBox1: TsListBox;
    sBitBtn4: TsBitBtn;
    sLabelFX1: TsLabelFX;
    sPanel2: TsPanel;
    sEdit1: TsEdit;
    sLabel2: TsLabel;
    sLabel1: TsLabel;
    DateTimePicker1: TDateTimePicker;
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
    ListView1: TListView;
    sLabel9: TsLabel;
    sLabel10: TsLabel;
    DateTimePicker2: TDateTimePicker;
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
    PageControl2: TPageControl;
    tsStartPrep: TTabSheet;
    tsRacePanel: TTabSheet;
    sCheckListBox2: TsCheckListBox;
    sLabel14: TsLabel;
    sBitBtn20: TsBitBtn;
    sBitBtn21: TsBitBtn;
    sLabelFX6: TsLabelFX;
    sPanel5: TsPanel;
    sPanel6: TsPanel;
    Splitter1: TSplitter;
    sBitBtn22: TsBitBtn;
    sBitBtn23: TsBitBtn;
    sBitBtn24: TsBitBtn;
    ListView2: TListView;
    tsRaceResults: TTabSheet;
    tsAthletes: TTabSheet;
    tsSettings: TTabSheet;
    sTimerLabel: TsLabel;
    Timer: TTimer;
    sBitBtn25: TsBitBtn;
    pmRPMenu: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    sPanel7: TsPanel;
    sBitBtn26: TsBitBtn;
    sBitBtn27: TsBitBtn;
    N4: TMenuItem;
    sEdit10: TsEdit;
    sComboBox5: TsComboBox;
    sLabelFX7: TsLabelFX;
    lvCompGroups: TListView;
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
    sComboBox6: TsComboBox;
    sLabel17: TsLabel;
    sBitBtn32: TsBitBtn;
    lvResults: TListView;
    sEdit12: TsEdit;
    sLabel18: TsLabel;
    sBitBtn33: TsBitBtn;
    sBitBtn34: TsBitBtn;
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
    procedure sPanel5Resize(Sender: TObject);
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
  private
    { Private declarations }
  public
    { Public declarations }
    fs: TFormatSettings;
    RaceNumbers : TStringList;
    TIME_START : TDateTime;
    procedure SelectAthlet(Sender: TObject);
    procedure RepaintNumberButtons(Sender: TObject);
    procedure OnPlateNumberClick(Sender: TObject);
    procedure RefreshRacePanel;

  end;

var
  MainForm: TMainForm;
  function ScrollBarVisible(Handle : HWnd; Style : Longint) : Boolean;

implementation

{$R *.dfm}

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

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DBase.DatabaseName := ExtractFilePath(Application.ExeName) + 'DBASE.FDB';
  try
    DBase.Connected := True;
    DBTran.Active := True;
  except
    ShowMessage(strDB_CONNECTION_ERROR);
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

procedure TMainForm.N1Click(Sender: TObject);
var
  strRaceName, strAthletName, strAthletBirthDate : string;
  EVENT_ID, RACE_ID, ATHLET_ID : integer;
begin
  EVENT_ID := sCheckListBox1.Tag;
  strRaceName := ListView1.Items[ListView1.ItemIndex].Caption;
  strAthletName := ListView1.Items[ListView1.ItemIndex].SubItems[1];
  strAthletBirthDate := ListView1.Items[ListView1.ItemIndex].SubItems[2];
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
      FetchAll;
      RACE_ID := Fields[0].AsInteger;
      // ��������� ATHLET_ID
      Close;
      SQL.Text := 'select athlet_id from athletes where (name=''' + strAthletName
        + ''') and (date_born=''' + strAthletBirthDate + ''');';
      Open;
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
    TN_ID := Fields[0].AsInteger + 1;
  finally
    Free;
  end;
  // ����������� ������� ����� (���� ���� ������� ������)
  sEdit10.Text := Copy(FormatDateTime(strTIMENOTE_FORMAT, Now() - TIME_START),1,11);
  // ��������� TN_ID � sPanel7.Tag
  sPanel7.Tag := TN_ID;
  // ������
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
  // ��������� TN_ID � sPanel7.Tag
  sPanel7.Tag := Integer(ListView2.Items[ListView2.ItemIndex].Data);
  // ������
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
    FetchAll;
    First;
    i := 0;
    while sListBox2.ItemIndex > i do begin
      Next;
      inc(i);
    end;
    // race_id ������ � sPanel3.Tag
    sPanel3.Tag := Fields[0].AsInteger;
    sEdit2.Text := Fields[1].AsString;
    sEdit3.Text := Fields[3].AsString;
    sEdit4.Text := Fields[2].AsString;
    // �������� �������
    Close;
    SQL.Text := 'select cg_id,sex,agemin,agemax,laps from comp_groups where race_id='
      + IntToStr(sPanel3.Tag) + ';';
    Open;
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
    if MessageDlg('������� ����� "' + sListBox2.Items.Strings[sListBox2.ItemIndex]
        + '"?', mtConfirmation, [mbyes, mbno], 0) = mryes then with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // ����� RACE_ID ��� ��������
      with TIBQuery.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        SQL.Text := 'select race_id,name,laps,track_length,status from races where event_id='
          + IntToStr(sPanel2.Tag) + ';';
        Open;
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
    // ���� �������
    if sPanel3.Tag = 0 then SQL.Text := 'insert into races(race_id,event_id,name,laps,track_length) '
      + 'values((select max(race_id) from races) + 1,' + IntToStr(sPanel2.Tag) + ','''
      + sEdit2.Text + ''',' + sEdit4.Text + ',' + sEdit3.Text +  ');'
    // ���� ��������
    else SQL.Text := 'update races set name=''' + sEdit2.Text + ''',laps='
      + sEdit4.Text + ',track_length=' + sEdit3.Text + ' where race_id=' + IntToStr(sPanel3.Tag) + ';';
    ExecQuery;
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
    // ���� ������� � �����������
    EVENT_ID := sCheckListBox1.Tag;
  end;
  if tsEvent.Visible then begin
    // ���� ������� �� ������ ������������
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select event_id,event_date,name from events order by event_date;';
      Open;
      FetchAll;
      First;
      i := 0;
      while sListBox1.ItemIndex > i do begin
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
  sComboBox4.Tag := EVENT_ID;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ������ �����������
    SQL.Text := 'select event_id,event_date,name from events order by event_date;';
    Open;
    FetchAll;
    First;
    sComboBox3.Items.Clear;
    i := 0;
    while not(EOF) do begin
      sComboBox3.Items.Add(Fields[2].AsString);
      // ��������� �����������
      if Fields[0].AsInteger = EVENT_ID then sComboBox3.ItemIndex := i;
      inc(i);
      Next;
    end;
    // ������ �������
    Close;
    SQL.Text := 'select race_id,laps,track_length,name,status from races where event_id=' + IntToStr(EVENT_ID) + ';';
    Open;
    FetchAll;
    sComboBox4.Items.Clear;
    while not(EOF) do begin
      sComboBox4.Items.Add(Fields[3].AsString);
      Next;
    end;
  finally
    Free;
  end;

  tsStart.Show;
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
  // ������� ������� ������� �� ������ ������
  for i := 0 to sCheckListBox1.Items.Count - 1 do
    if sCheckListBox1.Checked[i] then bRacesSelected := true;
  // ��������� ���������� ������������ �����
  if (sEdit5.Text <> '') and (sComboBox2.Text <> '') and bRacesSelected then begin
    EVENT_ID := sCheckListBox1.Tag;
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // ��������� (��������) ���������. ������� (�����/�������) - sEdit5.Tag
      if sEdit5.Tag = 0 then begin
        // ���� ����� ��������
        if sCheckBox1.Checked then SEX := '�' else SEX := '�';
        // �������� ATHLET_ID
        with TIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text := 'select max(athlet_id) from athletes;';
          Open;
          FetchAll;
          ATHLET_ID := Fields[0].AsInteger + 1;
        finally
          Free;
        end;
        SQL.Text := 'insert into athletes(athlet_id,name,date_born,sex,team,city) values('
          + IntToStr(ATHLET_ID) + ',''' + sEdit5.Text + ''','''
          + FormatDateTime('dd/mm/yyyy', DateTimePicker2.DateTime) + ''',''' + SEX + ''','''
          + sEdit6.Text + ''',''' + sEdit7.Text + ''');';
        ExecQuery;
      end
      else begin
        // ���� �������� ������ ����� �����
        ATHLET_ID := sEdit5.Tag;
      end;
      // �������� ����� ��� �����������
      for i := 0 to sCheckListBox1.Count - 1 do if sCheckListBox1.Checked[i] then begin
        // ��������� RACE_ID
        with tIBQuery.Create(nil) do try
          Database := DBase;
          Transaction := DBTran;
          SQL.Text := 'select race_id,name,track_length,laps from races where event_id='
            + IntToStr(EVENT_ID) + ';';
          Open;
          FetchAll;
          First;
          while not(EOF) and (sCheckListBox1.Items.Strings[i] <> Fields[1].AsString) do begin
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
          FetchAll;
          REG_ID := Fields[0].AsInteger + 1;
        finally
          Free;
        end;
        SQL.Text := 'insert into registry(reg_id,platenumber,athlet_id,race_id) values('
          + IntToStr(REG_ID) + ',' + sComboBox2.Text + ','
          + IntToStr(ATHLET_ID) + ',' + IntToStr(RACE_ID) + ');';
        ExecQuery;
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
  // ��������� ATHLET_ID � sEdit5.Tag ��� ������������ ��������� ���������� ������ ���������
  sEdit5.Tag := ATHLET_ID;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select name,date_born,sex,team,city from athletes where athlet_id='
      + IntToStr(ATHLET_ID) + ' order by name;';
    Open;
    FetchAll;
    sEdit5.Text := Fields[0].AsString;
    sEdit6.Text := Fields[3].AsString;
    sEdit7.Text := Fields[4].AsString;
    DateTimePicker2.Date := Fields[1].AsDateTime;
    sCheckBox1.Checked := Fields[2].AsString = '�';
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
    FetchAll;
    while not(EOF) do begin
      // ����� ����� ��� ������������������
      ATHLET_ID := Fields[0].AsInteger;
      with TIBQuery.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        SQL.Text := 'select * from registry,races where (registry.race_id=races.race_id)'
          + 'and(athlet_id=' + IntToStr(ATHLET_ID) + ')and(races.event_id='
          + IntToStr(sCheckListBox1.Tag) + ');';
        Open;
        FetchAll;
        isRegistered := RecordCount > 0;
      finally
        Free;
      end;
      if not(isRegistered) then begin
        mItem := TMenuItem.Create(Self);
        mItem.Caption := Fields[1].AsString + ', '
          + FormatDateTime('dd/mm/yyyy', Fields[2].AsDateTime) + ' (' + Fields[5].AsString + ')';
        // ��������� athlet_id � mItem.Tag
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
  // ��������� �� ��������� ��������
  Buffer := TStringList.Create;
  for i := 0 to sCheckListBox2.Count - 1 do begin
    if sCheckListBox2.Checked[i] then Buffer.Add(RaceNumbers[i]);
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
      + ''' where race_id=' + IntToStr(sCheckListBox2.Tag) + ';';
    ExecQuery;
  finally
    Free;
  end;
  sCheckListBox2.Enabled := false;
  sLabelFX6.Caption := strREADY_TO_RACE;
end;

procedure TMainForm.sBitBtn21Click(Sender: TObject);
begin
  RepaintNumberButtons(Sender);
  tsRacePanel.Show;
  RefreshRacePanel;
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
    LAST_TN_ID := Fields[0].AsInteger;
  finally
    Free;
  end;
  RACE_ID := sCheckListBox2.Tag;
  TIME_START := Now();
  // ������� � ���� ����� "0" - ������� ������ ������
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'insert into timenotes(tn_id,race_id,platenumber,timenote) values('
      + IntToStr(LAST_TN_ID + 1) + ',' + IntToStr(RACE_ID) + ',0,'''
      + FormatDateTime(strTIMENOTE_FORMAT, TIME_START) + ''');';
    ExecQuery;
    sBitBtn22.Enabled := false;

    Timer.Enabled := true;
  finally
    Free;
  end;
end;

procedure TMainForm.sBitBtn23Click(Sender: TObject);
var
  i, RACE_ID : integer;
  strSEX, strAGEMIN, strAGEMAX: string;
  Item : TControl;
begin
{
  for i := sPanel5.ControlCount - 1 downto 0 do begin
    Item := sPanel5.Controls[i];
    TFreeButton(Item).Hide;
  end;
}
  if RusMessageDialog(strCOMPLETE_RACE, mtConfirmation, mbYesNo, ['��', '������']) = mryes
  then begin
    // �������� RACE_ID �� sPanel5.Tag
    RACE_ID := sPanel5.Tag;
    sBitBtn22.Enabled := true;
    Timer.Enabled := false;
    with tIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'update races set status=''' +
        strRACE_STATUS_FINISHED + ''' where race_id=' + IntToStr(RACE_ID) + ';';
      ExecQuery;
    finally
      Free;
    end;
    // ��������� RACE_ID � sComboBox6.Tag
    sComboBox6.Tag := RACE_ID;
    tsRaceResults.Show;
  end;
end;

procedure TMainForm.sBitBtn24Click(Sender: TObject);
begin
  RefreshRacePanel;
end;

procedure TMainForm.sBitBtn25Click(Sender: TObject);
begin
  // ������� ������ ���� �������
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ��� ����� � �������� ��������� � ��������������
    SQL.Text := 'update races set status='''' where status=''' + strRACE_STATUS_STARTED + ''';';
    ExecQuery;
    Close;
    // ��� ����������� ����� � ��������� � ��������������
    SQL.Text := 'update races set status='''' where status=''' + strRACE_STATUS_FINISHED + ''';';
    ExecQuery;
    Close;
    // �������� ��� ��������� �������
    SQL.Text := 'delete from timenotes;';
    ExecQuery;
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
  // ���� TN_ID �� sPanel7.Tag
  TN_ID := sPanel7.Tag;
  // ���� RACE_ID �� sPanel5.Tag
  RACE_ID := sPanel5.Tag;
  // ��������� ������������ ������
  bValidData := false;
  for i := 0 to RaceNumbers.Count - 1 do
    if RaceNumbers.Strings[i] = sComboBox5.Text then bValidData := true;
  strTIMENOTE := sEdit10.Text;
  if (strTIMENOTE[3] <> ':') or (strTIMENOTE[6] <> ':') or (strTIMENOTE[9] <> '.')
  then bValidData := false;
  // ���� ��, ����� � ����
  if bValidData then begin
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // ������� ����������/��������� - sEdit10.Enabled
      if sEdit10.Enabled then begin
        // ��������� � ����� ���������� ����� (����� ������ + ����� ������� )
        strAbsTime := FormatDateTime(strTIMENOTE_FORMAT, TIME_START + StrToTime(strTIMENOTE, fs));
        SQL.Text := 'insert into timenotes(tn_id,platenumber,race_id,timenote) values('
          + IntToStr(TN_ID) + ',' + sComboBox5.Text + ',' + IntToStr(RACE_ID) + ','''
          + strAbsTime + ''');'
      end
      else SQL.Text := 'update timenotes set platenumber=' + sComboBox5.Text
        + ' where TN_ID=' + IntToStr(TN_ID) + ';';
      ExecQuery;
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
    if RusMessageDialog(strDELETE_COMP_GROUP, mtConfirmation, mbYesNo, ['��', '������']) = mryes
    then begin
      with TIBSQL.Create(nil) do try
        Database := DBase;
        Transaction := DBTran;
        SQL.Text := 'delete from comp_groups where cg_id='
          + IntToStr(Integer(lvCompGroups.Items[lvCompGroups.ItemIndex].Data)) + ';';
        ExecQuery;
      finally
        Free;
      end;
      // refresh
      sBitBtn10Click(Self);
    end;
  end
  else ShowMessage(strCOMP_GROUP_NOT_SELECTED);
end;

procedure TMainForm.RefreshRacePanel;
var
  i, j, k, iPosCnt, iLapsOffset, iPanelWidth, ScrollBarWidth, RACE_ID, TN_ID, PLATENUMBER : integer;
  TIMENOTE, RACETIME : TDateTime;
  strTIME_START : string;
  lItem : TListItem;
begin
  ListView2.Clear;
  // ���� RACE_ID �� sPanel5.Tag
  RACE_ID := sPanel5.Tag;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ����� ������
    SQL.Text := 'select timenote from timenotes where (platenumber = 0) '
      + 'and (race_id = ' + IntToStr(RACE_ID) + ');';
    Open;
    if RecordCount > 0 then begin
      sBitBtn22.Enabled := false;
      strTIME_START := Fields[0].AsString;
      TIME_START := StrToTime(strTIME_START, fs);
      sBitBtn22.Caption := '����� ������: ' + Copy(strTIME_START, 1, 11);
      Timer.Enabled := true;
    end
    else begin
      sBitBtn22.Enabled := true;
      sBitBtn22.Caption := '�����';
    end;

    // ������� �������
    Close;
    SQL.Text := 'select timenotes.tn_id, athletes.name, timenotes.platenumber, '
      + 'timenotes.timenote from athletes, registry, timenotes where (athletes.athlet_id = '
      + 'registry.athlet_id) and (registry.platenumber = timenotes.platenumber) and '
      + '(registry.race_id = timenotes.race_id) and (timenotes.race_id = ' + IntToStr(RACE_ID)
      + ') order by timenotes.timenote;';
    Open;
    while not(EOF) do begin
      TN_ID := Fields[0].AsInteger;
      PLATENUMBER := Fields[2].AsInteger;
      TIMENOTE := StrToTime(Fields[3].AsString, fs);
      RACETIME := TIMENOTE - TIME_START;
      lItem := ListView2.Items.Add;
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
          SubItems.Add(IntToStr(Fields[0].AsInteger + 1));
        finally
          Free;
        end;
      end;
      Next;
    end;
    // ����������� �������
    with ListView2.Items do begin
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
          end;
          Item[i].SubItems.Add(intToStr(iPosCnt));
          if iLapsOffset > 0 then Item[i].SubItems.Add('-' + IntToStr(iLapsOffset));
        end;
      end;
    end; // with ListView2.Items
    // ������������ ������ �������, �������� ������ ������ �� ��������
    iPanelWidth := 0;
    for i := 0 to ListView2.Columns.Count - 2 do begin
      ListView2.Columns[i].Width := ColumnHeaderWidth;
      iPanelWidth := iPanelWidth + ListView2.Columns[i].Width;
    end;
    iPanelWidth := iPanelWidth + ListView2.Columns[ListView2.Columns.Count - 1].Width;
    if ScrollBarVisible(ListView2.Handle, WS_VSCROLL) then
      ScrollBarWidth := GetSystemMetrics(SM_CXVSCROLL)
    else ScrollBarWidth := 0;
    sPanel6.Width := iPanelWidth + ScrollBarWidth + ListView2.Columns.Count;
    // ��������� � �����
    SendMessage(ListView2.Handle, WM_VSCROLL, SB_BOTTOM, 0);
  finally
    Free;
  end;
end;

function ScrollBarVisible(Handle : HWnd; Style : Longint) : Boolean;
begin
  Result := (GetWindowLong(Handle, GWL_STYLE) and Style) <> 0;
end;

procedure TMainForm.OnPlateNumberClick(Sender: TObject);
var
  PLATENUMBER, RACE_ID, LAST_TN_ID : integer;
begin
  // ��������� ��������� �� �����
  if not(sBitBtn22.Enabled) then begin
    PLATENUMBER := StrToInt(TFreeButton(Sender).Caption);
    RACE_ID := TFreeButton(Sender).Tag;
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select max(tn_id) from timenotes;';
      Open;
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
    finally
      Free;
    end;
    RefreshRacePanel;
  end;
end;

procedure TMainForm.RepaintNumberButtons(Sender: TObject);
var
  i, iBtnNum, iBtnWidth, iBtnHeight, iRows, iColumns, iFldWidth, iFldHeight, maxBtnSize : integer;
  k : real;
  Item : TControl;
begin
  // �������� ������ ������
  for i := sPanel5.ControlCount - 1 downto 0 do begin
    Item := sPanel5.Controls[i];
    Item.Free;
  end;
  // ���������� ���������� ���������� ����
  iFldWidth := sPanel5.Width;
  iFldHeight := sPanel5.Height;
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
  // ���������
  for i := 0 to iBtnNum - 1 do begin
    with TFreeButton.Create(sPanel5) do begin
      Parent := sPanel5;
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
      Tag := sCheckListBox2.Tag;
      onClick := OnPlateNumberClick;
      Show;
    end;
  end;
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
  // ����� CG_ID
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select max(cg_id) from comp_groups;';
    Open;
    CG_ID := Fields[0].AsInteger + 1;
  finally
    Free;
  end;
  SEX := '-';
  if sCheckBox3.Checked then SEX := '�';
  if sCheckBox4.Checked then SEX := '�';
  if sCheckBox5.Checked then AGEMIN := StrToInt(sEdit9.Text) else AGEMIN := 0;
  if sCheckBox6.Checked then AGEMAX := StrToInt(sEdit11.Text) else AGEMAX := 0;
  if sEdit12.Text <> '' then LAPS := StrToInt(sEdit12.Text) else LAPS := 0;

  // ������� � ���� ����� �������� ������
  with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'insert into comp_groups(cg_id,race_id,sex,agemin,agemax,laps) values('
      + IntToStr(CG_ID) + ',' + IntToStr(RACE_ID) + ',''' + SEX + ''','
      + IntToStr(AGEMIN) + ',' + IntToStr(AGEMAX) + ',' + IntToStr(LAPS) + ');';
    ExecQuery;
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
    // ���� �������
    if sPanel2.Tag = 0 then SQL.Text :=
      'insert into events(event_id,event_date,name) values((select max(event_id) from events) + 1,'''
      + FormatDateTime('dd/mm/yyyy', DateTimePicker1.DateTime) + ''','''
      + sEdit1.Text + ''')'
    // ��������
    else
      SQL.Text := 'update events set name=''' + sEdit1.Text +  ''',event_date='''
        + FormatDateTime('dd/mm/yyyy', DateTimePicker1.DateTime) + ''' where event_id='
        + IntToStr(sPanel2.Tag) + ';';
    ExecQuery;
    sPanel2.Hide;
  finally
    Free;
  end;
  // �������� ������
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
  if MessageDlg('������� ����������� "' + sListBox1.Items.Strings[sListBox1.ItemIndex]
      + '"?', mtConfirmation, [mbyes, mbno], 0) = mryes then with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    with TIBQuery.Create(nil) do try
      // ����� EVENT_ID ��� ��������
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select event_id,event_date,name from events order by event_date;';
      Open;
      FetchAll;
      First;
      i := 0;
      while sListBox1.ItemIndex > i do begin
        Next;
        inc(i);
      end;
      EVENT_ID := Fields[0].AsInteger;
      // �������� ������� �����
      Close;
      SQL.Text := 'select status from races where event_id=' + IntToStr(EVENT_ID) + ';';
      Open;
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
      Close;
      SQL.Text := 'delete from events where event_id=' + IntToStr(EVENT_ID) + ';';
      ExecQuery;
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
    FetchAll;
    First;
    i := 0;
    while sListBox1.ItemIndex > i do begin
      Next;
      inc(i);
    end;
    sEdit1.Text := Fields[2].AsString;
    DateTimePicker1.DateTime := Fields[1].AsDateTime;
    // event_id ������ � sPanel2.Tag
    sPanel2.Tag := Fields[0].AsInteger;
    // �������� ������
    Close;
    SQL.Text := 'select race_id,name,track_length,laps from races where event_id='
      + IntToStr(sPanel2.Tag) + ';';
    Open;
    FetchAll;
    while not(EOF) do begin
      sListBox2.Items.Add(Fields[1].AsString + ' (' + IntToStr(Fields[3].AsInteger)
        + '��. �� ' + IntToStr(Fields[2].AsInteger) + '�)');
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
    FetchAll;
    First;
    i := 0;
    while sComboBox1.ItemIndex > i do begin
      Next;
      inc(i);
    end;
    EVENT_ID := Fields[0].AsInteger;
    // �������� EVENT_ID � sCheckListBox1.Tag
    sCheckListBox1.Tag := EVENT_ID;
    // ������ �������
    Close;
    SQL.Text := 'select race_id,name,track_length,laps from races where event_id='
      + IntToStr(EVENT_ID) + ';';
    Open;
    FetchAll;
    First;
    sCheckListBox1.Clear;
    while not(EOF) do begin
      sCheckListBox1.Items.Add(Fields[1].AsString);
      Next;
    end;
    // ������ ��� ��������������������, ������ ��������� �������
    sComboBox2.Items.Clear;
    for i := 1 to PLATENUMBERS_COUNT do sComboBox2.Items.Add(IntToStr(i));
    Close;
    SQL.Text := 'select distinct registry.platenumber, athletes.name, athletes.date_born, races.name, races.race_id '
      + 'from registry, athletes, races, events where (registry.race_id = races.race_id) and (races.event_id = events.event_id)'
      + 'and (athletes.athlet_id = registry.athlet_id) and (races.event_id = ' + IntToStr(EVENT_ID)
      + ') order by races.race_id, registry.platenumber;';
    Open;
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
    FetchAll;
    sComboBox4.Items.Clear;
    // �������� EVENT_ID � sComboBox4.Tag
    sComboBox4.Tag := EVENT_ID;
    while not(EOF) do begin
      sComboBox4.Items.Add(Fields[3].AsString);
      Next;
    end;
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
    // ���� race_id
    SQL.Text := 'select race_id,laps,track_length,name,status from races where event_id='
      + IntToStr(EVENT_ID) + ';';
    Open;
    FetchAll;
    while not(EOF) do begin
      if sComboBox4.Text = Fields[3].AsString then begin
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
  // �������� ������� �����
  if STATUS = strRACE_STATUS_STARTED then begin
    sLabelFX6.Caption := strREADY_TO_RACE;
    sCheckListBox2.Enabled := false;
    sBitBtn20.Enabled := false;
    sBitBtn21.Enabled := true;
    sBitBtn32.Enabled := false;
  end;
  if STATUS = strRACE_STATUS_FINISHED then begin
    sLabelFX6.Caption := strRACE_FINISHED;
    sCheckListBox2.Enabled := false;
    sBitBtn20.Enabled := false;
    sBitBtn21.Enabled := false;
    sBitBtn32.Enabled := true;
  end;
  if STATUS = '' then begin
    sLabelFX6.Caption := strPRERACE_CHECK_REQUIRED;
    sCheckListBox2.Enabled := true;
    sBitBtn20.Enabled := true;
    sBitBtn21.Enabled := false;
    sBitBtn32.Enabled := false;
  end;
  // ��������� race_id � sCheckListBox2.Tag � sPanel5.Tag
  sCheckListBox2.Tag := RACE_ID;
  sPanel5.Tag := RACE_ID;
  sComboBox6.Tag := RACE_ID;
end;

procedure TMainForm.sComboBox6Change(Sender: TObject);
var
  i, RACE_ID, iPlace, iLeaderLaps, iAthleteLaps, PLATENUMBER, iAGE, iAGEMIN, iAGEMAX, iLAPS : integer;
  strTIMENOTE, strTIMESTART, strTIMELEADER, strShift, strSEX : string;
  bToApplyFilter, bIsFiltered : boolean;
  dtShift : TDateTime;
  lItem : TListItem;
begin
  // ���� RACE_ID �� sComboBox6.Tag
  RACE_ID := sComboBox6.Tag;
  bToApplyFilter := sComboBox6.ItemIndex > 0;
// ���� ���� ��� �������� (TODO)
  lvResults.Clear;
  // ������� ��������� �����. ������ � ������������ ������ � �������� �� ��������
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // ����� ������
    SQL.Text := 'select timenote from timenotes where (platenumber = 0) '
      + 'and (race_id = ' + IntToStr(RACE_ID) + ');';
    Open;
    strTIMESTART := Fields[0].AsString;
    // ��������� ����������, ���� ���������
    if bToApplyFilter then begin
      Close;
      // ���������� �����-�� ������ ��� � � sComboBox6, ����������� �� ���� �� ItemIndex
      // � ������� ������ ����
      SQL.Text := 'select sex,agemin,agemax,laps from comp_groups where race_id='
        + IntToStr(RACE_ID) + ' order by sex,agemin;';
      Open;
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
    FetchAll;
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
          bIsFiltered := true;
          // ��������� ���������� ���� ����������
          if bToApplyFilter then begin
            // �������
            iAGE := YearsBetween(StrToDate('31.12.'
              + FormatDateTime('yyyy', Now),fs), Fields[1].AsDateTime);
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
                  strShift := FormatDateTime(strTIMENOTE_FORMAT, dtShift);
                  strTIMELEADER := strTIMENOTE;
                end
                else begin
                  // ���� �� ������ - ���������� �� ������
                  dtShift := StrToTime(strTIMENOTE, fs) - StrToTime(strTIMELEADER, fs);
                  strShift := '+' + FormatDateTime(strTIMENOTE_FORMAT, dtShift);
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
    end;
  finally
    Free;
  end;
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

procedure TMainForm.sPanel5Resize(Sender: TObject);
begin
  if (PageControl2.ActivePage = tsRacePanel) and (PageControl1.ActivePage = tsStart)
  then RepaintNumberButtons(Sender);
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  sTimerLabel.Caption := Copy(FormatDateTime(strTIMENOTE_FORMAT, Now() - TIME_START), 1, 11);
end;

procedure TMainForm.tsRaceResultsShow(Sender: TObject);
var
  RACE_ID : integer;
  strSEX,strAGEMIN, strAGEMAX : string;
begin
  RACE_ID := sComboBox6.Tag;
  with sComboBox6 do begin
    Clear;
    Items.Add(strABSOLUTE);
    with TIBQuery.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select sex,agemin,agemax from comp_groups where race_id='
        + IntToStr(RACE_ID) + ' order by sex,agemin;';
      Open;
      FetchAll;
      while not(EOF) do begin
        if Fields[0].AsString = '�' then strSEX := '�������';
        if Fields[0].AsString = '�' then strSEX := '�������';
        if Fields[0].AsString = '-' then strSEX := '���';
        if Fields[1].AsInteger = 0 then strAGEMIN := ''
        else strAGEMIN := ' �� ' + IntToStr(Fields[1].AsInteger);
        if Fields[2].AsInteger = 0 then strAGEMAX := ''
        else strAGEMAX := ' �� ' + IntToStr(Fields[2].AsInteger);
        Items.Add(strSEX + strAGEMIN + strAGEMAX);
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
    FetchAll;
    while not(EOF) do begin
      sComboBox1.Items.Add(Fields[2].AsString);
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TMainForm.tsEventShow(Sender: TObject);
begin
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    SQL.Text := 'select event_id,event_date,name from events order by event_date;';
    Open;
    FetchAll;
    sListBox1.Clear;
    while not(EOF) do begin
      sListBox1.Items.Add('[' + FormatDateTime('dd/mm/yyyy',Fields[1].AsDateTime) + '] '
        + Fields[2].AsString);
      Next;
    end;
  finally
    Free;
  end;
end;

end.
