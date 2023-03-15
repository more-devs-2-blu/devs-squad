unit UController.Ocorrencia;

interface

uses
  Horse,
  GBSwagger.Path.Attributes,
  UController.Base,
  UEntity.Ocorrencias;

type
  [SwagPath('ocorrencia', 'Ocorrência')]
  TControllerOcorrencia = class(TControllerBase)
  private

  public
    [SwagGET('Listar Ocorrências', True)]
    [SwagResponse(200, TOcorrencia, 'Informações da Ocorrência', True)]
    [SwagResponse(404)]
    class procedure Gets(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

    [SwagGET('{id}', 'Procurar uma Ocorrência')]
    [SwagParamPath('id', 'id da Ocorrência')]
    [SwagResponse(200, TOcorrencia, 'Informações da Ocorrência')]
    [SwagResponse(404)]
    class procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

    [SwagGET('usuario/{id}','Listar ocorrências de um usuário')]
    [SwagResponse(200, TOcorrencia, 'Informações de ocorrências de um usuário', True)]
    [SwagResponse(404)]
    class procedure GetsByUser(Req: THorseRequest; Res: THorseResponse; Next: TProc);

    [SwagGET('bairro/{bairro}','Listar ocorrências de um bairro')]
    [SwagResponse(200, TOcorrencia, 'Informações de ocorrências de um bairro', True)]
    [SwagResponse(404)]
    class procedure GetsByBairro(Req: THorseRequest; Res: THorseResponse; Next: TProc);

    [SwagGET('logradouro/{logradouro}','Listar ocorrências de um logradouro')]
    [SwagResponse(200, TOcorrencia, 'Informações de ocorrências de um logradouro', True)]
    [SwagResponse(404)]
    class procedure GetsByLogradouro(Req: THorseRequest; Res: THorseResponse; Next: TProc);

    [SwagPOST('Adicionar Nova Ocorrência')]
    [SwagParamBody('Informações da Ocorrencia', TOcorrencia)]
    [SwagResponse(201)]
    [SwagResponse(400)]
    class procedure Post(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

    [SwagUPDATE('Atualizar uma Ocorrência')]
    [SwagParamBody('Informações da Ocorrencia', TOcorrencia)]
    [SwagResponse(204)]
    [SwagResponse(400)]
    [SwagResponse(404)]
    class procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);

    [SwagDELETE('{id}', 'Deletar uma Ocorrência')]
    [SwagParamPath('id', 'Id da Ocorrência')]
    [SwagResponse(204)]
    [SwagResponse(400)]
    [SwagResponse(404)]
    class procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc); override;

  end;

implementation

{ TControllerOcorrencia }

uses
  UDAO.Ocorrencia, System.SysUtils, JSON, UEntity.Enderecos, UEntity.Usuarios,
  System.DateUtils;

class procedure TControllerOcorrencia.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOOcorrencia.Create;
  inherited;
end;

class procedure TControllerOcorrencia.Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOOcorrencia.Create;
  inherited;
end;

class procedure TControllerOcorrencia.Gets(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOOcorrencia.Create;
  inherited;
end;

class procedure TControllerOcorrencia.GetsByBairro(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  xBairro: String;
begin
  if (Req.Params.Count <> 1) or (not(Req.Params.ContainsKey('bairro'))) then
  begin
    Res.Status(THTTPStatus.BadRequest);
    Exit;
  end;
  xBairro := Req.Params.Items['bairro'];
  FDAO := TDAOOcorrencia.Create;
  Res.Send<TJSONArray>(TDAOOcorrencia(FDAO).ObterRegistrosPorBairro(xBairro));
end;

class procedure TControllerOcorrencia.GetsByLogradouro(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  xLogradouro: String;
begin
  if (Req.Params.Count <> 1) or (not(Req.Params.ContainsKey('logradouro'))) then
  begin
    Res.Status(THTTPStatus.BadRequest);
    Exit;
  end;
  xLogradouro := Req.Params.Items['logradouro'];
  FDAO := TDAOOcorrencia.Create;
  Res.Send<TJSONArray>(TDAOOcorrencia(FDAO).ObterRegistrosPorLogradouro(xLogradouro));
end;

class procedure TControllerOcorrencia.GetsByUser(Req: THorseRequest;
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
  FDAO := TDAOOcorrencia.Create;
  Res.Send<TJSONArray>(TDAOOcorrencia(FDAO).ObterRegistrosPorUsuario(xId));
end;

class procedure TControllerOcorrencia.Post(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  FDAO := TDAOOcorrencia.Create;
  inherited;
end;

class procedure TControllerOcorrencia.Update(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  xJSON: TJSONObject;
  xId, xIdStatus, xQtdApoio : Integer;
begin
  xJSON := Req.Body<TJSONObject>;

  xId := xJSON.GetValue<Integer>('id');
  xIdStatus := xJSON.GetValue<Integer>('idstatus');
  xQtdApoio := xJSON.GetValue<Integer>('qtdapoio');

  FDAO := TDAOOcorrencia.Create;
  if TDAOOcorrencia(FDAO).AtualizarRegistro(xId, xIdStatus, xQtdApoio) then
    Res.Status(THTTPStatus.OK)
  else
    Res.Status(THTTPStatus.InternalServerError);
end;

end.
