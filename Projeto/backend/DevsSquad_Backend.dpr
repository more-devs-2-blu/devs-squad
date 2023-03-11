program DevsSquad_Backend;

{$APPTYPE CONSOLE}

uses
  Horse,
  Horse.Jhonson,
  Horse.CORS,
  Horse.JWT,
  Horse.BasicAuthentication,
  Horse.GBSwagger,
  System.SysUtils;

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
//      .Title('Documentação API DevsBets')
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