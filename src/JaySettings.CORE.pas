unit JaySettings.CORE;

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

  const
    FileName = 'settings.json';

  const
    EncryptionKey = 'MinhaChaveSegura'; // Deve ser armazenada com seguran�a

    function Encrypt(const Value: string): string;
    function Decrypt(const Value: string): string;
    procedure LoadFileSettings;
    procedure SaveSettings;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IJAYSettings; overload;
    property UseEncrypt: Boolean read FUseEncrypt write FUseEncrypt;
    procedure SetConfiguracao(AChave, Valor: string);
    function GetConfiguracao(AChave: string): string;
    function HasSettingsFile: Boolean;
    function ContainsKey(AKey: String): Boolean;

  end;

function Settings: IJAYSettings;

implementation

uses
  System.Classes;

{ TMACConfig }

function Settings: IJAYSettings;
begin
  Result := TJAYSettings.Create;
end;

function TJAYSettings.ContainsKey(AKey: String): Boolean;
begin
  Result := False;

  if HasSettingsFile then
    Result := FJSON.GetValue(AKey) <> NIL;

end;

constructor TJAYSettings.Create;
begin
  FFilePath := TPath.Combine(ExtractFilePath(ParamStr(0)), FileName);
  FUseEncrypt := False;
  FJSON := TJSONObject.Create;
  LoadFileSettings;
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

function TJAYSettings.Decrypt(const Value: string): string;
begin
  if FUseEncrypt then
    Result := TNetEncoding.Base64.Decode(Value)
  else
    Result := Value;

end;

function TJAYSettings.GetConfiguracao(AChave: string): string;
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

procedure TJAYSettings.SetConfiguracao(AChave, Valor: string);
var
  FValue: string;
begin
  if FJSON.TryGetValue<string>(AChave, FValue) then
    FJSON.RemovePair(AChave);

  FJSON.AddPair(AChave, Encrypt(Valor));
end;

procedure TJAYSettings.LoadFileSettings;
var
  FileContent: string;
begin
  if not TFile.Exists(FFilePath) then
  begin
    FJSON.AddPair('DBMigrations', '1.0');
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

class function TJAYSettings.New: IJAYSettings;
begin
  Result := Self.Create;
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

end.
