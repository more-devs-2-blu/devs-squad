program DevsSquad_Backend;

{$APPTYPE CONSOLE}

uses
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  Horse.JWT,
  Horse.BasicAuthentication,
  Horse.GBSwagger,
  System.SysUtils,
  UEntity.Usuarios in 'model\entities\UEntity.Usuarios.pas',
  UEntity.Logins in 'model\entities\UEntity.Logins.pas',
  UEntity.Ocorrencias in 'model\entities\UEntity.Ocorrencias.pas',
  UEntity.Enderecos in 'model\entities\UEntity.Enderecos.pas',
  UDAO.Apoios in 'model\dao\UDAO.Apoios.pas',
  UDAO.Base in 'model\dao\UDAO.Base.pas',
  UDAO.Endereco in 'model\dao\UDAO.Endereco.pas',
  UDAO.Intf in 'model\dao\UDAO.Intf.pas',
  UDAO.Ocorrencia in 'model\dao\UDAO.Ocorrencia.pas',
  UDAO.Status in 'model\dao\UDAO.Status.pas',
  UDAO.TipoProblema in 'model\dao\UDAO.TipoProblema.pas',
  UDAO.Usuario in 'model\dao\UDAO.Usuario.pas',
  UUtil.Banco in 'model\utils\UUtil.Banco.pas',
  UController.Base in 'model\controllers\UController.Base.pas',
  UController.Usuario in 'model\controllers\UController.Usuario.pas',
  UController.Login in 'model\controllers\UController.Login.pas',
  UController.Apoios in 'model\controllers\UController.Apoios.pas',
  UController.Endereco in 'model\controllers\UController.Endereco.pas',
  UController.Ocorrencia in 'model\controllers\UController.Ocorrencia.pas',
  UEntity.Apoios in 'model\entities\UEntity.Apoios.pas';

procedure Registry;
begin
  //Login
  THorse.Group.Prefix('v1')
    .Post('/login', TControllerLogin.PostLogin);

  //Usuários
  THorse.Group.Prefix('v1')
    .Get('/usuarios', TControllerUsuario.Gets)
    .Get('/usuarios/:id', TControllerUsuario.Get)
    .Post('/usuarios', TControllerUsuario.Post)
    .Delete('/usuarios/:id', TControllerUsuario.Delete);

  //Endereços
  THorse.Group.Prefix('v1')
    .Get('/enderecos', TControllerEndereco.Gets)
    .Get('/enderecos/:id', TControllerEndereco.Get)
    .Post('/enderecos', TControllerEndereco.Post)
    .Post('/enderecos/id',TControllerEndereco.GetId)
    .Delete('/enderecos/:id', TControllerEndereco.Delete);

  //Ocorrências
  THorse.Group.Prefix('v1')
    .Get('/ocorrencias', TControllerOcorrencia.Gets)
    .Get('/ocorrencias/:id', TControllerOcorrencia.Get)
    .Get('/ocorrencias/usuario/:id', TControllerOcorrencia.GetsByUser)
    .Get('/ocorrencias/bairro/:bairro', TControllerOcorrencia.GetsByBairro)
    .Get('/ocorrencias/logradouro/:logradouro', TControllerOcorrencia.GetsByLogradouro)
    .Post('/ocorrencias', TControllerOcorrencia.Post)
    .Delete('/ocorrencias/:id', TControllerOcorrencia.Delete);

  //Apoios
  THorse.Group.Prefix('v1')
    .Get('/apoios', TControllerApoios.Gets)
    .Get('/apoios/usuario/:id',TControllerApoios.GetsByUser)
    .Get('/apoios/:id', TControllerApoios.Get)
    .Post('/apoios', TControllerApoios.Post)
    .Delete('/apoios/:id', TControllerApoios.Delete);

end;

procedure SwaggerConfig;
begin
  THorseGBSwaggerRegister.RegisterPath(TControllerUsuario);
  THorseGBSwaggerRegister.RegisterPath(TControllerLogin);
  THorseGBSwaggerRegister.RegisterPath(TControllerEndereco);
  THorseGBSwaggerRegister.RegisterPath(TControllerOcorrencia);
  THorseGBSwaggerRegister.RegisterPath(TControllerApoios);
//
  //http://localhost:9000/swagger/doc/html
  Swagger
    .Info
      .Title('Documentação API Devs Squad')
      .Description('Serviço - Escuta Cidadão')
      .Contact
        .Name('Devs Squad')
        .Email('maximilianomfurtado@gmail.com')
        .URL('https://github.com/more-devs-2-blu/devs-squad')
      .&End
    .&End
    .BasePath('v1');
end;

procedure ConfigMiddleware;
begin
  THorse
    .Use(Cors)
    .Use(HorseSwagger)
    .Use(Jhonson());

//  Basic Authentication usado para o Login
  THorse
    .Use(HorseBasicAuthentication(
      TControllerUsuario.ValidateUser,
      THorseBasicAuthenticationConfig
        .New
          .SkipRoutes(['/v1/usuarios',
                       '/v1/usuarios/:id',
                       '/v1/enderecos/:id',
                       '/v1/enderecos/id',
                       '/v1/enderecos',
                       '/v1/ocorrencias/:id',
                       '/v1/ocorrencias',
                       '/v1/ocorrencias/usuario/:id',
                       '/v1/ocorrencias/bairro/:bairro',
                       '/v1/ocorrencias/logradouro/:logradouro',
                       '/v1/apoios/:id',
                       '/v1/apoios',
                       '/v1/apoios/usuario/:id',
                       '/swagger/doc/html',
                       '/swagger/doc/json'])));

  //JWT usado para as demais rotas
  THorse
    .Use(HorseJWT('KeyDevsSquad',
      THorseJWTConfig
        .New
          .SkipRoutes(['/v1/login',
                       '/v1/usuarios',
                       '/v1/usuarios/:id',
                       '/swagger/doc/html',
                       '/swagger/doc/json'])));
end;

begin
  ConfigMiddleware;
  SwaggerConfig;
  Registry;

  THorse.Listen(9000,procedure
    begin
      Writeln('Server running at port 9000...');
      Writeln('');
      Writeln('API documentation: http://localhost:9000/swagger/doc/html');
    end);

end.