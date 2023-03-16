import {
  Container, Box, Paper, Stack, Typography,
  Button, CardContent, CardActions, Card, Accordion, AccordionSummary, AccordionDetails, Divider, Modal, FormControl, InputLabel, Select, SelectChangeEvent, MenuItem
} from '@mui/material'
import React, { useEffect, useContext, useCallback, useState } from 'react'
import { fetchServer } from '../utils/serverUtils';
import { OCORRENCIAS_URL } from '../utils/urls';
import { AuthContext } from '../context/AuthContext';
import Menu from '../components/Menu';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';

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

const style = {
  position: 'absolute' as 'absolute',
  top: '50%',
  left: '50%',
  transform: 'translate(-50%, -50%)',
  width: 500,
  bgcolor: 'background.paper',
  border: '2px solid #2b2b2b',
  boxShadow: 24,
  borderRadius: 1,
  p: 4,
};


function CardContant({ ocor, deleteOcorrencia, updateOcorrencia }:
  {
    ocor: Ocorrencia, deleteOcorrencia: (aId: number) => Promise<void>,
    updateOcorrencia: (aOcorrencia: Ocorrencia, idStatus: number) => Promise<void>
  }) {

  const [openModal, setOpenModal] = useState(false);
  const [type, setType] = useState<"DELETE" | "PUT">("PUT")
  const [statusValue, setStatusValue] = useState(1);

  const [status, setStatus] = React.useState('');

  function handleCloseModal() {
    setOpenModal(false)
  }

  function handleOpenModal(type: "DELETE" | "PUT") {
    setType(type);
    setOpenModal(true)
  }
  const handleChange = (event: SelectChangeEvent) => {
    setStatus(event.target.value as string);
    setStatusValue(Number(event.target.value));
  };



  return (
    <React.Fragment>
      <CardContent>
        <Accordion elevation={0}>
          <AccordionSummary
            aria-controls="panel1a-content"
            id="panel1a-header"
          >
            <Stack width={1} gap={1}>
              <Stack direction="row" justifyContent={"space-between"}>
                <Typography>{ocor.tipoProblema}</Typography>
                {ocor.urgencia === 1 ? <Typography textAlign="right"><strong>URGENTE</strong></Typography> : null}
              </Stack>
              <Divider />
              <Stack direction="row" justifyContent={"space-between"}>
                <Typography variant="body2">{ocor.status}</Typography>
                <Typography variant="body2">Abertura: {(new Date(Date.parse(ocor.datainicial))).toLocaleDateString()}</Typography>
              </Stack>
              <Stack direction="row" justifyContent={"space-between"}>
                <Typography>Bairro: {ocor.endereco.bairro}</Typography>
                <Typography>Apoiadores: {ocor.qntapoio}</Typography>
              </Stack>
            </Stack>
          </AccordionSummary>
          <AccordionDetails>
            <Divider />
            <Typography sx={{ mt: 2 }}>
              Descrição do problema: {ocor.descricao}
            </Typography>
          </AccordionDetails>
        </Accordion>
      </CardContent>
      <CardActions>
        <Stack p={1} width={1} direction="row" justifyContent={"flex-end"}>
          <Button onClick={() => {
            handleOpenModal("PUT")
          }} size="small">Alterar situação</Button>
          {/* <Button onClick={() => {
            handleOpenModal("DELETE")
          }} size="small">Excluir</Button> */}
        </Stack>
        <Modal
          open={openModal}
          onClose={handleCloseModal}
        >
          <Box sx={style}>

            {type === "DELETE" ? <>
              {/* <Typography textAlign={"center"} id="modal-modal-title" fontWeight={600} component="h2">
                Tem certeza que deseja excluir a ocorrência?
              </Typography>
              <Typography mb={6} textAlign={"center"} id="modal-modal-title" variant="body2">
                Esta operação não pode ser revertida
              </Typography>
              <Stack direction="row" justifyContent="space-evenly">
                <Button onClick={() => { deleteOcorrencia(ocor.id) }} variant="contained" color="error">SIM</Button>
                <Button onClick={handleCloseModal} variant="contained">CANCELAR</Button>
              </Stack> */}
            </> :
              <>
                <Stack gap={4}>
                  <Typography textAlign="center" variant='h6'>Selecione o status para alteração</Typography>
                  <FormControl fullWidth>
                    <InputLabel id="demo-simple-select-label">Status</InputLabel>
                    <Select
                      labelId="demo-simple-select-label"
                      id="demo-simple-select"
                      value={status}
                      label="Age"
                      onChange={handleChange}
                    >
                      <MenuItem value={1}>Aguardanto Atendimento</MenuItem>
                      <MenuItem value={2}>Em Atendimento</MenuItem>
                      <MenuItem value={3}>Finalizado</MenuItem>
                    </Select>
                  </FormControl>
                  <Stack direction="row" justifyContent="space-evenly">
                    <Button onClick={() => {
                      updateOcorrencia(ocor, statusValue)
                      handleCloseModal()
                    }} variant="contained">Alterar</Button>
                    <Button onClick={handleCloseModal} variant="outlined">CANCELAR</Button>
                  </Stack>
                </Stack>
              </>}
          </Box>
        </Modal>
      </CardActions>
    </React.Fragment>
  )
}

