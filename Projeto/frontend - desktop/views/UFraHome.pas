unit UFraHome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation, FMX.ListView, FMX.Objects, UfraOcorrencias,
  UEntity.Ocorrencias, Skia,
  Skia.FMX, FMX.Edit, Generics.Collections;

type
  TfraHome = class(TFrame)
    rectApoiar: TRectangle;
    lblApoiar: TLabel;
    lblTituloFrame: TLabel;
    rectLista: TRectangle;
    lstOcorrencias: TListView;
    SkAnimatedImage1: TSkAnimatedImage;
    rectOcorrenciaBairroUser: TRectangle;
    lblOcorrenciasBairroUsuario: TLabel;
    TimerGifCarregar: TTimer;
    rectPesquisarBairro: TRectangle;
    edtPesquisarBairro: TEdit;
    rectPesquisa: TRectangle;
    imgLupa: TImage;
    rectTodasOcorrencias: TRectangle;
    lblTodasOcorrencias: TLabel;
    procedure TimerGifCarregarTimer(Sender: TObject);
    procedure rectOcorrenciaBairroUserClick(Sender: TObject);
    procedure rectPesquisaClick(Sender: TObject);
    procedure rectApoiarClick(Sender: TObject);
    procedure rectTodasOcorrenciasClick(Sender: TObject);

  private
    { Private declarations }
    procedure CarregarRegistros;
    procedure PrepararListView(aOcorrencia: TOcorrencia);
    procedure PreparaListViewFiltroBairroUser(aOcorrencia: TOcorrencia);
    procedure IniciarGifLoad;
    procedure FiltroOcorrenciasBairroUser;
    procedure PesquisarBairro;
    procedure ApoiarOcorrencia;
  public
    { Public declarations }
  end;

var
  fraHome: TfraHome;

implementation

uses
  UService.Intf,
  UService.Ocorrencia,
  UService.Usuario.Authenticated, UEntity.Enderecos, UService.Endereco;

{$R *.fmx}
{ TfraHome }

procedure TfraHome.ApoiarOcorrencia;
begin
  //
end;

procedure TfraHome.CarregarRegistros;
var
  xServiceOcorrencia: IService;
  xOcorrencia: TOcorrencia;
begin
  try
    lstOcorrencias.Items.Clear;

    xServiceOcorrencia := TServiceOcorrencia.Create;
    xServiceOcorrencia.Listar;

    for xOcorrencia in TServiceOcorrencia(xServiceOcorrencia).Ocorrencias do
      Self.PrepararListView(xOcorrencia);
  except

  end;
end;

procedure TfraHome.FiltroOcorrenciasBairroUser;
var
  xServiceOcorrencia: IService;
  xOcorrencia: TOcorrencia;

begin
  try
    lstOcorrencias.Items.Clear;

    xServiceOcorrencia := TServiceOcorrencia.Create;
    TServiceOcorrencia(xServiceOcorrencia).ListaPorBairro(gbInstance.Usuario.Bairro);

    for xOcorrencia in TServiceOcorrencia(xServiceOcorrencia).Ocorrencias do
      Self.PreparaListViewFiltroBairroUser(xOcorrencia);

  except

  end;

end;

procedure TfraHome.IniciarGifLoad;
begin
  TimerGifCarregar.Enabled := false;
  SkAnimatedImage1.Visible := false;
  CarregarRegistros;
end;

procedure TfraHome.PesquisarBairro;
begin
  lstOcorrencias.Items.Clear;
end;

procedure TfraHome.PreparaListViewFiltroBairroUser(aOcorrencia: TOcorrencia);
var
  xItem: TListViewItem;
  xUrgencia: String;
begin
  xItem := lstOcorrencias.Items.Add;
  xItem.Tag := aOcorrencia.Id;

  TListItemText(xItem.Objects.FindDrawable('txtBairro')).Text :=
    aOcorrencia.Endereco.Bairro;
  TListItemText(xItem.Objects.FindDrawable('txtRua')).Text :=
    aOcorrencia.Endereco.Logradouro;
  TListItemText(xItem.Objects.FindDrawable('txtApoiadores')).Text :=
    aOcorrencia.QntApoio.ToString;
  TListItemText(xItem.Objects.FindDrawable('txtNumero')).Text :=
    aOcorrencia.Endereco.Numero.ToString;
  TListItemText(xItem.Objects.FindDrawable('txtDescricao')).Text :=
    aOcorrencia.Descricao;

  if aOcorrencia.Urgencia.ToString = '0' then
    xUrgencia := 'Não urgente'
  else
    xUrgencia := 'URGENTE';

  TListItemText(xItem.Objects.FindDrawable('txtUrgencia')).Text := xUrgencia;
end;

procedure TfraHome.PrepararListView(aOcorrencia: TOcorrencia);
var
  xItem: TListViewItem;
  xUrgencia: String;
begin
  xItem := lstOcorrencias.Items.Add;
  xItem.Tag := aOcorrencia.Id;

  TListItemText(xItem.Objects.FindDrawable('txtBairro')).Text := 'Bairro: ' +
    aOcorrencia.Endereco.Bairro;
  TListItemText(xItem.Objects.FindDrawable('txtRua')).Text :=
    aOcorrencia.Endereco.Logradouro;
  TListItemText(xItem.Objects.FindDrawable('txtApoiadores')).Text := 'Apoios: '
    + aOcorrencia.QntApoio.ToString;
  TListItemText(xItem.Objects.FindDrawable('txtNumero')).Text :=
    'Nº: ' + aOcorrencia.Endereco.Numero.ToString;
  TListItemText(xItem.Objects.FindDrawable('txtDescricao')).Text :=
    'Descrição: ' + aOcorrencia.Descricao;

  if aOcorrencia.Urgencia.ToString = '0' then
    xUrgencia := 'Não urgente'
  else
    xUrgencia := 'URGENTE';

  TListItemText(xItem.Objects.FindDrawable('txtUrgencia')).Text := xUrgencia;
end;

procedure TfraHome.rectApoiarClick(Sender: TObject);
begin
  ApoiarOcorrencia;
end;

procedure TfraHome.rectOcorrenciaBairroUserClick(Sender: TObject);
begin
  FiltroOcorrenciasBairroUser;
end;

procedure TfraHome.rectPesquisaClick(Sender: TObject);
begin
  PesquisarBairro;
end;

procedure TfraHome.rectTodasOcorrenciasClick(Sender: TObject);
begin
  CarregarRegistros;
end;

procedure TfraHome.TimerGifCarregarTimer(Sender: TObject);
begin
  IniciarGifLoad;
end;

end.
