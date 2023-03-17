<div align="center"> 

# DEVS-SQUAD

<p align="center">
<img src="https://img.shields.io/badge/STATUS:-EM%20DESENVOLVIMENTO-green" alt="Status: Em Desenvolvimento"> 
</p>
</div> 

</br>
<h3 align="center" >

Projeto desenvolvido para o Hackweek +Devs2Blu com um sistema que ajuda o cidadão a notificar, apoiar e acompanhar ocorrências de problemas de manutenção em vias públicas.

</h3>
</br>


## Desafio Proposto

</br>

**_Como um cidadão pode ajudar na zeladoria pública de sua cidade?_**

</br>

Ao analisarmos o desafio proposto, nos reunimos para entender como poderíamos, por meio da tecnologia, facilitar o acesso do cidadão que deseja participar e contribuir com a zeladoria pública.

Após uma análise inicial, constatamos que existem diversas formas de o cidadão se comunicar por meio de canais de ouvidorias existentes. No entanto, nos perguntamos sobre o por que poucas pessoas utilizam esses canais. A resposta que encontramos é que falta acesso rápido a informações relacionadas à manutenção e se há algum planejamento ou ação para resolver os problemas encontrados, como também, uma forma mais rápida do cidadão informar problemas que ele encontra.

Por meio das informações coletadas nas mentorias e em rápidas pesquisas, constatamos que, mesmo que haja alguma transparência, a dificuldade de receber essas informações ou comunicar problemas desestimula o cidadão comum a participar e contribuir com a zeladoria pública.

</br>

## Solução

<p align="center"> <img src="https://github.com/MuriloBatista/devs-squad/blob/main/Documenta%C3%A7%C3%B5es/1%20-%20Mockup/LogoSEC.png?raw=true" alt="Serviço Escuta Cidadão" width="500" height="300"/> </p>

Nosso grupo apresenta como solução o sistema **SEC - Serviço Escuta Cidadão**. Trata-se de uma ferramenta que pretende diminuir o tempo que o cidadão leva para informar problemas, acompanhar problemas informados por outros contribuintes e receber atualizações sobre as ações tomadas pelos gestores. Dessa forma, o cidadão é estimulado por meio da transparência e acesso rápido a informações a participar da zeladoria da sua cidade, trazendo benefícios também para os gestores saberem sobre as demandas e necessidades do cidadão.

</br>

<a href="https://www.figma.com/file/s8CxDTwudeXFRkV018MZti/Untitled?node-id=0%3A1" target="_blank" rel="noopener noreferrer">Clique aqui</a> para acessar o _protótipo_.

</br>

### 1. Diagrama Caso de Uso

</br>

<p align="center"> <img src="https://github.com/MuriloBatista/devs-squad/blob/main/Documenta%C3%A7%C3%B5es/3%20-%20Arquitetura%20da%20Aplica%C3%A7%C3%A3o/Diagrama%20-%20UML/Diagrama%20Caso%20de%20Uso.png?raw=true" alt="Caso de Uso" width="800" height="600"/> </p>

</br>

### 2. Papéis

</br>

A aplicação **_SEC - Serviço Escuta Cidadão_** conta com dois principais papéis: Usuários e Administradores.

**Usuários:** Papel responsável por realizar abertura de ocorrências e visualizar ocorrências abertas por outros usuários sendo possivel apoiar essas ocorrências.

**Administradores:** Papel responsável por administrar o fluxo de ocorrências e por controlar e dar visibilidade aos usuários sobre o status das ocorrências criadas.

</br>

### 3. Ações

</br>

#### 3.1. Ações do Usuário

</br>

**Criar conta:** Ação responsável por criar uma conta de Usuário.
 
**Abertura de Ocorrência:** Ação responsável por criar uma ocorrência, sendo possivel informar o tipo de problema e a localização que o problema se encontra.

**Visualizar Ocorrências:** Ação responsável por visualizar ocorrências criadas por outros usuários.

**Apoiar Ocorrência:** Ação reponsável por apoiar uma ocorrência criada por outro usuário, modificando a prioridade ranqueando a ocorrência pela quantidade de apoios.

</br> 

#### 3.2. Ações do Administrador

</br>

**Criar Conta:** Ação responsável por criar uma conta. No caso do administrador, o mesmo pode excluir uma conta caso as diretrizes de uso sejam violadas pelo usuário.

**Visualizar Ocorrências:** Ação responsável por visualizar ocorrencias criadas pelos usuários, trazendo visibilidade sobre qual ocorrência o administrador deve priorizar.

**Modificar Status Ocorrências:** Ação responsável por modificar o status de uma ocorrência, trazendo transparência ao usuário sobre o tratamento da ocorrência gerada.

</br>

## Tecnologias Utilizadas
</br>

