﻿unit JaySettings.CORE;

interface

uses
  System.SysUtils, System.JSON, System.IOUtils, System.NetEncoding,
  JaySettings.Interfaces;

type
  TJAYSettings = class(TInterfacedObject, IJAYSettings)
  private
    FFilePath: string;
    FJSON: TJSONObject;
    FUseEncrypt: Boolean;
    FFileName: String;
    function Encrypt(const Value: string): string;
    function Decrypt(const Value: string): string;
    procedure LoadFileSettings;
    procedure SaveSettings;
    procedure Start;
  public
    constructor Create; overload;
    constructor Create(AEncrypt: Boolean = False); overload;
    constructor Create(AFileName: string = 'Settings.json'); overload;
    constructor Create(AFileName: string = 'Settings.json';
      AEncrypt: Boolean = False); overload;
    destructor Destroy; override;
    class function New: IJAYSettings; overload;
    class function New(AEncrypt: Boolean = False): IJAYSettings; overload;
    class function New(AFileName: string = 'Settings.json')
      : IJAYSettings; overload;
    class function New(AFileName: string = 'Settings.json';
      AEncrypt: Boolean = False): IJAYSettings; overload;
    property UseEncrypt: Boolean read FUseEncrypt write FUseEncrypt;
    property FileName: String read FFileName write FFileName;
    procedure SetSettings(AChave, Valor: string);
    function GetSettings(AChave: string): string;
    function HasSettingsFile: Boolean;
    function ContainsKey(AKey: String): Boolean;

  end;

function Settings: IJAYSettings; overload;
function Settings(AEncrypt: Boolean): IJAYSettings; overload;
function Settings(AFileName: string): IJAYSettings; overload;
function Settings(AFileName: string; AEncrypt: Boolean): IJAYSettings; overload;

implementation

uses
  System.Classes;

function Settings: IJAYSettings;
begin
  Result := TJAYSettings.Create('Settings.json', False);
end;

function Settings(AEncrypt: Boolean): IJAYSettings;
begin
  Result := TJAYSettings.Create('Settings.json', AEncrypt);
end;

function Settings(AFileName: string): IJAYSettings;
begin
  Result := TJAYSettings.Create(AFileName, False);
end;

function Settings(AFileName: string; AEncrypt: Boolean): IJAYSettings;
begin
  Result := TJAYSettings.Create(AFileName, AEncrypt);
end;

function TJAYSettings.ContainsKey(AKey: String): Boolean;
begin
  Result := False;

  if HasSettingsFile then
    Result := FJSON.GetValue(AKey) <> NIL;

end;

constructor TJAYSettings.Create;
begin
  FUseEncrypt := False;
  FFileName := 'Settings.json';
  Start;
end;

destructor TJAYSettings.Destroy;
begin
  SaveSettings;
  FJSON.Free;
  inherited;
end;

function TJAYSettings.Encrypt(const Value: string): string;
begin
  if FUseEncrypt then
    Result := TNetEncoding.Base64.Encode(Value)
  else
    Result := Value;

end;

constructor TJAYSettings.Create(AFileName: string);
begin
  FFileName := AFileName;
  Start;
end;

function TJAYSettings.Decrypt(const Value: string): string;
begin
  if FUseEncrypt then
    Result := TNetEncoding.Base64.Decode(Value)
  else
    Result := Value;

end;

function TJAYSettings.GetSettings(AChave: string): string;
var
  Value: TJSONValue;
begin
  Value := FJSON.GetValue(AChave);
  if Assigned(Value) then
    Result := Decrypt(Value.Value)
  else
    Result := '';
end;

function TJAYSettings.HasSettingsFile: Boolean;
begin
  Result := FileExists(FFilePath);
end;

procedure TJAYSettings.SetSettings(AChave, Valor: string);
var
  FValue: string;
begin
  if FJSON.TryGetValue<string>(AChave, FValue) then
    FJSON.RemovePair(AChave);

  FJSON.AddPair(AChave, Encrypt(Valor));
end;

procedure TJAYSettings.Start;
begin
  FFilePath := TPath.Combine(ExtractFilePath(ParamStr(0)), FileName);
  FJSON := TJSONObject.Create;
  LoadFileSettings;
end;

procedure TJAYSettings.LoadFileSettings;
var
  FileContent: string;
begin
  if not TFile.Exists(FFilePath) then
  begin
    FJSON.AddPair('JAYSettings', '1.0');
    SaveSettings;
    Exit;
  end;

  try
    FileContent := TFile.ReadAllText(FFilePath);

    FJSON.Free;
    FJSON := TJSONObject.ParseJSONValue(FileContent) as TJSONObject;
    if not Assigned(FJSON) then
      raise Exception.Create('Arquivo de configuração inválido.');
  except
    on E: Exception do
    begin
      FJSON := TJSONObject.Create;
      raise Exception.CreateFmt('Erro ao carregar configuração: %s',
        [E.Message]);
    end;
  end;
end;

class function TJAYSettings.New(AFileName: string; AEncrypt: Boolean)
  : IJAYSettings;
begin
  Result := Self.Create(AFileName, AEncrypt);
end;

class function TJAYSettings.New(AEncrypt: Boolean): IJAYSettings;
begin
  Result := Self.Create(AEncrypt);
end;

class function TJAYSettings.New(AFileName: string): IJAYSettings;
begin
  Result := Self.Create(AFileName, False);
end;

class function TJAYSettings.New: IJAYSettings;
begin
  Result := Self.Create('Settings.json', False);
end;

procedure TJAYSettings.SaveSettings;
var
  JSONString: string;
begin
  try
    JSONString := FJSON.ToJSON;

    TFile.WriteAllText(FFilePath, JSONString);
  except
    on E: Exception do
      raise Exception.CreateFmt('Erro ao salvar configura��es: %s',
        [E.Message]);
  end;
end;

constructor TJAYSettings.Create(AFileName: string; AEncrypt: Boolean);
begin
  FileName := AFileName;
  FUseEncrypt := AEncrypt;
  Start;
end;

constructor TJAYSettings.Create(AEncrypt: Boolean);
begin
  FUseEncrypt := AEncrypt;
  Start;
end;

end.
