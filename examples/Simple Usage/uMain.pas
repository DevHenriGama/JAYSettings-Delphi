unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JaySettings.CORE,
  Vcl.Buttons;

type
  TForm1 = class(TForm)
    btnSalvar: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnLer: TButton;
    CheckBox1: TCheckBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure btnLerClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnSalvarClick(Sender: TObject);
begin
  Settings(CheckBox1.Checked).SetSettings(Edit1.Text, Edit2.Text);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  Edit1.Text := '';
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  Edit2.Text := '';
end;

procedure TForm1.btnLerClick(Sender: TObject);
begin
  if not Settings.ContainsKey(Edit1.Text) then
  begin
    ShowMessage('Não possui essa configuração salva');
    Exit;
  end;

  Edit2.Text := Settings(CheckBox1.Checked).GetSettings(Edit1.Text);

end;

end.
