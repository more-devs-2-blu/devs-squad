
export const fetchServer = async (url: string, opts?: {
    token?: string | null,
    method?: string | 'GET'
}, body?: {}) => {
    const headers = new Headers();
    headers.append('Content-Type', 'application/json')
    headers.append('Authorization', `Bearer ${opts?.token}` || '')
    const fetchOpts: RequestInit = {
        method: opts?.method || "GET",
        mode: 'cors',
        cache: 'no-cache',
        credentials: 'same-origin',
        redirect: 'follow',
        referrerPolicy: 'no-referrer',
        headers: headers,
        body: JSON.stringify(body)
    }

    if (fetchOpts.method === "GET") delete fetchOpts.body
    try {
        const response = fetch(url, fetchOpts).then(res => {
            if (!res.ok){
                throw new Error('Não foi possível conectar ao servidor')
            }
            return res
        })
        return response
    } catch (err) {
        console.log(err)
        return null
    }
}

export const loginServer = async (url: string, cpf: string, senha: string) => {
    const headers = new Headers();
    headers.append('Content-Type', 'application/json')
    headers.append('Authorization', 'Basic ' + btoa(cpf + ":" + senha))
    const fetchOpts: RequestInit = {
        method: "POST",
        mode: 'cors',
        cache: 'no-cache',
        credentials: 'same-origin',
        redirect: 'follow',
        referrerPolicy: 'no-referrer',
        headers: headers,
        body: JSON.stringify({ cpf: "10140628967", senha: "123" })
    }

    try {
        const response = fetch(url, fetchOpts).then(res => {
            if (!res.ok) {
                throw res.statusText
            }
            return res;
        })
        return response
    } catch {
        return null
    }
}