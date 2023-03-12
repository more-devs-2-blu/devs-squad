unit UEntity.Logins;

interface

type
  TLogin = class
  private
    FCPF:   String;
    FSenha: String;
    FToken: String;

    function GetCPF:   String;
    function GetSenha: String;
    function GetToken: String;

    procedure SetCPF  (const Value: String);
    procedure SetSenha(const Value: String);
    procedure SetToken(const Value: String);

  public
    constructor Create(const aCPF, aSenha: String);

    property CPF:   String read GetCPF   write SetCPF;
    property Senha: String read GetSenha write SetSenha;
    property Token: String read GetSenha write SetToken;

  end;

implementation

{ TLogin }

constructor TLogin.Create(const aCPF, aSenha: String);
begin
  FCPF   := aCPF;
  FSenha := aSenha;
end;

function TLogin.GetCPF: String;
begin
  Result := FCPF;
end;

function TLogin.GetSenha: String;
begin
  Result := FSenha;
end;

function TLogin.GetToken: String;
begin
  Result := FToken;
end;

procedure TLogin.SetCPF(const Value: String);
begin
  FCPF := Value;
end;

procedure TLogin.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TLogin.SetToken(const Value: String);
begin
  FToken := Value;
end;

end.
