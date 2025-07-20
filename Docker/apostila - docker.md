# Conceitos Fundamentais do Docker

O Docker usa um esquema de **camadas (layers)**, e para montar essas camadas são usadas técnicas de **Copy-On-Write**.  
Um **container** é basicamente uma **pilha de camadas** compostas por **N camadas read-only** e **uma camada superior read-write**.

<h2 style="text-align:center";>Definição oficial</h2>

Containers Docker empacotam componentes de software em um sistema de arquivos completo, que contêm tudo necessário para a execução: código, runtime, ferramentas de sistema - qualquer coisa que possa ser instalada em um servidor. Isto garante que o software sempre irá executar da mesma forma, independente do seu ambiente.

## Containers

Containers são bem similares às máquinas virtuais, porém **mais leves** e mais **integrados ao sistema operacional da máquina host**. Eles compartilham o **kernel do host**, o que proporciona **melhor desempenho**, graças ao gerenciamento único dos recursos e ao **isolamento das imagens**.

 Um container normalmente roda com o máximo de isolamento possível do host, este isolamento é 11possível através do Docker Engine e diversas características provídas pelo kernel.
 Mas normalmente não queremos um isolamento total, e sim um **isolamento controlado**, em que os recursos que o container terá acesso são explicitamente indicados.
 
**Principais recursos de controle do isolamento:**

   - Mapeamento de portas
   - Mapeamento de volumes
   - Copia de arquivos para o container ou a partir do container
   - Comunicação entre os containers


### Diferenças entre container e imagem

Utilizando uma analogia com `POO`, podemos comparar um container a um objeto (instância), enquanto a imagem seria uma classe (modelo).


### [Docker Registry](https://docs.docker.com/registry/)

É uma aplicação *server-side* para guardar e distribuir imagens Docker.

### [Docker Hub](https://hub.docker.com/)

É um serviço de registro de imagens Docker em nuvem, que permite a associação com repositórios para **build automatizado** de imagens. Imagens marcadas como **oficiais** no Docker Hub são criadas pela própria **Docker Inc.**


---

<h1 style="text-aling:center";> Comandos - Docker</h1>

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

4. `docker exec -it <nome-ou-id> bash`  || `docker container exec -it <nome-container ou id> /bin/bash` || `docker exec -it <id> /bin/sh`
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

Processo para gerar uma nova imagem a partir de um arquivo de instruções. O comando docker build é o responsável por ler um Dockerfile e produzir uma nova imagem Docker.


📄 [Documentação do Dockerfile](https://docs.docker.com/engine/reference/builder)

1. `docker images`  
   → Lista todas as imagens Docker disponíveis localmente.

2. `docker build -t minha-imagem .`  
   → Cria uma imagem chamada `minha-imagem` com base no `Dockerfile` da pasta atual.

3. `docker rmi <nome-ou-id>`  
   → Remove uma imagem Docker.

### Dockerfile

Nome *default* para o arquivo com instruções para o **build** de imagens Docker.

---

## 📦 O que são Volumes no Docker?

Volumes são a forma recomendada pelo Docker para armazenar dados persistentes. Eles são armazenados fora do sistema de arquivos interno do contêiner e **não são apagados quando o contêiner é removido.**

## Por que usar Volumes?

- Persistência de dados entre execuções do contêiner

- Separação de dados e aplicação

- Permite que múltiplos contêineres compartilhem os mesmos dados

- Evita perda de dados ao remover ou atualizar contêineres

- Permite backup/restauração com facilidade

### Tipos de montagem

| Tipo           | Exemplo                          | Descrição                               |
| -------------- | -------------------------------- | --------------------------------------- |
| **Volume**     | `-v volume-nome:/app/dados`      | Armazenamento gerenciado pelo Docker    |
| **Bind Mount** | `-v /caminho/no/host:/app/dados` | Usa um caminho fixo do host             |
| **Tmpfs**      | `--tmpfs /app/dados`             | Armazenamento temporário na RAM (Linux) |

## ✅ Comandos principais

1. `docker volume create meu-volume`
   → Criar um volume
2. `docker volume ls`
   → Listar volumes
3. `docker volume inspect <meu-volume>`
   → Inspecionar volume
4. `docker run -d -v meu-volume:/dados ubuntu`
   → Usar um volume ao rodar um contêiner
5. `docker volume rm meu-volume`
   → Remover um volume
6. `docker volume prune`
   → Apagar todos os volumes não utilizados
---
