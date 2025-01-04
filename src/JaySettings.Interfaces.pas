unit JaySettings.Interfaces;

interface

type
  IJAYSettings = interface
    ['{A4E1CD42-0754-4E9A-93D3-CEB65078A480}']
    procedure SetSettings(AChave, Valor: string);
    function GetSettings(AChave: string): string;
    function HasSettingsFile: Boolean;
    function ContainsKey(AKey: String): Boolean;
  end;

implementation

end.
