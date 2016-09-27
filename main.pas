unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, Buttons, sBitBtn, ComCtrls, ExtCtrls, sPanel,
  sButton, sListBox, sLabel, sEdit, IBDatabase, DB, IBSQL, IBQuery;

type
  TForm1 = class(TForm)
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.sBitBtn10Click(Sender: TObject);
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

procedure TForm1.sBitBtn11Click(Sender: TObject);
var
  i, RACE_ID : integer;
begin
  if MessageDlg('Удалить заезд "' + sListBox2.Items.Strings[sListBox2.ItemIndex]
      + '"?', mtConfirmation, [mbyes, mbno], 0) = mryes then with TIBSQL.Create(nil) do try
    Database := DBase;
    Transaction := DBTran;
    // поиск RACE_ID для удаления
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
      RACE_ID := Fields[0].AsInteger;
    finally
      Free;
    end;
    SQL.Text := 'delete from races where race_id=' + IntToStr(RACE_ID) + ';';
    ExecQuery;
  finally
    Free;
  end;
  // refresh
  sBitBtn7Click(Self);
end;

procedure TForm1.sBitBtn12Click(Sender: TObject);
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

procedure TForm1.sBitBtn13Click(Sender: TObject);
begin
  sPanel3.Hide;
  sBitBtn5.Enabled := true;
  sBitBtn8.Enabled := true;
  sBitBtn9.Enabled := true;
  sBitBtn10.Enabled := true;
  sBitBtn11.Enabled := true;
end;

procedure TForm1.sBitBtn1Click(Sender: TObject);
begin
  sBitBtn1.Font.Style := [fsBold];
  sBitBtn2.Font.Style := [];
  sBitBtn3.Font.Style := [];
  TabSheet3.Show;
end;

procedure TForm1.sBitBtn2Click(Sender: TObject);
begin
  sBitBtn1.Font.Style := [];
  sBitBtn2.Font.Style := [fsBold];
  sBitBtn3.Font.Style := [];
  TabSheet2.Show;
end;

procedure TForm1.sBitBtn3Click(Sender: TObject);
begin
  sBitBtn1.Font.Style := [];
  sBitBtn2.Font.Style := [];
  sBitBtn3.Font.Style := [fsBold];
  TabSheet1.Show;
end;

procedure TForm1.sBitBtn4Click(Sender: TObject);
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

procedure TForm1.sBitBtn5Click(Sender: TObject);
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

procedure TForm1.sBitBtn7Click(Sender: TObject);
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

procedure TForm1.sBitBtn8Click(Sender: TObject);
begin
  sPanel2.Hide;
  sListBox1.Enabled := true;
  sBitBtn4.Enabled := true;
  sBitBtn6.Enabled := true;
  sBitBtn7.Enabled := true;
  sListBox1.SetFocus;
end;

procedure TForm1.sBitBtn9Click(Sender: TObject);
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

procedure TForm1.sListBox1Enter(Sender: TObject);
begin
  sBitBtn3.Enabled := true;
  sBitBtn14.Enabled := true;
end;

procedure TForm1.TabSheet2Show(Sender: TObject);
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
