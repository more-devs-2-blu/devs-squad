import { Container, Box, Paper, Grid, Stack, Typography, Button } from '@mui/material'
import { useEffect, useContext, useCallback, useState } from 'react'
import { fetchServer } from '../utils/serverUtils';
import { OCORRENCIAS_URL } from '../utils/urls';
import avatar from "../assets/avatar.png"
import { useNavigate } from 'react-router-dom';
import { AuthContext } from '../context/AuthContext';
import Menu from '../components/Menu';

interface Ocorrencia {
  "id": number,
  "datainicial": string,
  "urgencia": number,
  "descricao": string,
  "qntapoio": number,
  "datafinal": string | null,
  "dataalteracao": string | null,
  "usuario": {
    "id": number,
    "tipousuario": string,
    "nome": string,
    "telefone": string,
    "bairro": string,
    "email": string,
    "cpf": string,
    "senha": string
  },
  "endereco": {
    "id": number,
    "cep": string,
    "bairro": string,
    "numero": number,
    "logradouro": string,
    "complemento": string
  },
  "status": string,
  "tipoProblema": string
}

export const Admin = () => {
  const [ocorrencias, setOcorrencias] = useState<Ocorrencia[] | []>([]);
  const [ocorrenciasBairro, setOcorrenciasBairro] = useState<any[]>([])
  const auth = useCallback(() => {
    useContext(AuthContext)
  }, []);

  useEffect(() => {
    const token = localStorage.getItem('auth-token');
    if (!token) return;
    const loadOcorrencias = async (token: string) => {
      if (!token) return;
      const response = await fetchServer(OCORRENCIAS_URL, { token: token });
      const response_data = await response?.json();
      if (response == null) return
      if (response.status !== 200) return
      let newArray: Ocorrencia[] | [] = [];
      const data: [Ocorrencia] = response_data.map((elem: Ocorrencia) => {
        newArray = [...newArray, elem];
      })
      setOcorrencias(newArray);
    }
    loadOcorrencias(token);
  }, [])

  useEffect(() => {
    if (ocorrencias === []) return

    let newArray: any[] = [];
    ocorrencias.forEach((ocor) => {
      let ocorIndex = 0;
      const bairro = newArray.find((item, index) => {
        if (item === undefined) return false
        ocorIndex = index;
        return item.bairro === ocor.endereco.bairro
      });
      if (bairro === undefined) {
        newArray = [...newArray, { bairro: ocor.endereco.bairro, qtd: 1 }]
      } else {
        const qtd = bairro.qtd
        newArray.splice(ocorIndex, 1, { bairro: ocor.endereco.bairro, qtd: qtd + 1 })
      }
    })
    setOcorrenciasBairro(newArray);
  }, [ocorrencias])

  return (
    <>
      <Container sx={{ minHeight: "100vh", display: "grid", placeItems: "center" }}>
        <Box component="main" pt={1} pb={6}>
          <Paper sx={{ width: "800px", minHeight: "600px" }}>
            <Stack minHeight={"600px"} direction={"row"}>
              <Menu />
              <Stack justifyContent={"space-between"} p={3} width={"70%"}>
                <Box>
                  <Typography variant="h6" textAlign={"center"}>Total de ocorrências por bairro</Typography>
                  <Stack mt={1} p={2}>
                    {ocorrenciasBairro.map(elem => <Typography textAlign={"center"}>{elem.bairro}: {elem.qtd}</Typography>)}
                  </Stack>
                </Box>
                <Box>
                  <Typography textAlign={"center"}>Total de ocorrências: {ocorrenciasBairro.length}</Typography>
                </Box>

              </Stack>
            </Stack>
          </Paper>
        </Box>
      </Container>
    </>
  )
}