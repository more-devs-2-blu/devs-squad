import { CssBaseline } from "@mui/material"
import { createBrowserRouter, RouterProvider } from 'react-router-dom'
import { Home } from "./routes/Home"
import { AuthContextProvider } from "./context/AuthContext"
import { Admin } from "./routes/Admin"
import { Ocorrencias } from "./routes/Ocorrencias"

function App() {

  const router = createBrowserRouter([
    {
      path: '/',
      element: <Home />
    },
    {
      path: '/admin',
      element: <Admin />
    },
    {
      path: '/ocorrencias',
      element: <Ocorrencias />
    },
  ])

  return (
    <>
      <CssBaseline />
      <AuthContextProvider >
        <RouterProvider router={router} />
      </AuthContextProvider>
    </>
  )
}

export default App
