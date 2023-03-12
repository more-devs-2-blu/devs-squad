unit UUtils.Constants;

interface

const
  URL_BASE_LOGIN = 'http://localhost:9000/v1/login';
  URL_BASE_USUARIOS  = 'http://localhost:9000/v1/usuarios';
  URL_BASE_ENDERECOS  = 'http://localhost:9000/v1/enderecos';
  URL_BASE_OCORRENCIAS = 'http://localhost:9000/v1/ocorrencias';
  URL_BASE_APOIOS   = 'http://localhost:9000/v1/apoios';

  API_SUCESSO             = 200;
  API_CRIADO              = 201;
  API_SUCESSO_SEM_RETORNO = 204;
  API_NAO_AUTORIZADO      = 401;

  // Configurações de envio de email
  MAIL_EMAIL = 'maximilianomfurtado@gmail.com'; // Crie um email para enviar emails
  MAIL_PASSWORD = ''; //Senha que precisa gerar para aplicativos
  MAIL_PORT = 587; //Porta padrão
  MAIL_SMTP = 'smtp.gmail.com'; //"Email" Padrão do SMTP

implementation

end.
