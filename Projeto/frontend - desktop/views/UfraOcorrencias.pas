unit UfraOcorrencias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Objects, FMX.Controls.Presentation, UEntity.Ocorrencias;

type
  TfraOcorrencias = class(TFrame)
    fraOcorrencias: TLabel;
    rectLista: TRectangle;
    lstOcorrencias: TListView;
  private
    { Private declarations }

    procedure PreparaListView(aOcorrenciaBairroUser: TOcorrencia);
  public
    { Public declarations }
    procedure CarregarRegistros;
  end;

var
  FraOcorrencia: TFraOcorrencias;

implementation

uses
  UService.Intf, UService.Ocorrencia,
  UService.Usuario.Authenticated;

{$R *.fmx}

{ TfraOcorrencias }

procedure TfraOcorrencias.CarregarRegistros;
var
  xServiceOcorrencia : IService;
  xOcorrencia : TOcorrencia;
begin

  xServiceOcorrencia := TServiceOcorrencia.Create;
  TServiceOcorrencia(xServiceOcorrencia).ListaPorUsuario(gbInstance.Usuario.Id);
  for xOcorrencia in TServiceOcorrencia(xServiceOcorrencia).Ocorrencias do
  begin
    ShowMessage(xOcorrencia.Endereco.Logradouro);
    ShowMessage(gbInstance.Usuario.Id.ToString);
  end;
end;

procedure TfraOcorrencias.PreparaListView(aOcorrenciaBairroUser: TOcorrencia);
var
  xItem: TListViewItem;
begin
 { xItem := lstOcorrencias.Items.Add;
  xItem.Tag := aOcorrenciaBairroUser.Id;

  TListItemText(xItem.Objects.FindDrawable('txtProblema')).Text := aOcorrenciaBairroUser.TipoProblema;
  TListItemText(xItem.Objects.FindDrawable('txtBairro')).Text := aOcorrenciaBairroUser.Endereco.Bairro;
  TListItemText(xItem.Objects.FindDrawable('txtRua')).Text := aOcorrenciaBairroUser.Endereco.Logradouro;
  TListItemText(xItem.Objects.FindDrawable('txtApoiadores')).Text := aOcorrenciaBairroUser.QntApoio.ToString;
  TListItemText(xItem.Objects.FindDrawable('txtNumero')).Text := aOcorrenciaBairroUser.Endereco.Numero.ToString;
  TListItemText(xItem.Objects.FindDrawable('txtDescricao')).Text := aOcorrenciaBairroUser.Descricao;
  TListItemText(xItem.Objects.FindDrawable('txtUrgencia')).Text := aOcorrenciaBairroUser.Urgencia.ToString; }
end;

end.
