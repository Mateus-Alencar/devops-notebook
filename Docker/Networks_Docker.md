## Networks no Docker
 - Uma forma de gerenciar a conexão com Docker com outras plataformas ou até mesmo entre containers
 - As redes ou networks são criadas separadas do containers, como os volumes

Os container costuma ter três principais tipos de comunicação:

| Tipo                 | Descrição                               |
| -------------------- | --------------------------------------- |
| **Externa**          | Conexão com uma API de um servidor remoto |
| **Com o host**       | Conexão com uma máquina que está executando o docker |
| **Entre containers** | Comunicação que utiliza o driver **bridge** e permite a comunicação entre dois containers |

Tipos de rede (drivers)

|  Rede  |  Descrição  | 
|--------|-------------|
| **Bridge**  | o mais comum e default do Docker, utilizado quando containers precisam se conectar|
| **host**    | permite a conexão entre um container a máquina que está hosteando o Docker|
| **macvian** | permite a conexão a um container por um MAC address|
| **none**    | remove todas conexões de rede de um container|
| **plugins** | permite extensões de terceiros para criar outras redes|

### Comandos

1. `docker netword ls`
   → Listar todas as redes do docker
2. `network create <nome-da-rede>`
   → Comando para criar uma rede
3. `docker network create -d macvlan meu_macvlan`
   `-d` determina o tipo de rede
4. `docker network rm <nome-da-rede>`
   → Remove a rede indicada.
5. `docker network inspect minha_red`
   → Inspeciona a rede.
6. `docker network connect minha_rede meu_container`
   → Conectar container a uma rede
7. `Desconectar container de uma rede`
   → docker network disconnect minha_rede meu_container
