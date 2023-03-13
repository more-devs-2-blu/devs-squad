unit UEntity.Enderecos;

interface

uses
  System.JSON;

type
  TEndereco = class
  private
    FId: Integer;
    FCep: String;
    FBairro: String;
    FNumero: Integer;
    FLogradouro: String;
    FComplemento: String;
    FJSON: TJSONObject;

    function GetId: Integer;
    function GetCep: String;
    function GetBairro: String;
    function GetNumero: Integer;
    function GetLogradouro: String;
    function GetComplemento: String;
    function GetJSON: TJSONObject;

    procedure SetId(const Value: Integer);
    procedure SetCep(const Value: String);
    procedure SetBairro(const Value: String);
    procedure SetNumero(const Value: Integer);
    procedure SetLogradouro(const Value: String);
    procedure SetComplemento(const Value: String);

  public
    constructor Create; overload;
    constructor Create(const aId: Integer); overload;

    constructor Create(aNumero: Integer; aCep, aBairro, aLogradouro,
      aComplemento: String; aId: Integer = 0 )overload;

    destructor Destroy; override;

    property Id: Integer read GetId write SetId;
    property Cep: String read GetCep write SetCep;
    property Bairro: String read GetBairro write SetBairro;
    property Numero: Integer read GetNumero write SetNumero;
    property Logradouro: String read GetLogradouro write SetLogradouro;
    property Complemento: String read GetComplemento write SetComplemento;

    property JSON: TJSONObject read GetJSON;

  end;

implementation

uses
  system.SysUtils;

{ TEndereco }

constructor TEndereco.Create;
begin
  FJSON := TJSONObject.Create;
end;

constructor TEndereco.Create(const aId: Integer);
begin
  FId := aId;
  Self.Create;
end;

constructor TEndereco.Create(aNumero: Integer; aCep, aBairro, aLogradouro,
  aComplemento: String; aId: Integer = 0 );
begin
  FId          := aId;
  FNumero      := aNumero;
  FCep         := aCep;
  FBairro      := aBairro;
  FLogradouro  := aLogradouro;
  FComplemento := aComplemento;
  Self.Create;
end;

destructor TEndereco.Destroy;
begin
  FreeAndNil(FJSON);
  inherited;
end;

function TEndereco.GetBairro: String;
begin
  Result := FBairro;
end;

function TEndereco.GetCep: String;
begin
    Result := FCep;
end;

function TEndereco.GetComplemento: String;
begin
  Result := FComplemento;
end;

function TEndereco.GetId: Integer;
begin
  Result := FId;
end;

function TEndereco.GetJSON: TJSONObject;
begin
  if not (FId = 0) then
    FJSON.AddPair('id',           FId.ToString);

  FJSON.AddPair('numero',       FNumero.ToString);
  FJSON.AddPair('cep',          FCep);
  FJSON.AddPair('bairro',       FBairro);
  FJSON.AddPair('logradouro',   FLogradouro);
  FJSON.AddPair('complemento',  FComplemento);

  Result := FJSON;
end;

function TEndereco.GetLogradouro: String;
begin
  Result := FLogradouro;
end;

function TEndereco.GetNumero: Integer;
begin
  Result := FNumero;
end;

procedure TEndereco.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TEndereco.SetCep(const Value: String);
begin
  FCep := Value
end;

procedure TEndereco.SetComplemento(const Value: String);
begin
  FComplemento := Value
end;

procedure TEndereco.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TEndereco.SetLogradouro(const Value: String);
begin
  FLogradouro := Value
end;

procedure TEndereco.SetNumero(const Value: Integer);
begin
  FNumero := Value;
end;

end.
