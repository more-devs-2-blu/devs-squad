import React, { useCallback, useContext, useState } from 'react'
import { Container, Paper, Stack, TextField, Box, Typography, Divider } from '@mui/material'
import Button from '@mui/lab/LoadingButton'
import sec_logo from '../assets/SEC.png'
import { useNavigate } from 'react-router-dom'
import { fetchServer, loginServer } from '../utils/serverUtils'
import { LOGIN_URL } from '../utils/urls'
import { AuthContext } from '../context/AuthContext'

export const Home = () => {
  const navigate = useNavigate();
  const auth = useContext(AuthContext);
  const [cpf, setCpf] = useState('');
  const [senha, setSenha] = useState('');
  const [loading, setLoading] = useState(false)
  const handleLogin = async () => {

    try {
      const response = await loginServer(LOGIN_URL, cpf, senha);
      const token = await response!.text();
      if (response!.status === 200) {
        setTimeout(() => {
          auth.makeLogin(token);
          navigate("/admin")
          setLoading(false);
        }, 2000)
      }

    } catch (err) {
      setTimeout(() => {
        setLoading(false);
        alert('Erro: ' + err)
      }, 2000)
    }
  }

  return (
    <>
      <Container sx={{ minHeight: "100vh", display: "grid", placeItems: "center" }}>
        <Box component="main" pt={1} pb={6}>
          <img src={sec_logo} alt="Logo" />
          <Paper elevation={2} sx={{ mt: 1, p: 6 }}>
            <Stack gap={2}>
              <Typography textAlign="center" variant='h5'>Módulo administrador</Typography>
              <Divider />
              <TextField value={cpf} onChange={(e: React.ChangeEvent<HTMLInputElement>) => { setCpf(e.target.value) }} sx={{ mt: 3 }} label="CPF" />
              <TextField value={senha} onChange={(e: React.ChangeEvent<HTMLInputElement>) => { setSenha(e.target.value) }} type={"password"} label="Senha" />
              <Button color={"warning"}
                loading={loading}
                sx={{ mt: 2 }}
                onClick={async () => {
                  setLoading(true);
                  await handleLogin()
                }}
                variant={"contained"}>Entrar</Button>
            </Stack>
          </Paper>
        </Box>
      </Container>
    </>
  )
}