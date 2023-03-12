unit UController.Apoios;

interface

uses
  Horse,
  GBSwagger.Path.Attributes,
  UController.Base,
  UEntity.Apoios;

type
  [SwagPath('apoios', 'Apoios')]
  TControllerApoios = class(TControllerBase)
    private
    public
      [SwagGET('Listar Apoios', True)]
      [SwagResponse(200, TApoios, 'Informações de apoios', True)]
      [SwagResponse(404)]
      class procedure Gets(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

      [SwagGET('usuario/{id}','Listar Apoios de um usuário')]
      [SwagResponse(200, TApoios, 'Informações de apoios de um usuário', True)]
      [SwagResponse(404)]
      class procedure GetsByUser(Req: THorseRequest; Res: THorseResponse; Next: TProc);

      [SwagGET('{id}', 'Procurar Apoio')]
      [SwagParamPath('id', 'id do Apoio')]
      [SwagResponse(200, TApoios, 'Informações do Apoio')]
      [SwagResponse(404)]
      class procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

      [SwagPOST('Adicionar novo apoio')]
      [SwagParamBody('Informações do Apoio', TApoios)]
      [SwagResponse(201)]
      [SwagResponse(400)]
      class procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

      [SwagDELETE('{id}', 'Deletar um apoio')]
      [SwagParamPath('id', 'Id do Apoio')]
      [SwagResponse(204)]
      [SwagResponse(400)]
      [SwagResponse(404)]
      class procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;
  end;

implementation

{ TControllerApoios }

uses
  UDAO.Intf,
  UDAO.Apoios,
  System.JSON,
  System.SysUtils;

class procedure TControllerApoios.Delete(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOApoios.Create;
  Inherited;
end;

class procedure TControllerApoios.Get(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
begin
  FDAO := TDAOApoios.Create;
  Inherited;
end;

class procedure TControllerApoios.Gets(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOApoios.Create;
  Inherited;
end;

class procedure TControllerApoios.GetsByUser(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  xId: Integer;
begin
  if (Req.Params.Count <> 1) or (not(Req.Params.ContainsKey('id'))) then
  begin
    Res.Status(THTTPStatus.BadRequest);
    Exit;
  end;
  xId := StrToIntDef(Req.Params.Items['id'], 0);
  FDAO := TDAOApoios.Create;
  Res.Send<TJSONArray>(TDAOApoios(FDAO).ObterRegistrosPorUsuario(xId));
end;

class procedure TControllerApoios.Post(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOApoios.Create;
  Inherited;
end;

end.
