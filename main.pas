unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, ComCtrls, ExtCtrls, sPanel,
  sButton, sListBox, sLabel, sEdit, IBDatabase, DB, IBSQL, IBQuery, sComboBox,
  sCheckListBox, sCheckBox, sScrollBar, Menus;

const
  PLATENUMBERS_COUNT = 50;

type
  TMainForm = class(TForm)
    sSkinManager: TsSkinManager;
    sPanel1: TsPanel;
    sBitBtn2: TsBitBtn;
    sBitBtn1: TsBitBtn;
    sBitBtn3: TsBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
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
    sScrollBar1: TsScrollBar;
    sLabel11: TsLabel;
    sEdit6: TsEdit;
    sEdit7: TsEdit;
    sLabel12: TsLabel;
    sBitBtn16: TsBitBtn;
    sEdit8: TsEdit;
    sBitBtn19: TsBitBtn;
    PopupMenu1: TPopupMenu;
    procedure sBitBtn3Click(Sender: TObject);
    procedure sBitBtn2Click(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure sBitBtn4Click(Sender: TObject);
    procedure sBitBtn7Click(Sender: TObject);
    procedure sBitBtn8Click(Sender: TObject);
    procedure sBitBtn5Click(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure sBitBtn9Click(Sender: TObject);
    procedure sBitBtn12Click(Sender: TObject);
    procedure sBitBtn13Click(Sender: TObject);
    procedure sListBox1Enter(Sender: TObject);
    procedure sBitBtn10Click(Sender: TObject);
    procedure sBitBtn11Click(Sender: TObject);
    procedure sBitBtn6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
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
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SelectAthlet(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormShow(Sender: TObject);
begin
  TabSheet2.Show;
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
    if bClear then ExecQuery else ShowMessage('Невозможно удалить уже начатый заезд.');
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

procedure TMainForm.sBitBtn15Click(Sender: TObject);
begin
  sEdit5.Tag := 0;
  sEdit5.Clear;
  sEdit6.Clear;
  sEdit6.Clear;
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
      // выбираем гонки для регистрации
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
  end
  else ShowMessage('Пропущены обязательные для заполнения поля');
end;

procedure TMainForm.SelectAthlet(Sender: TObject);
var
  ATHLET_ID : integer;
begin
  ATHLET_ID := (Sender as TMenuItem).Tag;
  // сохраняем ATHLET_ID в sEdit5.Tag для последующего избежания добавления нового учатсника
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
      mItem := TMenuItem.Create(Self);
      mItem.Caption := Fields[1].AsString + ', '
        + FormatDateTime('dd/mm/yyyy', Fields[2].AsDateTime) + ' (' + Fields[5].AsString + ')';
      // сохраняем athlet_id в mItem.Tag
      mItem.Tag := Fields[0].AsInteger;
      mItem.OnClick := SelectAthlet;
      PopupMenu1.Items.Add(mItem);
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
  TabSheet3.Show;
end;

procedure TMainForm.sBitBtn2Click(Sender: TObject);
begin
  sBitBtn1.Font.Style := [];
  sBitBtn2.Font.Style := [fsBold];
  sBitBtn3.Font.Style := [];
  TabSheet2.Show;
end;

procedure TMainForm.sBitBtn3Click(Sender: TObject);
var
  i : integer;
begin
  sBitBtn1.Font.Style := [];
  sBitBtn2.Font.Style := [];
  sBitBtn3.Font.Style := [fsBold];
  TabSheet1.Show;
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
  TabSheet2Show(self);
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
    else ShowMessage('Невозможно удалить мероприятие с проведёнными заездами');
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
    // список уже зарегистрировавшихся, выдача свободных номеров
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

procedure TMainForm.TabSheet1Show(Sender: TObject);
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

procedure TMainForm.TabSheet2Show(Sender: TObject);
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
