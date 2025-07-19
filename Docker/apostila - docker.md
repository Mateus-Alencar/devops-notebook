# Conceitos Fundamentais do Docker

O Docker usa um esquema de **camadas (layers)**, e para montar essas camadas são usadas técnicas de **Copy-On-Write**.  
Um **container** é basicamente uma **pilha de camadas** compostas por **N camadas read-only** e **uma camada superior read-write**.

## Containers

Containers são bem similares às máquinas virtuais, porém **mais leves** e mais **integrados ao sistema operacional da máquina host**.  
Eles compartilham o **kernel do host**, o que proporciona **melhor desempenho**, graças ao gerenciamento único dos recursos e ao **isolamento das imagens**.

---

# Comandos - Docker

## Docker

1. `docker pull ubuntu`  
   → Baixa a imagem oficial do Ubuntu do Docker Hub.

2. `apt-get update && apt-get install -y stress`  
   → Atualiza o sistema e instala o pacote `stress`.

3. `stress --cpu 1 --vm 1 --vm-bytes 64M`  
   → Executa um teste de estresse utilizando CPU e memória.

4. `docker container run -ti --mount type=bind,source=/home/mateus/giropops,target=/giropops debian`
   → `-ti`: abre o terminal interativo
   → `--mount`: monta diretório do host do container
      → `type=bind`: tipo de montagem
      → `source=/home/mateus/giropops`: caminho do host
      → `target=/giropops`: onde aparecerá dentro do container

---

## 📦 Containers

1. `docker ps`  
   → Lista todos os contêineres em execução. (igual a `docker container ls`)

2. `docker ps -a`  
   → Lista todos os contêineres, inclusive os parados. (igual a `docker container ls -a`)

3. `docker run -it ubuntu bash`  
   → Cria e executa um contêiner Ubuntu com um terminal interativo (bash).

4. `docker exec -it <nome-ou-id> bash`  
   → Abre um terminal dentro de um contêiner já em execução.

5. `docker stop <nome-ou-id>`  
   → Para um contêiner em execução.

6. `docker rm <nome-ou-id>`  
   → Remove um contêiner parado.

7. `docker logs <nome-ou-id>`  
   → Mostra os logs de um contêiner.

8. `docker container stats`  
   → Exibe estatísticas em tempo real de uso dos contêineres ativos (CPU, memória, rede, disco).

---

## 📁 Imagens

1. `docker images`  
   → Lista todas as imagens Docker disponíveis localmente.

2. `docker build -t minha-imagem .`  
   → Cria uma imagem chamada `minha-imagem` com base no `Dockerfile` da pasta atual.

3. `docker rmi <nome-ou-id>`  
   → Remove uma imagem Docker.

---
