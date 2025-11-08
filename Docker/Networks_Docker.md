## Networks no Docker
 - Uma forma de gerenciar a conexão com Docker com outras plataformas ou até mesmo entre containers
 - As redes ou networks são criadas separadas do containers, como os volumes

Os container costuma ter três principais tipos de comunicação:

| Tipo                 | Descrição                               |
| -------------------- | --------------------------------------- |
| **Externa**          | Conexão com uma API de um servidor remoto |
| **Com o host**       | Conexão com uma máquina que está executando o docker |
| **Entre containers** | Comunicação oque utiliza o driver bridge e permite a comunicação entre dois containers |

Tipos de rede (drivers)

|  Rede  |  Descrição  | 
|--------|-------------|
| **Bridge**  | o mais comum e default do Docker, utilizado quando containers precisam se conectar|
| **host**    | permite a conexão entre um container a máquina que está hosteando o Docker|
| **macvian** | permite a conexão a um container por um MAC address|
| **none**    | remove todas conexões de rede de um container|
| **plugins** | permite extensões de terceiros para criar outras redes|

Comandos

1. `docker netword ls`
