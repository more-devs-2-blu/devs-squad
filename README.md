# DEVS-SQUAD

<p align="center">
<img src="https://img.shields.io/badge/STATUS:-EM%20DESENVOLVIMENTO-green" alt="Status: Em Desenvolvimento"> 
</p>

### Grupo

<div align="left">
<img src="https://github.com/MuriloBatista/devs-squad/blob/main/Documenta%C3%A7%C3%B5es/1%20-%20Mockup/DEvs.png?raw=true" width="300" height="300" >
</div>

- [Guilherme Hillesheim](https://github.com/GuilhermeHSilva1)
- [Jean Carlos Möller](https://github.com/JeanCarlosMoller)
- [Jean Jefferson Oliveira](https://github.com)
- [Jefferson Domareski](https://github.com)
- [Jieff Cavalcanti Neves](https://github.com)
- [Max Furtado](https://github.com/maax103)
- [Murilo Batista](https://github.com/MuriloBatista)

_________________________
</br>
<h3 align="center" >

Projeto desenvolvido para o Hackweek +Devs2Blu com um sistema que ajuda o cidadão a notificar, apoiar e acompanhar ocorrências de problemas de manutenção em vias publicas.

</h3>
</br>


## Desafio Proposto: 

</br>

Como um cidadão pode ajudar na zeladoria pública de sua cidade?

Ao analisarmos o desafio proposto, reunimos-nos para entender como poderíamos, por meio da tecnologia, facilitar o acesso do cidadão que deseja participar e contribuir com a zeladoria pública.

Após uma análise inicial, constatamos que existem diversas formas de o cidadão se comunicar por meio de canais de ouvidorias existentes. No entanto, nos perguntamos sobre o por que poucas pessoas utilizam esses canais. A resposta que encontramos é que falta acesso rápido a informações relacionadas à manutenção e se há algum planejamento ou ação para resolver os problemas encontrados, como também, uma forma mais rápida do cidadão informar problemas que ele encontra.

Por meio das informações coletadas nas mentorias e em rápidas pesquisas, constatamos que, mesmo que haja alguma transparência, a dificuldade de receber essas informações ou comunicar problemas desestimula o cidadão comum a participar e contribuir com a zeladoria pública.

</br>

## Solução:

<p align="center"> <img src="https://github.com/MuriloBatista/devs-squad/blob/main/Documenta%C3%A7%C3%B5es/1%20-%20Mockup/LogoSEC.png?raw=true" alt="Serviço Escuta Cidadão" width="500" height="300"/> </p>

Nosso grupo apresenta como solução o sistema **SEC - Serviço Escuta Cidadão**. Trata-se de uma ferramenta que pretende diminuir o tempo que o cidadão leva para informar problemas, acompanhar problemas informados por outros contribuintes e receber atualizações sobre as ações tomadas pelos gestores. Dessa forma, o cidadão é estimulado por meio da transparência e acesso rápido a informações a participar da zeladoria da sua cidade, trazendo benefícios também para os gestores saberem sobre as demandas e necessidades do cidadão.

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

**Criar Conta:** Ação responsável por criar uma conta. No caso do administrado, o mesmo pode excluir uma conta caso as diretrizes de uso seja violada pelo usuário.

**Visualizar Ocorrências:** Ação responsável por visualizar ocorrencias criadas pelos usuários, trazendo visibilidade sobre qual ocorrência o administrador deve priorizar.

**Modificar Status Ocorrências:** Ação responsável por modificar o status de uma ocorrência, trazendo transparência ao usuário sobre o tratamento da ocorrência gerada.




