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
  UUtil.Banco in 'model\utils\UUtil.Banco.pas';

procedure Registry;
begin

end;

procedure SwaggerConfig;
begin
//  THorseGBSwaggerRegister.RegisterPath(TControllerUser);
//  THorseGBSwaggerRegister.RegisterPath(TControllerTeam);
//  THorseGBSwaggerRegister.RegisterPath(TControllerMatch);
//  THorseGBSwaggerRegister.RegisterPath(TControllerBet);
//  THorseGBSwaggerRegister.RegisterPath(TControllerLogin);
//
//  //http://localhost:9000/swagger/doc/html
//  Swagger
//    .Info
//      .Title('Documenta��o API DevsBets')
//      .Description('DevsBets - Lance seu Palpite')
//      .Contact
//        .Name('Nome da equipe')
//        .Email('email@hotmail.com')
//        .URL('http://www.mypage.com.br')
//      .&End
//    .&End
//    .BasePath('v1');
end;

procedure ConfigMiddleware;
begin
//  THorse
//    .Use(Cors)
//    .Use(HorseSwagger)
//    .Use(Jhonson());

  //Basic Authentication usado para o Login
//  THorse
//    .Use(HorseBasicAuthentication(
//      TControllerUser.ValidateUser,
//      THorseBasicAuthenticationConfig
//        .New
//          .SkipRoutes(['/v1/users',
//                       '/v1/users/:id',
//                       '/swagger/doc/html',
//                       '/swagger/doc/json'])));

  //JWT usado para as demais rotas
  THorse
    .Use(HorseJWT('KeyDevsBets',
      THorseJWTConfig
        .New
          .SkipRoutes(['/v1/login',
                       '/v1/users',
                       '/v1/users/:id',
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