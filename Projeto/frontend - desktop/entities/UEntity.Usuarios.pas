unit UEntity.Usuarios;

interface

uses
  System.JSON;

type
  TUsuario = class

  private
    FId: Integer;
    FTipoUsuario: String;
    FNome: String;
    FTelefone: String;
    FBairro: String;
    FEmail: String;
    FCpf: String;
    FSenha: String;
    FJSON: TJSONObject;

    function GetId: Integer;
    function GetTipoUsuario: String;
    function GetNome: String;
    function GetTelefone: String;
    function GetBairro: String;
    function GetEmail: String;
    function GetCpf: String;
    function GetSenha: String;
    function GetJSON: TJSONObject;

    procedure SetId(const Value: Integer);
    procedure SetTipoUsuario(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetTelefone(const Value: String);
    procedure SetBairro(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetCpf(const Value: String);
    procedure SetSenha(const Value: String);

  public
    constructor Create; overload;
    constructor Create(const aId: Integer); overload;
    constructor Create(const aNome, aCpf, aSenha: String); overload;
    constructor Create(const aId: Integer; const aTipoUsuario, aNome,
      aTelefone: String; const aBairro: String; const aEmail: String;
      const aCpf: String; const aSenha: String); overload;

    destructor Destroy; override;

    property Id: Integer read GetId write SetId;
    property TipoUsuario: String read GetTipoUsuario write SetTipoUsuario;
    property Nome: String read GetNome write SetNome;
    property Telefone: String read GetTelefone write SetTelefone;
    property Bairro: String read GetBairro write SetBairro;
    property Email: String read GetEmail write SetEmail;
    property Cpf: String read GetCpf write SetCpf;
    property Senha: String read GetSenha write SetSenha;

    property JSON: TJSONObject read GetJSON;
  end;

implementation

uses
  SysUtils;

{ TUsuario }

constructor TUsuario.Create;
begin
  FJSON := TJSONObject.Create;
end;

constructor TUsuario.Create(const aId: Integer);
begin
  FId := aId;
  Self.Create;
end;

constructor TUsuario.Create(const aNome, aCpf, aSenha: String);
begin
  FNome  := aNome;
  FCpf   := aCpf;
  FSenha := aSenha;

  Self.Create;
end;

constructor TUsuario.Create(const aId: Integer;
  const aTipoUsuario, aNome, aTelefone, aBairro, aEmail, aCpf, aSenha: String);
begin
  FId          := aId;
  FTipoUsuario := aTipoUsuario;
  FNome        := aNome;
  FTelefone    := aTelefone;
  FBairro      := aBairro;
  FEmail       := aEmail;
  FCpf         := aCpf;
  FSenha       := aSenha;
end;

destructor TUsuario.Destroy;
begin
  FreeAndNil(FJSON);
  inherited;
end;

function TUsuario.GetBairro: String;
begin
  Result := FBairro;
end;

function TUsuario.GetCpf: String;
begin
  Result := FCpf;
end;

function TUsuario.GetEmail: String;
begin
  Result := FEmail;
end;

function TUsuario.GetId: Integer;
begin
  Result := FId;
end;

function TUsuario.GetJSON: TJSONObject;
begin
  FJSON.AddPair('id',          FId.ToString);
  FJSON.AddPair('tipousuario', FTipoUsuario);
  FJSON.AddPair('nome',        FNome);
  FJSON.AddPair('telefone',    FTelefone);
  FJSON.AddPair('bairro',      FBairro);
  FJSON.AddPair('email',       FEmail);
  FJSON.AddPair('cpf',         FCpf);
  FJSON.AddPair('senha',       FSenha);

  Result := FJSON;
end;

function TUsuario.GetNome: String;
begin
  Result := FNome;
end;

function TUsuario.GetSenha: String;
begin
  Result := FSenha;
end;

function TUsuario.GetTelefone: String;
begin
  Result := FTelefone;
end;

function TUsuario.GetTipoUsuario: String;
begin
  Result := FTipoUsuario;
end;

procedure TUsuario.SetBairro(const Value: String);
begin
  FBairro := value;
end;

procedure TUsuario.SetCpf(const Value: String);
begin
  FCpf := value;
end;

procedure TUsuario.SetEmail(const Value: String);
begin
  FEmail := value;
end;

procedure TUsuario.SetId(const Value: Integer);
begin
  FId := value;
end;

procedure TUsuario.SetNome(const Value: String);
begin
  FNome := value;
end;

procedure TUsuario.SetSenha(const Value: String);
begin
  FSenha := value;
end;

procedure TUsuario.SetTelefone(const Value: String);
begin
  FTelefone := value;
end;

procedure TUsuario.SetTipoUsuario(const Value: String);
begin
  FTipoUsuario := value;
end;

end.
