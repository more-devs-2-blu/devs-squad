unit UEntity.Ocorrencias;

interface

uses
  UEntity.Usuarios,
  UEntity.Enderecos,
  System.JSON,
  GBSwagger.Model.Attributes;

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

    [SwagProp('Ocorrencia Id', True)]
    property Id: Integer read GetId write SetId;

    [SwagProp('Ocorrencia Data e Hora Inicial', True)]
    property DataInicial: TDateTime read GetDataInicial write SetDataInicial;

    [SwagProp('Ocorrencia Urg�ncia', True)]
    property Urgencia: Byte read GetUrgencia write SetUrgencia;

    [SwagProp('Ocorrencia Descri��o', True)]
    property Descricao: String read GetDescricao write SetDescricao;

    [SwagProp('Ocorrencia Quantidade de Apoio', True)]
    property QntApoio: Integer read GetQntApoio write SetQntApoio;

    [SwagProp('Ocorrencia Data e Hora Final', True)]
    property DataFinal: TDateTime read GetDataFinal write SetDataFinal;

    [SwagProp('Ocorrencia Data e Hora altera��o', True)]
    property DataAlteracao: TDateTime read GetDataAlteracao write SetDataAlteracao;

    [SwagProp('Ocorrencia Usu�rio', True)]
    property Usuario: TUsuario read GetUsuario write SetUsuario;

    [SwagProp('Ocorrencia Endere�o', True)]
    property Endereco: TEndereco read GetEndereco write SetEndereco;

    [SwagProp('Ocorrencia Tipo Problema', True)]
    property TipoProblema: String read GetTipoProblema write SetTipoProblema;

    [SwagProp('Ocorrencia Status', True)]
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
   FUsuario       := aUsuario;
   FEndereco      := aEndereco;
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
  FJSON.AddPair('id',            FId.ToString);
  FJSON.AddPair('qntapoio',      FQntApoio.ToString);
  FJSON.AddPair('datainicial',   FormatDateTime('dd/mm/yy hh:nn:ss', FDataInicial));
  FJSON.AddPair('datafinal',     FormatDateTime('dd/mm/yy hh:nn:ss', FDataFinal));
  FJSON.AddPair('dataalteracao', FormatDateTime('dd/mm/yy hh:nn:ss', FDataAlteracao));
  FJSON.AddPair('urgencia',      FUrgencia.ToString);
  FJSON.AddPair('descricao',     FDescricao);
  FJSON.AddPair('tipoproblema',  FTipoProblema);
  FJSON.AddPair('status',        FStatus);
  FJSON.AddPair('usuario',       FUsuario.Id.ToString);
  FJSON.AddPair('endereco',      FEndereco.id.ToString);
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