export const Ocorrencias = () => {
  const [ocorrencias, setOcorrencias] = useState<Ocorrencia[] | []>([]);
  const auth = useCallback(() => {
    useContext(AuthContext)
  }, []);

  const deleteOcorrencia = useCallback(async (aId: number) => {
    const token = localStorage.getItem('auth-token');
    if (!token) return;
    const response = await fetchServer(OCORRENCIAS_URL + '/' + aId.toString(), { token: token, method: "DELETE" });
    if (response == null) return
    if (!response.ok) return
    if (response.status !== 204) return
    alert("Ocorrência excluída com sucesso.");
    const newArray = (ocorrencias as Ocorrencia[]).reduce((acc: any, cur) => {
      if (cur.id !== aId) acc.push(cur);
    }, [])
    setOcorrencias(newArray);
  }, []);

  const handleUpdateOcorrencia = async (aOcorrencia: Ocorrencia, idStatus: number) => {
    const token = localStorage.getItem('auth-token');
    if (!token) return;
    const response = await fetchServer(OCORRENCIAS_URL, { token: token, method: "PUT" }, {
      "id": aOcorrencia.id,
      "idstatus": idStatus,
      "qtdapoio": aOcorrencia.qntapoio
    });
    if (response == null) return
    if (!response.ok) return
    if (response.status !== 200) return
    alert("Ocorrência atualizada com sucesso.");
    const newArray = (ocorrencias as Ocorrencia[]).reduce((acc: any, cur) => {
      if (cur.id === aOcorrencia.id) {
        let status = "Aguardando Atendimento";
        if (idStatus === 2) status = "Em Atendimento";
        if (idStatus === 3) status = "Finalizado";
        acc.push({ ...aOcorrencia, status: status.toUpperCase() })
      } else {
        acc.push(aOcorrencia)
      }
      return acc;
    }, [])
    console.log(newArray)
    setOcorrencias(newArray);
  };

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

  return (
    <>
      <Container sx={{ minHeight: "100vh", display: "grid", placeItems: "center" }}>
        <Box component="main" pt={3} pb={6}>
          <Paper sx={{ width: "800px", minHeight: "600px" }}>
            <Stack minHeight={"600px"} direction={"row"}>
              <Menu />
              <Stack justifyContent={"space-between"} p={3} width={"70%"}>
                <Box>
                  <Typography variant="h6" textAlign={"center"}>Ocorrências</Typography>
                  {/* <Stack mt={1} p={2}>
                    {ocorrenciasBairro.map(elem => <Typography textAlign={"center"}>{elem.bairro}: {elem.qtd}</Typography>)}
                  </Stack> */}
                  {ocorrencias.map(ocorrencia =>
                    <Card key={ocorrencia.id} sx={ocorrencia.urgencia === 1 ? { margin: 1, borderColor: "#c83d3d" } : { margin: 1 }} variant="outlined">
                      {<CardContant ocor={ocorrencia} deleteOcorrencia={deleteOcorrencia} updateOcorrencia={handleUpdateOcorrencia} />}
                    </Card>
                  )}
                </Box>
                {/* <Box>
                  <Typography textAlign={"center"}>Total de ocorrências: {ocorrenciasBairro.length}</Typography>
                </Box> */}

              </Stack>
            </Stack>
          </Paper>
        </Box>
      </Container>
    </>
  )
}