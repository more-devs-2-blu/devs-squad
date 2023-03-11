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

{ TOcorrencia }

constructor TOcorrencia.Create(aId, aQntApoio: Integer; aDataInicial, aDataFinal,
  aDataAlteracao: TDateTime; aUrgencia: Byte; aDescricao, aTipoProblema, aStatus: String;
  aUsuario: TUsuario; aEndereco: TEndereco);
begin

end;

constructor TOcorrencia.Create(const aId: Integer);
begin

end;

constructor TOcorrencia.Create;
begin

end;

destructor TOcorrencia.Destroy;
begin

  inherited;
end;

function TOcorrencia.GetDataAlteracao: TDateTime;
begin

end;

function TOcorrencia.GetDataFinal: TDateTime;
begin

end;

function TOcorrencia.GetDataInicial: TDateTime;
begin

end;

function TOcorrencia.GetDescricao: String;
begin

end;

function TOcorrencia.GetEndereco: TEndereco;
begin

end;

function TOcorrencia.GetId: Integer;
begin

end;

function TOcorrencia.GetJSON: TJSONObject;
begin

end;

function TOcorrencia.GetQntApoio: Integer;
begin

end;

function TOcorrencia.GetStatus: String;
begin

end;

function TOcorrencia.GetTipoProblema: String;
begin

end;

function TOcorrencia.GetUrgencia: Byte;
begin

end;

function TOcorrencia.GetUsuario: TUsuario;
begin

end;

procedure TOcorrencia.SetDataAlteracao(const Value: TDateTime);
begin

end;

procedure TOcorrencia.SetDataFinal(const Value: TDateTime);
begin

end;

procedure TOcorrencia.SetDataInicial(const Value: TDateTime);
begin

end;

procedure TOcorrencia.SetDescricao(const Value: String);
begin

end;

procedure TOcorrencia.SetEndereco(const Value: TEndereco);
begin

end;

procedure TOcorrencia.SetId(const Value: Integer);
begin

end;

procedure TOcorrencia.SetQntApoio(const Value: Integer);
begin

end;

procedure TOcorrencia.SetStatus(const Value: String);
begin

end;

procedure TOcorrencia.SetTipoProblema(const Value: String);
begin

end;

procedure TOcorrencia.SetUrgencia(const Value: Byte);
begin

end;

procedure TOcorrencia.SetUsuario(const Value: TUsuario);
begin

end;

end.
