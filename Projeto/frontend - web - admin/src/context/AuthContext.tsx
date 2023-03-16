import { ReactNode, createContext, useLayoutEffect, useMemo, useState } from "react";

interface TUser {
  id: number,
  tipousuario: string,
  nome: string,
  telefone: string,
  bairro: string,
  email: string,
  cpf: string,
  senha: string
}

export const AuthContext = createContext({
  isAuth: false,
  // user: {},
  makeLogin: (token: string) => {},
  logout: () => {},
});

export function AuthContextProvider({ children }: { children: ReactNode }) {
  const [isAuth, setIsAuth] = useState(false);

  const checkAuth = (hash: string) => {
    if (hash === "null") return { isValid: false };
    const { isValid } = { isValid: true }; //fetch servidor;
    return { isValid: isValid };
  };

  const auth = useMemo(
    () => ({
      isAuth: isAuth,
      makeLogin: (token: string) => {
        setIsAuth(true);
        localStorage.setItem("auth-token", token);
      },
      logout: () => {
        setIsAuth(false);
        localStorage.setItem("auth-token", "");
      },
    }),
    [isAuth]
  );

  useLayoutEffect(() => {
    const localToken = String(localStorage.getItem("auth-token"));
    if (localToken) {
      const { isValid } = checkAuth(localToken);
      isValid ? setIsAuth(true) : setIsAuth(false);
    }
  }, []);

  return <AuthContext.Provider value={auth}>{children}</AuthContext.Provider>;
}
