program JAYSettingsExample;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  JaySettings.CORE in '..\..\src\JaySettings.CORE.pas',
  JaySettings.Interfaces in '..\..\src\JaySettings.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
