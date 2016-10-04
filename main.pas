unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, ComCtrls, ExtCtrls, sPanel,
  sButton, sListBox, sLabel, sEdit, IBDatabase, DB, IBSQL, IBQuery, sComboBox,
  sCheckListBox, sCheckBox, sScrollBar, Menus, sSkinProvider, ImgList;

const
  PLATENUMBERS_COUNT = 50;
  strRACE_STATUS_STARTED = '¬ процессе';
  strRACE_STATUS_FINISHED = '«авершено';


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
    tsStartRace: TTabSheet;
    sCheckListBox2: TsCheckListBox;
    sLabel14: TsLabel;
    sBitBtn20: TsBitBtn;
    sBitBtn21: TsBitBtn;
    sLabelFX6: TsLabelFX;
    sLabel15: TsLabel;
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
  private
    { Private declarations }
  public
    { Public declarations }
    RaceNumbers : TStringList;
    procedure SelectAthlet(Sender: TObject);
  end;

var
  MainForm: TMainForm;

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

procedure TMainForm.FormCreate(Sender: TObject);
begin
  DBase.DatabaseName := ExtractFilePath(Application.ExeName) + 'DBASE.FDB';
  try
    DBase.Connected := True;
    DBTran.Active := True;
  except
    ShowMessage('ќшибка при соединении с Ѕƒ');
  end;
  RaceNumbers := TStringList.Create;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  tsEvent.Show;
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
  if RusMessageDialog('ќтменить регистрацию ' + strAthletName + ' на ' + strRaceName + '?',
    mtConfirmation, mbYesNo, ['ќ ', 'ќтмена']) = mryes
  then begin
    with TIBQuery.Create(nil) do try
      // извлекаем RACE_ID
      Database := DBase;
      Transaction := DBTran;
      SQL.Text := 'select race_id from races where (event_id=' + IntToStr(EVENT_ID)
        + ') and (name=''' + strRaceName + ''');';
      Open;
      FetchAll;
      RACE_ID := Fields[0].AsInteger;
      // извлекаем ATHLET_ID
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

procedure TMainForm.sBitBtn10Click(Sender: TObject);
var
  i : integer;
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
    // race_id храним в sPanel3.Tag
    sPanel3.Tag := Fields[0].AsInteger;
    sEdit2.Text := Fields[1].AsString;
    sEdit3.Text := Fields[3].AsString;
    sEdit4.Text := Fields[2].AsString;
  finally
    Free;
  end;
  sBitBtn9.Enabled := false;
  sBitBtn11.Enabled := false;
  sBitBtn5.Enabled := false;
  sBitBtn8.Enabled := false;
  sPanel3.Show;
end;

procedure TMainForm.sBitBtn11Click(Sender: TObject);
var
  i, RACE_ID : integer;
  bClear : boolean;
begin
  if MessageDlg('”далить заезд "' + sListBox2.Items.Strings[sListBox2.ItemIndex]
      + '"?', mtConfirmation, [mbyes, mbno], 0) = mryes then with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // поиск RACE_ID дл€ удалени€
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
    if bClear then ExecQuery else ShowMessage('Ќевозможно удалить уже начатый заезд.');
  finally
    Free;
  end;
  // refresh
  sBitBtn7Click(Self);
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
    sPanel3.Hide;
  finally
    Free;
  end;
  sBitBtn5.Enabled := true;
  sBitBtn8.Enabled := true;
  sBitBtn9.Enabled := true;
  sBitBtn10.Enabled := true;
  sBitBtn11.Enabled := true;
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
end;

procedure TMainForm.sBitBtn14Click(Sender: TObject);
var
  i, EVENT_ID : integer;

begin
  if tsRegistration.Visible then begin
    // ≈сли прееход с регистрации
    EVENT_ID := sCheckListBox1.Tag;
  end;
  if tsEvent.Visible then begin
    // ≈сли переход со списка соревнований
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
      // event_id храним в sPanel2.Tag
      EVENT_ID := Fields[0].AsInteger;
    finally
      Free;
    end;
  end;
  // сохран€ем event_id в sComboBox4.Tag
  sComboBox4.Tag := EVENT_ID;
  with TIBQuery.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // список меропри€тий
    SQL.Text := 'select event_id,event_date,name from events order by event_date;';
    Open;
    FetchAll;
    First;
    sComboBox3.Items.Clear;
    i := 0;
    while not(EOF) do begin
      sComboBox3.Items.Add(Fields[2].AsString);
      // выбранное меропри€тие
      if Fields[0].AsInteger = EVENT_ID then sComboBox3.ItemIndex := i;
      inc(i);
      Next;
    end;
    // список заездов
    Close;
    SQL.Text := 'select race_id,laps,track_length,name,status from races where event_id=' + IntToStr(EVENT_ID) + ';';
    Open;
    FetchAll;
    sComboBox4.Items.Clear;
    while not(EOF) do begin
      sComboBox4.Items.Add(Fields[3].AsString);
      Next;
    end;

//    sComboBox3.Text := Fields[0].AsString;

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

procedure TMainForm.sBitBtn18Click(Sender: TObject);
var
  i, EVENT_ID, ATHLET_ID, RACE_ID, REG_ID : integer;
  SEX : string;
begin
  if (sEdit5.Text <> '') and (sComboBox2.Text <> '') then begin
    EVENT_ID := sCheckListBox1.Tag;
    with TIBSQL.Create(nil) do try
      Database := DBase;
      Transaction := DBTran;
      // добавл€ем (выбираем) участника. признак (новый/неновый) - sEdit5.Tag
      if sEdit5.Tag = 0 then begin
        // если новый участник
        if sCheckBox1.Checked then SEX := 'ћ' else SEX := '∆';
        // получаем ATHLET_ID
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
        // если участник выбран через поиск
        ATHLET_ID := sEdit5.Tag;
      end;
      // выбираем гонки дл€ регистрации
      for i := 0 to sCheckListBox1.Count - 1 do if sCheckListBox1.Checked[i] then begin
        // извлекаем RACE_ID
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
        // регистрируем на гонку
        Close;
        // получаем REG_ID
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
  else ShowMessage('ѕропущены об€зательные дл€ заполнени€ пол€');
end;

procedure TMainForm.SelectAthlet(Sender: TObject);
var
  ATHLET_ID : integer;
begin
  ATHLET_ID := (Sender as TMenuItem).Tag;
  // сохран€ем ATHLET_ID в sEdit5.Tag дл€ последующего избежани€ добавлени€ нового участника
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
    sCheckBox1.Checked := Fields[2].AsString = 'ћ';
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
      + sEdit8.Text + '%'';';
    Open;
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
        FetchAll;
        isRegistered := RecordCount > 0;
      finally
        Free;
      end;
      if not(isRegistered) then begin
        mItem := TMenuItem.Create(Self);
        mItem.Caption := Fields[1].AsString + ', '
          + FormatDateTime('dd/mm/yyyy', Fields[2].AsDateTime) + ' (' + Fields[5].AsString + ')';
        // сохран€ем athlet_id в mItem.Tag
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
  tsStart.Show;
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
    // берЄм race_id из sCheckListBox2.Tag
    SQL.Text := 'update races set status=''' + strRACE_STATUS_STARTED
      + ''' where race_id=' + IntToStr(sCheckListBox2.Tag) + ';';
    ExecQuery;
  finally
    Free;
  end;
  sCheckListBox2.Enabled := false;
  sLabelFX6.Caption := '√отовы к старту заезда';
end;

procedure TMainForm.sBitBtn21Click(Sender: TObject);
begin
  tsStartRace.Show;
  sLabel15.Caption := RaceNumbers.CommaText;
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
      + FormatDateTime('dd/mm/yyyy', DateTimePicker1.DateTime) + ''','''
      + sEdit1.Text + ''')'
    // изменить
    else
      SQL.Text := 'update events set name=''' + sEdit1.Text +  ''',event_date='''
        + FormatDateTime('dd/mm/yyyy', DateTimePicker1.DateTime) + ''' where event_id='
        + IntToStr(sPanel2.Tag) + ';';
    ExecQuery;
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
  if MessageDlg('”далить меропри€тие "' + sListBox1.Items.Strings[sListBox1.ItemIndex]
      + '"?', mtConfirmation, [mbyes, mbno], 0) = mryes then with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    with TIBQuery.Create(nil) do try
      // поиск EVENT_ID дл€ удалени€
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
      // проверка статуса гонок
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
    else ShowMessage('Ќевозможно удалить меропри€тие с проведЄнными заездами');
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
    // event_id храним в sPanel2.Tag
    sPanel2.Tag := Fields[0].AsInteger;
    // выбираем заезды
    Close;
    SQL.Text := 'select race_id,name,track_length,laps from races where event_id='
      + IntToStr(sPanel2.Tag) + ';';
    Open;
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
    // сохраним EVENT_ID в sCheckListBox1.Tag
    sCheckListBox1.Tag := EVENT_ID;
    // список заездов
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
    // список уже зарегистрировавшихс€, выдача свободных номеров
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
    // схран€ем EVENT_ID в sComboBox4.Tag
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
    // ищем race_id
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
    // загружаем участников
    // параллельно заполн€ем массив номеров дл€ предстартовой проверки
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
  // проверка статуса гонки
  if STATUS = strRACE_STATUS_STARTED then begin
    sLabelFX6.Caption := '√отовы к старту';
    sCheckListBox2.Enabled := false;
    sBitBtn20.Enabled := false;
    sBitBtn21.Enabled := true;
  end;
  if STATUS = strRACE_STATUS_FINISHED then begin
    sLabelFX6.Caption := '√онка закончена';
    sCheckListBox2.Enabled := false;
    sBitBtn20.Enabled := false;
    sBitBtn21.Enabled := false;
  end;
  if STATUS = '' then begin
    sLabelFX6.Caption := '“ребуетс€ предстартова€ проверка';
    sCheckListBox2.Enabled := true;
    sBitBtn20.Enabled := true;
    sBitBtn21.Enabled := false;
  end;
  // сохран€ем race_id в sCheckListBox2.Tag
  sCheckListBox2.Tag := RACE_ID;
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
