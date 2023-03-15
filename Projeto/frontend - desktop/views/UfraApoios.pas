unit UfraApoios;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Controls.Presentation, Skia,
  Skia.FMX, UEntity.Ocorrencias;

type
  TfraApoio = class(TFrame)
    rectLista: TRectangle;
    lstApoio: TListView;
    lblTituloFrame: TLabel;
  private
    { Private declarations }
    procedure CarregarRegistros;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  FraApoio: TfraApoio;

implementation

uses
  UEntity.Apoios, UService.Intf, UService.Apoio,
  UService.Usuario.Authenticated;

{$R *.fmx}
{ TfraApoio }

procedure TfraApoio.CarregarRegistros;
var
  xServiceApoio: IService;
  xApoio: TApoios;
  xItem: TListViewItem;
    xUrgencia: String;
begin
  try
    lstApoio.Items.Clear;

    xServiceApoio := TServiceApoio.Create;
    TServiceApoio(xServiceApoio).ListarApoiosDeUsuario(GbInstance.Usuario.Id);

    for xApoio in TServiceApoio(xServiceApoio).Apoios do

    xItem := lstApoio.Items.Add;
    xItem.Tag := xApoio.Ocorrencia.Id;

    TListItemText(xItem.Objects.FindDrawable('txtDescricao')).Text :=
      'Descrição: ' + xApoio.Ocorrencia.Descricao;

    TListItemText(xItem.Objects.FindDrawable('txtBairro')).Text := 'Bairro: ' +
      xApoio.Ocorrencia.Endereco.Bairro;

    TListItemText(xItem.Objects.FindDrawable('txtRua')).Text :=
      xApoio.Ocorrencia.Endereco.Logradouro;

    TListItemText(xItem.Objects.FindDrawable('txtApoiadores')).Text :=
      'Apoios: ' + xApoio.Ocorrencia.QntApoio.ToString;

    TListItemText(xItem.Objects.FindDrawable('txtNumero')).Text :=
      'Nº: ' + xApoio.Ocorrencia.Endereco.Numero.ToString;

    TListItemText(xItem.Objects.FindDrawable('txtProblema')).Text :=
      'Problema: ' + xApoio.Ocorrencia.TipoProblema;

    if xApoio.Ocorrencia.Urgencia.ToString = '0' then
      xUrgencia := 'Não urgente'
    else
      xUrgencia := 'URGENTE';

    TListItemText(xItem.Objects.FindDrawable('txtUrgencia')).Text := xUrgencia;

  except

  end;

end;

constructor TfraApoio.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CarregarRegistros;
end;

end.
