import { Box, Button, Stack, Typography } from "@mui/material";
import { useContext } from "react";
import { useNavigate } from "react-router-dom";
import avatar from "../assets/avatar.png"
import { AuthContext } from "../context/AuthContext";

function Menu() {
  const navigate = useNavigate();
  const auth = useContext(AuthContext);
  return (
    <Stack minHeight={"100%"} p={2} bgcolor="#F6BF53" width={"30%"} gap={3}>
      <Typography fontWeight={"600"} mt={3} textAlign={"center"}>Módulo administrador</Typography>
      <Box display="flex" justifyContent={"center"} alignItems="center" mt={3}>
        <Box justifyContent={"center"} alignItems="center" height={100} width={100} borderRadius={50} display={"flex"} bgcolor={"white"}>
          <img src={avatar} alt="Icone de avatar" />
        </Box>
      </Box>
      <Button onClick={()=>{navigate('/admin')}} color='inherit'>Home</Button>
      <Button onClick={()=>{navigate('/ocorrencias')}} color='inherit'>Ocorrências</Button>
      <Button onClick={()=>{
        auth.logout();
        navigate('/');
      }} color='inherit'>Sair</Button>
    </Stack>
  )
}

export default Menu;