unit UFraHome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation, FMX.ListView, FMX.Objects, UfraOcorrencias, UEntity.Ocorrencias, Skia,
  Skia.FMX, FMX.Edit, Generics.Collections;

type
  TfraHome = class(TFrame)
    RectApoiar: TRectangle;
    lblApoiar: TLabel;
    lblTituloFrame: TLabel;
    rectLista: TRectangle;
    lstOcorrencias: TListView;
    SkAnimatedImage1: TSkAnimatedImage;
    RectOcorrenciaBairroUser: TRectangle;
    Label1: TLabel;
    TimerGifCarregar: TTimer;
    RectPesquisarBairro: TRectangle;
    edtPesquisarBairro: TEdit;
    rectPesquisa: TRectangle;
    imgLupa: TImage;
    procedure TimerGifCarregarTimer(Sender: TObject);
    procedure RectOcorrenciaBairroUserClick(Sender: TObject);
    procedure rectPesquisaClick(Sender: TObject);

  private
    { Private declarations }
    procedure CarregarRegistros;
    procedure PrepararListView(aOcorrencia: TOcorrencia);
    procedure PreparaListViewFiltroBairroUser(aOcorrencia: TOcorrencia);
    procedure IniciarGifLoad;
    procedure FiltroOcorrenciasBairroUser;
    procedure PesquisarBairro;
  public
    { Public declarations }
  end;

var
  fraHome: TFraHome;

implementation

uses
  UService.Intf,
  UService.Ocorrencia,
  UService.Usuario.Authenticated, UEntity.Enderecos, UService.Endereco;

{$R *.fmx}

{ TfraHome }

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
  xServiceOcorrencia : IService;
  xOcorrencia : TOcorrencia;

begin
  lstOcorrencias.Items.Clear;

  xServiceOcorrencia := TServiceOcorrencia.Create;
  TServiceOcorrencia(xServiceOcorrencia).ListaPorBairro(gbInstance.Usuario.Bairro);
  for xOcorrencia in TServiceOcorrencia(xServiceOcorrencia).Ocorrencias do
  begin
    Self.PreparaListViewFiltroBairroUser(xOcorrencia);
  end;
end;

procedure TfraHome.IniciarGifLoad;
begin
  TimerGifCarregar.Enabled := false;
  SkAnimatedImage1.Visible := False;
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

  TListItemText(xItem.Objects.FindDrawable('txtBairro')).Text := aOcorrencia.Endereco.Bairro;
  TListItemText(xItem.Objects.FindDrawable('txtRua')).Text := aOcorrencia.Endereco.Logradouro;
  TListItemText(xItem.Objects.FindDrawable('txtApoiadores')).Text := aOcorrencia.QntApoio.ToString;
  TListItemText(xItem.Objects.FindDrawable('txtNumero')).Text := aOcorrencia.Endereco.Numero.ToString;
  TListItemText(xItem.Objects.FindDrawable('txtDescricao')).Text := aOcorrencia.Descricao;

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

  TListItemText(xItem.Objects.FindDrawable('txtBairro')).Text := aOcorrencia.Endereco.Bairro;
  TListItemText(xItem.Objects.FindDrawable('txtRua')).Text := aOcorrencia.Endereco.Logradouro;
  TListItemText(xItem.Objects.FindDrawable('txtApoiadores')).Text := 'Apoios:' + aOcorrencia.QntApoio.ToString;
  TListItemText(xItem.Objects.FindDrawable('txtNumero')).Text := 'numero: '+aOcorrencia.Endereco.Numero.ToString;
  TListItemText(xItem.Objects.FindDrawable('txtDescricao')).Text := aOcorrencia.Descricao;
  if aOcorrencia.Urgencia.ToString = '0' then
    xUrgencia := 'Não urgente'
  else
    xUrgencia := 'URGENTE';

  TListItemText(xItem.Objects.FindDrawable('txtUrgencia')).Text := xUrgencia;
end;

procedure TfraHome.RectOcorrenciaBairroUserClick(Sender: TObject);
begin
  FiltroOcorrenciasBairroUser;
end;

procedure TfraHome.rectPesquisaClick(Sender: TObject);
begin
  PesquisarBairro;
end;

procedure TfraHome.TimerGifCarregarTimer(Sender: TObject);
begin
  IniciarGifLoad;
end;

end.
