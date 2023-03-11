unit UEntity.Apoios;

interface

uses
  System.JSON,
  GBSwagger.Model.Attributes,
  UEntity.Usuarios,
  UEntity.Ocorrencias;

type
  TApoios = class
  private
    FId: Integer;
    FUsuario: TUsuario;
    FOcorrencia: TOcorrencia;
    FJSON: TJSONObject;

    function GetId: Integer;
    function GetUsuario: TUsuario;
    function GetOcorrencia: TOcorrencia;
    function GetJSON: TJSONObject;

    procedure SetId(const Value: Integer);
    procedure SetOcorrencia(const Value: TOcorrencia);
    procedure SetUsuario(const Value: TUsuario);
  public
    constructor Create; overload;
    constructor Create(const aId: Integer); overload;

    constructor Create(aId: Integer; aUsuario: TUsuario; aOcorrencia: TOcorrencia); overload;

    destructor Destroy; override;

    [SwagProp('Apoio Id', True)]
    property Id: Integer read GetId write SetId;

    [SwagProp('Apoio Usuário', True)]
    property Usuario: TUsuario read GetUsuario write SetUsuario;

    [SwagProp('Apoio Ocorrência', True)]
    property Ocorrencia: TOcorrencia read GetOcorrencia write SetOcorrencia;

    property JSON: TJSONObject read GetJSON;

  end;

implementation

uses
  system.SysUtils;

{ TApoios }

constructor TApoios.Create;
begin
  FJSON := TJSONObject.Create;
end;

constructor TApoios.Create(const aId: Integer);
begin
  FId := aId;
  Self.Create;
end;

constructor TApoios.Create(aId: Integer; aUsuario: TUsuario; aOcorrencia: TOcorrencia);
begin
  FId          := aId;
  FUsuario     := aUsuario;
  FOcorrencia  := aOcorrencia;
  Self.Create;
end;

destructor TApoios.Destroy;
begin
  FreeAndNil(FOcorrencia);
  FreeAndNil(FUsuario);
  FreeAndNil(FJSON);
  inherited;
end;

function TApoios.GetId: Integer;
begin
  Result := FId;
end;

function TApoios.GetJSON: TJSONObject;
begin
  FJSON.AddPair('id',         FId.ToString);
  FJSON.AddPair('usuario',    FUsuario.Id.ToString);
  FJSON.AddPair('ocorrencia', FOcorrencia.Id.ToString);

  Result := FJSON;
end;

function TApoios.GetOcorrencia: TOcorrencia;
begin
  Result := FOcorrencia;
end;

function TApoios.GetUsuario: TUsuario;
begin
  Result := FUsuario;
end;

procedure TApoios.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TApoios.SetOcorrencia(const Value: TOcorrencia);
begin
  FOcorrencia := Value;
end;

procedure TApoios.SetUsuario(const Value: TUsuario);
begin
  FUsuario := Value;
end;

end.
