 ## Sumário

- [Conceitos Fundamentais do Docker](#conceitos-fundamentais-do-docker)
- [Containers](#containers)
- [Dockerfile](#dockerfile)
- [Docker Registry](#docker-registry)
- [Docker Hub](#docker-hub)
- [Comandos - Docker](#comandos---docker)
- [Volumes](#o-que-são-volumes-no-docker)
- [Docker Compose](#docker-compose)

# Conceitos Fundamentais do Docker 🐳

O Docker usa um esquema de **camadas (layers)**, e para montar essas camadas são usadas técnicas de **Copy-On-Write**, que evitam duplicação desnecessária de dados ao compartilhar camadas entre containers.
Um **container** é basicamente uma **pilha de camadas** compostas por **N camadas read-only** e **uma camada superior read-write**.

### Definição oficial

Containers Docker empacotam componentes de software em um sistema de arquivos completo, que contêm tudo necessário para a execução: código, runtime, ferramentas de sistema - qualquer coisa que possa ser instalada em um servidor. Isto garante que o software sempre irá executar da mesma forma, independente do seu ambiente.

### Diferenças entre container e VM:

| Característica      | Container                   | Máquina Virtual                     |
|---------------------|-----------------------------|------------------------------------ |
| Isolamento          | Compartilha kernel          | Kernel próprio                      |
| Desempenho          | Leve, inicia em segundos    | Mais pesada, pode demorar minutos   |
| Imagem base         | Menor                       | Maior                               |
| Gerenciamento       | Docker Engine               | Hypervisor (Ex: VirtualBox, VMWare) |

## Containers

Containers são similares às máquinas virtuais, porém **mais leves** e mais **integrados ao sistema operacional da máquina host**. Eles compartilham o **kernel do host**, o que proporciona **melhor desempenho**, graças ao gerenciamento único dos recursos e ao **isolamento das imagens**.

Um container normalmente roda com o máximo de isolamento possível do host, sendo esse isolamento viabilizado pelo Docker Engine e recursos do kernel Linux.
Mas normalmente não queremos um isolamento total, e sim um **isolamento controlado**, em que os recursos que o container terá acesso são explicitamente indicados.

**Principais recursos de controle do isolamento:**

- Mapeamento de portas
- Mapeamento de volumes
- Cópia de arquivos para o container ou a partir do container
- Comunicação entre os containers

### Diferenças entre container e imagem

Utilizando uma analogia com `POO`, podemos comparar um container a um objeto (instância), enquanto a imagem seria uma classe (modelo).

#### [Docker Registry](https://docs.docker.com/registry/)

É uma aplicação *server-side* para guardar e distribuir imagens Docker.

#### [Docker Hub](https://hub.docker.com/)

É um serviço de registro de imagens Docker em nuvem, que permite a associação com repositórios para **build automatizado** de imagens. Imagens marcadas como **oficiais** no Docker Hub são criadas pela própria **Docker Inc.**

---

# Comandos - Docker

## Docker

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

7. `docker rm <nome-ou-id> -f`
   → Remove um contêiner em execução.

8. `docker logs <nome-ou-id>`  
   → Mostra os logs de um contêiner.

9. `docker container stats`  
   → Exibe estatísticas em tempo real de uso dos contêineres ativos (CPU, memória, rede, disco).

10. `docker run --rm nome-da-imagem`
   → O parâmetro --rm no Docker remove automaticamente o container assim que ele for parado.

11. `docker top <nome-ou-id>`
   → Verificar processamento do container

12. `docker inspect <nome-da-imagem>`
   → Inspeciona as caracteristicas e configurações do container ou da imagem

13. `docker stats`
   → é usado para monitorar o uso de recursos dos containers em tempo real.

14. `docker logount` e `docker login`
   → Servem para gerenciar a autenticação com registros de imagens Docker, como o Docker Hub, GitHub Container Registry e AWS ECR
   
15. `docker pull`
   → O comando docker pull serve para baixar (fazer o download) de uma imagem de container de um registro (como o Docker Hub) para a minha máquina local.
   
### 📦 Containers

1. `docker pull ubuntu`  
   → Baixa a imagem oficial do Ubuntu do Docker Hub.

2. `apt-get update && apt-get install -y stress`  
   → Atualiza o sistema e instala o pacote `stress`.

3. `stress --cpu 1 --vm 1 --vm-bytes 64M`  
   → Executa um teste de estresse utilizando CPU e memória.

4. `docker container run -ti --mount type=bind,source=/home/mateus/giropops,target=/giropops debian`   
   → `-ti`: abre o terminal interativo  
   → `--mount`: monta diretório do host no container  
   → `type=bind`: tipo de montagem  
   → `source=/home/mateus/giropops`: caminho do host  
   → `target=/giropops`: onde aparecerá dentro do container

   O `--mount` no Docker serve para ligar um diretório (ou volume) do host ao contêiner, permitindo que os dados sejam compartilhados entre o sistema do host e o contêiner. Isso é essencial para persistência de dados


#### 🔍 Tipos de `mount`

`docker run --mount type=<tipo>,source=<origem>,target=<destino> <imagem>`

| Tipo          | Descrição                                                               |   
|---------------|-------------------------------------------------------------------------|
| `bind`        | Liga um caminho real do host a um diretório no contêiner.               |
| `volume`      | Usa um volume Docker (gerenciado automaticamente).                      |
| `tmpfs`       | Cria um sistema de arquivos temporário (RAM), útil para dados voláteis. |
---

 5. `docker run -d -p 80:80 nginx`
   → `docker run`: Cria e inicia um novo container
   → `-d`: significa *detached mode (modo destacado)*, isso faz com que o container rode em segundo plano.
   → `-p 80:80`: mapeamento de portas
   → `nginx`: nome da imagem


---

## 📁 Imagens

Imagens *são originadas de arquivos que programamos* para que o Docker crie uma estrutura que execute determinadas ações em containers.

```
Ao rodar um container baseado na imagem, as instruções serão executadas em camadas.
```

O comando `docker build` é responsável por ler um Dockerfile e produzir uma nova imagem Docker.

> 📄 [Documentação do Dockerfile](https://docs.docker.com/engine/reference/builder)

1. `docker images`  
   → Lista todas as imagens Docker disponíveis localmente.

2. `docker build -t minha-imagem .`  
   → Cria uma imagem chamada `minha-imagem` com base no `Dockerfile` da pasta atual.

3. `docker rmi <nome-ou-id>`  
   → Remove uma imagem Docker.

4. `docker image inspect <nome-imagem>`  
   → Ver detalhes da imagem
5. `docker tag httpd:2.4 meuusuario/apache-custom:meu-projeto`
   → `docker tag`: comando apra renomear (retag) uma image
   → `httpd:2.4`: nome da imagem original que foi baixada
   → `meuusuario/apache-custom:meu-projeto`: novo nome (com namespace) e tag que eu irei dar a imagem.

## Dockerfile

Nome *default* para o arquivo com instruções para o **build** de imagens Docker.

### Exemplos básicos de Dockerfiles

```Dockerfile
# Imagem base
FROM python:3.11
# Define diretório de trabalho
WORKDIR /app
# Copia os arquivos da aplicação
COPY . .
# Instala dependências
RUN pip install -r requirements.txt
# Comando padrão ao iniciar container
CMD ["python", "app.py"]
```

```Dockerfile
FROM node:20
WORKDIR /app
COPY . .
RUN npm install
CMD ["npm", "start"]
```

**Principais comandos:**

| Comando      | Descrição                                               |
|--------------|---------------------------------------------------------|
| `FROM`       | Define a imagem base do container.                      |
| `COPY`       | Copia um arquivo do filesystem local para o container.  |
| `RUN`        | Executa um ou mais comandos no container.               |
| `WORKDIR`    | Define o diret´orio de execu¸c˜ao atual.                |
| `USER`       | Define o usu´ario executar´a os processos do container. |
| `ENTRYPOINT` | Define o processo principal do container.               |


#### Renomeação de uma imagem Docker

No Docker, renomear uma imagem significa dar a ela um novo nome (tag), sem modificar seu conteúdo. Isso é útil para:
 - Organizar suas imagens localmente;
 - Subir para registries com nomes específicos;
 - Versão de imagens;
 - Trocar o repositório/namespace;

 `docker tag <imagem_original> <novo_nome>`
 
--- 

## 📦 O que são Volumes no Docker?

Volumes são a forma recomendada pelo Docker para armazenar dados persistentes. Eles são armazenados fora do sistema de arquivos interno do contêiner e **não são apagados quando o contêiner é removido.**

### Por que usar Volumes?

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

### ✅ Comandos principais

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

7. `docker run -v volume:/data:ro`
   → Criação de um volume que tem apenas permissão de leitura.
   → `:ro` : é a abreviação de only
---

## Networks no Docker

 - Uma forma de gerenciar a conexão com Docker com outras plataformas ou até mesmo entre containers
 - As redes ou networks são criadas separadas do containers, como os volumes

Os container costuma ter três principais tipos de comunicação:

| Tipo                 | Descrição                               |
| -------------------- | --------------------------------------- |
| **Externa**          | Conexão com uma API de um servidor remoto |
| **Com o host**       | Conexão com uma máquina que está executando o docker |
| **Entre containers** | Comunicação oque utiliza o driver bridge e permite a comunicação entre dois containers |

Tipos de rede (drivers):

|  Rede  |  Descrição  | 
|--------|-------------|
| **Bridge**  | o mais comum e default do Docker, utilizado quando ocntainers precisam se conectar|
| **host**    | permite a conexão entre um container a máquina que está hosteando o Docker|
| **macvian** | permite a conexão a um container por um MAC address|
| **none**    | remove todas conexões de rede de um container|
| **plugins** | permite extensões de terceiros para criar outras redes|

Comandos

1. `docker netword ls`
   → Listar todas as redes do docker
2. `network create <nome-da-rede>`
   → Comando para criar uma rede
   > `docker network create -d macvlan meu_macvlan`
   `-d` determina o tipo de rede
3. `docker network rm <nome-da-rede>`
   → Remove a rede indicada.
4. `docker network inspect minha_red`
   → Inspeciona a rede.
5. `docker network connect minha_rede meu_container`
   → Conectar container a uma rede
6. `Desconectar container de uma rede`
   → docker network disconnect minha_rede meu_container
---
## Docker Compose

Docker Compose permite definir e executar multi-containers com um único arquivo YAML (`docker-compose.yml`).