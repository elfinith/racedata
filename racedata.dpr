program racedata;

uses
  Forms,
  main in 'main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Хронометраж';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
