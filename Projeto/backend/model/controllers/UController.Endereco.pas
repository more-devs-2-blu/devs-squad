unit UController.Endereco;

interface

uses
  Horse,
  GBSwagger.Path.Attributes,
  UController.Base,
  UEntity.Enderecos;

type
  [SwagPath('enderecos', 'Endereços')]
  TControllerEndereco = class(TControllerBase)
    private
    public
      [SwagGET('Listar Endereços', True)]
      [SwagResponse(200, TEndereco, 'Informações de Endereço', True)]
      [SwagResponse(404)]
      class procedure Gets(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

      [SwagGET('{id}', 'Procurar um endereço')]
      [SwagParamPath('id', 'id do Endereço')]
      [SwagResponse(200, TEndereco, 'Informações do Endereço')]
      [SwagResponse(404)]
      class procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

      [SwagPOST('id', 'Procurar Id')]
      [SwagParamPath('/id/', 'id do Endereço')]
      [SwagResponse(200, 'Dados do endereço em JSON', 'Id do Endereço')]
      [SwagResponse(404)]
      class procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);

      [SwagPOST('Adicionar novo Endereço')]
      [SwagParamBody('Informações do Endereço', TEndereco)]
      [SwagResponse(201)]
      [SwagResponse(400)]
      class procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

      [SwagDELETE('{id}', 'Deletar um Endereço')]
      [SwagParamPath('id', 'Id do Endereço')]
      [SwagResponse(204)]
      [SwagResponse(400)]
      [SwagResponse(404)]
      class procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
  end;

implementation

{ TControllerEndereco }

uses
  UDAO.Endereco, System.SysUtils, JOSE.Types.JSON;

class procedure TControllerEndereco.Delete(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOEndereco.Create;
  Inherited;
end;

class procedure TControllerEndereco.Get(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOEndereco.Create;
  Inherited;
end;

class procedure TControllerEndereco.GetId(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  xJSON: TJSONObject;
  xEndereco: TEndereco;
  xId: Integer;
begin

  xJSON := TJSONObject.Create;
  xJSON := Req.Body<TJSONObject>;

   {TJSONObject.ParseJSONValue(
      TEncoding.ASCII.GetBytes(
        Req.Body), 0) as TJSONObject; }

  xEndereco := TEndereco.Create( 0,
                    xJSON.GetValue<Integer>('numero'),
                    xJSON.GetValue('cep').Value,
                    xJSON.GetValue('bairro').Value,
                    xJSON.GetValue('logradouro').Value,
                    xJSON.GetValue('complemento').Value);
  FDAO := TDAOEndereco.Create;
  xId := TDAOEndereco(FDAO).ProcurarIdPorEndereco(xEndereco);
  if xId = 0 then
  begin
    Res.Status(THTTPStatus.InternalServerError);
    Exit;
  end;

  Res.Send(xId.ToString);

end;

class procedure TControllerEndereco.Gets(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOEndereco.Create;
  Inherited;
end;

class procedure TControllerEndereco.Post(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOEndereco.Create;
  Inherited;
end;

end.
