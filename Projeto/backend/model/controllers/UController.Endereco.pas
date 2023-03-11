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
      [SwagResponse(200, TEndereco, 'Informações do Apoio')]
      [SwagResponse(404)]
      class procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

      [SwagPOST('Adicionar novo Endereço')]
      [SwagParamBody('Informações do Time', TEndereco)]
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
  UDAO.Intf,
  UDAO.Endereco,
  System.JSON,
  System.SysUtils;

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