<p align="center">
 <img src="https://cdn-icons-png.flaticon.com/512/5968/5968252.png" alt="delphi" width="80" height="80"/>
 <img src="https://upload.wikimedia.org/wikipedia/en/c/cb/FireMonkeyLogo.svg" alt="firemonkey" width="80" height="80"/>
 <img src="https://avatars.githubusercontent.com/u/32908721?s=280&v=4" alt="hashload" width="80" height="80"/>
 <img src="https://github.com/skia4delphi/skia4delphi/raw/main/Assets/Artwork/logo-gradient.svg" alt="skia" width="80 height="80"/>
 <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/mysql/mysql-original-wordmark.svg" alt="mysql" width="80" height="80"/>
 <img src="https://www.svgrepo.com/download/354202/postman-icon.svg" alt="postman" width="80 height="80"/> 
 <img src="https://www.vectorlogo.zone/logos/figma/figma-icon.svg" alt="figma" width="80" height="80"/>
 <img src="https://is2-ssl.mzstatic.com/image/thumb/Purple116/v4/3b/cc/0c/3bcc0cb0-e973-2aff-27ee-ec93ed761232/AppIcon-1x_U007emarketing-0-7-0-85-220.png/230x0w.webp" alt="trello" width="80" height="80"/>
 <img src="https://upload.wikimedia.org/wikipedia/commons/a/ab/Swagger-logo.png" alt="swagger" width="80" height="80"/>
<img src="https://images.g2crowd.com/uploads/product/image/large_detail/large_detail_f0b606abb6d19089febc9faeeba5bc05/nodejs-development-services.png" alt="nodejs" width="80" height="80"/>
<img src="https://gitlab.com/uploads/-/system/project/avatar/31182514/logo-react-icon.png" alt="react" width="80" height="80"/>
<img src="https://bognarjunior.files.wordpress.com/2018/09/typescript.png" alt="typescript" width="80" height="80"/>
<img src="https://v4.mui.com/static/logo.png" alt="material ui" width="80" height="80"/>
</p> 

</br>

 - RAD Studio Delphi 10.4 Community Edition - IDE de Desenvolvimento.
 - FireMonkey - Framework de Desenvolvimento Aplicações Multiplataforma.
 - Horse Hashload - Framework API REST.
 - SKIA for Delphi - Framework Gráfico.
 - MySQL - Banco de Dados.
 - Postman - Ferramenta para Teste de API.
 - Figma - Ferramenta para criação dos Protótipos.
 - Trello - Ferramenta de Gerenciamento de Projeto.
 - GBSwagger - Middleware para gerar o Swagger Document.
 - Node.JS - Para desenvolvimento da versão admin web.
 - React JS - Biblioteca de renderização web.
 - Typescript - Superset de tipagem para javascript.
 - Material UI - Biblioteca de componentes estilizados para React.
 
 </br>

 ## Modo de uso

 Para utilização recomenda-se a leitura da documentação técnica localizada na pasta Projeto.

 ----
 
 ## Equipe
 
 <div align="left">
<img src="https://github.com/MuriloBatista/devs-squad/blob/main/Documenta%C3%A7%C3%B5es/1%20-%20Mockup/DEvs.png?raw=true" width="300" height="300" >
</div>
 


|Integrante|Repositório|Contato|Foto|
|:-|:-:|:-:|:-:|
|Guilherme Hillesheim|[Github](https://github.com/GuilhermeHSilva1)|[LinkedIn](https://www.linkedin.com/in/guilherme-hillesheim-bb5064224/)|<img src="https://github.com/GuilhermeHSilva1.png" height="100"></img>|
|Jean Carlos Möller|[Github](https://github.com/JeanCarlosMoller)|[LinkedIn](https://www.linkedin.com/in/jeancarlosmoller/)|<img src="https://github.com/JeanCarlosMoller.png" height="100"></img>|
|Jean Jefferson Oliveira|[Github](https://github.com/Jeanjoliveira)|-|<img src="https://github.com/Jeanjoliveira.png" height="100"></img>|
|Jefferson Domareski|[Github](https://github.com/Jdomareski)|[LinkedIn](https://www.linkedin.com/in/jefferson-domareski-68801234/)|<img src="https://github.com/Jdomareski.png" height="100"></img>|
|Jieff Cavalcanti Neves|[Github](https://github.com/jieff)|[LinkedIn](https://www.linkedin.com/in/jieff/)|<img src="https://github.com/jieff.png" height="100"></img>|
|Maximiliano Furtado|[Github](https://github.com/maax103)|[LinkedIn](https://www.linkedin.com/in/maximiliano-furtado-905845155/)|<img src="https://github.com/maax103.png" height="100"></img>|
|Murilo Batista|[Github](https://github.com/MuriloBatista)|[LinkedIn](https://www.linkedin.com/in/mubasi/)|<img src="https://github.com/MuriloBatista.png" height="100"></img>|



