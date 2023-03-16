const BACKEND_URL = 'localhost'
const PORT = 9000;
const VERSION = 'v1'
const DEFAULT_PATH =  `http://${BACKEND_URL}:${PORT}/${VERSION}/`

export const LOGIN_URL = DEFAULT_PATH + 'login';
export const ENDERECOS_URL = DEFAULT_PATH + 'enderecos'
export const APOIOS_URL = DEFAULT_PATH + 'apoios'
export const OCORRENCIAS_URL = DEFAULT_PATH + 'ocorrencias'
export const USUARIOS_URL = DEFAULT_PATH + 'usuarios'