unit UEntity.Ocorrencias;

interface

uses
  UEntity.Usuarios,
  UEntity.Enderecos,
  System.JSON;

type
  TOcorrencia = class
  private
    FId: Integer;
    FDataInicial: TDateTime;
    FUrgencia: Byte;
    FDescricao: String;
    FQntApoio: Integer;
    FDataFinal: TDateTime;
    FDataAlteracao: TDateTime;
    FUsuario: TUsuario;
    FEndereco: TEndereco;
    FTipoProblema: String;
    FStatus: String;
    FJSON: TJSONObject;

    function GetId: Integer;
    function GetDataInicial: TDateTime;
    function GetUrgencia: Byte;
    function GetDescricao: String;
    function GetQntApoio: Integer;
    function GetDataFinal: TDateTime;
    function GetDataAlteracao: TDateTime;
    function GetUsuario: TUsuario;
    function GetEndereco: TEndereco;
    function GetTipoProblema: String;
    function GetStatus: String;
    function GetJSON: TJSONObject;

    procedure SetId(const Value: Integer);
    procedure SetDataInicial(const Value: TDateTime);
    procedure SetUrgencia(const Value: Byte);
    procedure SetDescricao(const Value: String);
    procedure SetQntApoio(const Value: Integer);
    procedure SetDataFinal(const Value: TDateTime);
    procedure SetDataAlteracao(const Value: TDateTime);
    procedure SetUsuario(const Value: TUsuario);
    procedure SetEndereco(const Value: TEndereco);
    procedure SetTipoProblema(const Value: String);
    procedure SetStatus(const Value: String);

  public
    constructor Create; overload;
    constructor Create(const aId: Integer); overload;

    constructor Create(aId, aQntApoio: Integer;
      aDataInicial, aDataFinal, aDataAlteracao: TDateTime; aUrgencia: Byte;
      aDescricao, aTipoProblema, aStatus: String; aUsuario: TUsuario;
      aEndereco: TEndereco); overload;

    destructor Destroy; override;

    property Id: Integer read GetId write SetId;
    property DataInicial: TDateTime read GetDataInicial write SetDataInicial;
    property Urgencia: Byte read GetUrgencia write SetUrgencia;
    property Descricao: String read GetDescricao write SetDescricao;
    property QntApoio: Integer read GetQntApoio write SetQntApoio;
    property DataFinal: TDateTime read GetDataFinal write SetDataFinal;
    property DataAlteracao: TDateTime read GetDataAlteracao write SetDataAlteracao;
    property Usuario: TUsuario read GetUsuario write SetUsuario;
    property Endereco: TEndereco read GetEndereco write SetEndereco;
    property TipoProblema: String read GetTipoProblema write SetTipoProblema;
    property Status: String read GetStatus write SetStatus;

    property JSON: TJSONObject read GetJSON;

  end;

implementation

uses
  System.SysUtils;

{ TOcorrencia }

constructor TOcorrencia.Create(aId, aQntApoio: Integer; aDataInicial, aDataFinal,
  aDataAlteracao: TDateTime; aUrgencia: Byte; aDescricao, aTipoProblema, aStatus: String;
  aUsuario: TUsuario; aEndereco: TEndereco);
begin
  FId            := aId;
  FQntApoio      := aQntApoio;
  FDataInicial   := aDataInicial;
  FDataFinal     := aDataFinal;
  FDataAlteracao := aDataAlteracao;
  FUrgencia      := aUrgencia;
  FDescricao     := aDescricao;
  FTipoProblema  := aTipoProblema;
  FStatus        := aStatus;
  FUsuario       := aUsuario;
  FEndereco      := aEndereco;
  Self.Create;
end;

constructor TOcorrencia.Create(const aId: Integer);
begin
  FId := aId;
  Self.Create;
end;

constructor TOcorrencia.Create;
begin
  FJSON := TJSONObject.Create;
end;

destructor TOcorrencia.Destroy;
begin
  FreeAndNil(FUsuario);
  FreeAndNil(FEndereco);
  FreeAndNil(FJSON);
  inherited;
end;

function TOcorrencia.GetDataAlteracao: TDateTime;
begin
  Result := FDataAlteracao;
end;

function TOcorrencia.GetDataFinal: TDateTime;
begin
  Result := FDataFinal;
end;

function TOcorrencia.GetDataInicial: TDateTime;
begin
  Result := FDataInicial;
end;

function TOcorrencia.GetDescricao: String;
begin
  Result := FDescricao;
end;

function TOcorrencia.GetEndereco: TEndereco;
begin
  Result := FEndereco;
end;

function TOcorrencia.GetId: Integer;
begin
  Result := FId;
end;

function TOcorrencia.GetJSON: TJSONObject;
begin
  if FId <> 0 then
    FJSON.AddPair('id',           FId.ToString);
  FJSON.AddPair('qntapoio',       FQntApoio.ToString);
  FJSON.AddPair('datainicial',    FormatDateTime('dd/mm/yy hh:nn:ss', FDataInicial));
  if FDataFinal <> 0 then
    FJSON.AddPair('datafinal',    FormatDateTime('dd/mm/yy hh:nn:ss', FDataFinal));
  if FDataAlteracao <> 0 then
    FJSON.AddPair('dataalteracao',FormatDateTime('dd/mm/yy hh:nn:ss', FDataAlteracao));
  FJSON.AddPair('urgencia',       FUrgencia.ToString);
  FJSON.AddPair('descricao',      FDescricao);
  FJSON.AddPair('idtipoproblema',   FTipoProblema);
  FJSON.AddPair('idstatus',         FStatus);
  FJSON.AddPair('idusuario',        FUsuario.Id.ToString);
  FJSON.AddPair('idendereco',       FEndereco.id.ToString);
  Result := FJSON;

end;

function TOcorrencia.GetQntApoio: Integer;
begin
  Result := FQntApoio;
end;

function TOcorrencia.GetStatus: String;
begin
  Result := FStatus;
end;

function TOcorrencia.GetTipoProblema: String;
begin
  Result := TipoProblema;
end;

function TOcorrencia.GetUrgencia: Byte;
begin
  Result := FUrgencia;
end;

function TOcorrencia.GetUsuario: TUsuario;
begin
  Result := FUsuario;
end;

procedure TOcorrencia.SetDataAlteracao(const Value: TDateTime);
begin
  FDataAlteracao := Value;
end;

procedure TOcorrencia.SetDataFinal(const Value: TDateTime);
begin
  FDataFinal := Value;
end;

procedure TOcorrencia.SetDataInicial(const Value: TDateTime);
begin
  FDataInicial := Value;
end;

procedure TOcorrencia.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TOcorrencia.SetEndereco(const Value: TEndereco);
begin
  FEndereco := Value;
end;

procedure TOcorrencia.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TOcorrencia.SetQntApoio(const Value: Integer);
begin
  FQntApoio := Value;
end;

procedure TOcorrencia.SetStatus(const Value: String);
begin
  FStatus := Value;
end;

procedure TOcorrencia.SetTipoProblema(const Value: String);
begin
  FTipoProblema := Value;
end;

procedure TOcorrencia.SetUrgencia(const Value: Byte);
begin
  FUrgencia := Value;
end;

procedure TOcorrencia.SetUsuario(const Value: TUsuario);
begin
  FUsuario := Value;
end;

end.
