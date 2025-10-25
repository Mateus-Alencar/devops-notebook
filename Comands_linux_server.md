## Sumário

- [Diferenças entre terminal e shell](#diferencas-entre-terminal-e-shell)
  - [Funcionamento do Shell Bash](#funcionamento-do-shell-bash)
- [Variáveis em Shell](#variaveis-em-shell)
  - [ Variaveis especiais do shell Linux](#variaveis-especiais-do-shell-linux)
- [Entendendo o Prompt do terminal linux](#entendendo-o-prompt-do-terminal-linux)
- [Estrutura de Diretórios Importantes](#estrutura-de-diretorios-importantes)
  - [Controle de bibliotecas compartilhadas](#controle-de-bibliotecas-compartilhadas)
- [Pacotes](#pacotes)
- [Gerenciamento de particoes](#gerenciamento-de-particoes)
- [Navegação e manipulação de arquivos](#navegacao-e-manipulacao-de-arquivos)
  - [QUOTING](#quoting)
- [Informações do sistema](#informacoes-do-sistema)
   - [TAIL](#tail)
- [Gerenciamento de usuários](#gerenciamento-de-usuarios)
- [Processos e serviços](#processos-e-servicos)
  - [Kill](#kill)
  - [NICE e RECEIVER](#nice-e-receiver)
  - [Execucao de processos em primeiro e segundo plano](#execucao-de-processos-em-primeiro-e-segundo-plano)
- [Rede](#rede)
- [Gerenciamento de pacotes (Debian/Ubuntu)](#gerenciamento-de-pacotes-debianubuntu)
- [Permissões e acesso](#permissoes-e-acesso)
- [Limpeza e manutenção](#limpeza-e-manutencao)
- [Atalhos úteis](#atalhos-uteis)
  - [Caracteres curinga no shell](#caracteres-curinga-no-shell)
- [Expressoes regulares](#expressoes-regulares)
  - [FIND](#find)
  - [GREP](#grep)
- [Vim](#vim)
- [Redirecionamento de Entrada, Saida e Errospadrao](#redirecionamento-de-entrada-saida-e-errospadrao)
  - [PIPE](#pipe)
- [Camadas da arquitetura do Linux](#camadas-da-arquitetura-do-linux)
  - [Inicializacao do sistema](#inicializacao-do-sistema)

# Comandos Essenciais do Terminal Linux (Servidor)

Este documento reúne os **principais comandos usados em servidores Linux**, com foco em administração, rede, manipulação de arquivos, processos e pacotes.

> Sintaxe padrão para comandos no Linux: COMANDO -OPCOES ARQUIVOS/DIRETORIOS
---
### Diferencas entre terminal e shell

Um terminal é a aplicação (geralmente gráfica) que fornece uma janela para interação com o sistema.
Ele funciona como uma interface (front-end) para o shell.

O shell, por sua vez, é o programa responsável por interpretar e executar os comandos do usuário, interagindo diretamente com o kernel do sistema operacional.

**Funcionamento do Shell Bash**
```
4 - Programas / Comandos
3 - SHELL — Interpretador de comandos / Bibliotecas
2 - Kernel
1 - Hardware
```
> Comando para verificar qual shell está disponível no sistema: **chsh -l** ou **cat /etc/shells**

Quando o shell bash é executado após o usuário fazer login no sistema o mesmo aguarda um ou mais comandos na entrada pardrão para interagir com o sistema, este comandos podem ser:

- **Internos (Builtins) -** Estes comandos fazem parte do interpretador de comandos bash, ou seja, estão imbutidos no bash, e quando são executados são lidos antes de qualquer outro comando externo. Exemplo: `cd`, `echo`, `exit`

- **Externos** Estes tipos de comandos são programas armazenados no HD e precisam ser chamados por linha de comando informando o caminho absoluto ou o diretório que o armazena pode está dentro da variável **PATH**. Exemplo: `/bin/ls`, `/usr/bin/grep`

> Para saber se o comando é externo ou interno(builtin) execute o  **comando type**, por exemplo.

---
### Variaveis em Shell
Quando falamos em variáveis em "shell" temos que ter em mente a divisão entre variáveis locais e de ambiente (ou globais). A diferença entre elas é que uma variável locla tem visibilidade restrita, apenas a sessão do shell onde ela foi definida, e uma variável de ambiente tem visibilidade não só na sessão do shell em que foi definida mas também em ambientes derivados, ou seja, subshells.

O comando **echo** é utilizado para exibir um texto ou conteúdo na tela, por exemplo para exibir o conteúdo de uma variável.
EX: `echo $PWD`
```
echo $HOME      # Diretório home do usuário
echo $PATH      # Caminhos de diretórios para buscar executáveis
echo $USER      # Nome do usuário logado
```
> 💡 Dica: Para ver o caminho dos diretórios onde o sistema busca executáveis, use echo $PATH.

" var " -> Consegue ler o conteúdo das variáveis
' var ' -> Não interpreta os valores das variáveis
```
 EX: echo "print de uma variável chamada UID: $ UID" --> nesse caso é realizado a leitura da variával 
     echo 'print de uma variável chamada UID: $ UID'
```
> Comoando para mostrar uma lista de todas as variaveis do shell:
`env`
`env | grep -i pwd`

#### Variaveis especiais do shell Linux

As variáveis especiais do shell Linux são definidas pelo próprio sistema e são usadas para armazenar informações como o ID do processo atual (`$$`), o número de argumentos em um script (`$#`), o status de saída do último comando (`$?`), o nome do próprio script (`$0`) e o diretório de trabalho atual (`$PWD`). Essas variáveis são cruciais para scripts e para o gerenciamento do ambiente do usuário.


|   Variável     | Descrição                   |
|----------------|--------------------------|
| `$0`          | O nome do script ou comando que está sendo executado.|
| `$#`          |	O número de argumentos passados para o script. | 
| `$@`          | Todos os argumentos da linha de comando como itens separados |
| `$*`          | Todos os argumentos da linha de comando como uma única string.   |
| `$?`          | O status de saída do último comando executado. 0 indica sucesso, enquanto um valor diferente de 0 indica erro. |
| `$$`          | O ID do processo (PID) da sessão atual do shell. |
| `$!`          | O PID do último processo executado em segundo plano.|


```
#!/bin/bash

echo "Este script se chama: $0"
echo "Ele recebeu $# argumentos."
echo "O PID do shell é: $$"
echo "O diretório atual é: $PWD"
echo "O status de saída do último comando foi: $?"

echo "Argumentos recebidos:"
for arg in "$@"; do
  echo "$arg"
done

echo "Todos os argumentos (como string única): $*"

# Testando variável $? com um comando inexistente
ls arquivo_inexistente
echo "Status de saída após erro: $?"

# Exemplo de uso da variável $_
echo "Último argumento do comando anterior: $_"

```

---

### Entendendo o Prompt do terminal linux

### `mateus@linux_server:~$`
  - **`mateus` (antes do @)** → Nome do usuário logado.
  - **`linux_server` (depois do @)** → Nome do computador/host.
  - **`$`** → Indica que o usuário logado é **comum (não root)**.

### `root@linux_server:/home/mateus#`
- **`root`** → Agora o terminal está logado como o superusuário (**administrador do sistema**).
- **`linux_server`** → Nome do host (computador).
- **`/home/mateus`** → Diretório atual continua o mesmo.
- **`#`** → Indica que o shell atual é de um **usuário root** (diferente do `$`, que é para usuário comum).

> Os comandos separados por ";" são executado sequencialmente.
##### Elementos que compõem um tipo de requisição

**ComandName** (nome do comando): a requisição que o usuário deseja executar;
**Flag** (opção): serve para modificar a operação do comando. Ele pode ser incluído por meio de um ou dois hífens;
**Argument**: usado para adicionar informações à requisição. Não é obrigatório para todos os comandos. 

---

### Estrutura de Diretorios Importantes
|   Diretório    | Função                   |
|----------------|--------------------------|
| `/`            | Raiz do sistema          |
| `/home`        | Diretórios dos usuário   |
| `/etc`         | Arquivos de configuração |
| `var`          | Logs e dados variáveis   |
| `/usr`         | Programas e bibliotecas  |
| `bin`, `/sbin` | Binários do sistema      |
| `/tmp`         | Arquivos temporários     |
| `opt`          | Softwares opcionais      |
| `/media`        | Ponto de montagem para dispositivos removíveis |

Todos esses diretórios não podem está em uma partição diferente do diretório "/", por que durante o boot o kernel linux monta primeiro a partição vinculada ao diretório "/"

##### Conceitos de LVM

O Gerenciador de Volume Lógico (LVM) é uma tecnologia de gerenciamento de armazenamento no Linux que oferece flexibilidade e abstração em relação aos dispositivos de armazenamento físico subjacentes. Em vez de trabalhar diretamente com partições fixas, o LVM permite criar volumes lógicos que podem ser facilmente redimensionados, movidos ou combinados, mesmo com o sistema em funcionamento

Volume físico (PV) - Dispositivo de armazenamento físico.

```bash
pvcreate [dispositivo]  # Inicializa um dispositivo (por exemplo, /dev/sdb1) como um Volume Físico.
pvdisplay               # Mostra informações detalhadas sobre todos os volumes físicos.
pvs                     # Fornece um resumo conciso dos volumes físicos.
pvremove [dispositivo]  # Remove a inicialização LVM de um Volume Físico. 
```   

Grupos de volume (VG) - Agrupamento de diferentes discos e partições

```bash
vgcreate [nome-do-vg] [dispositivo]  # Cria um novo Grupo de Volume a partir de um ou mais Volumes Físicos.
vgdisplay                            # Exibe informações detalhadas sobre os grupos de volume.
vgs                                  # Mostra um resumo dos grupos de volume.
vgextend [nome-do-vg] [dispositivo]  # Adiciona um novo Volume Físico a um Grupo de Volume existente.
vgreduce [nome-do-vg] [dispositivo]  # Remove um Volume Físico de um Grupo de Volume.
vgremove [nome-do-vg]                # Remove um Grupo de Volume.
vgchange -a y [nome-do-vg]           # Ativa o Grupo de Volume, tornando seus volumes lógicos acessíveis.
vgchange -a n [nome-do-vg]           # Desativa o Grupo de Volume.
```

Volume lógico (LG) - Partição virtual
```bash
lvcreate -L [tamanho] -n [nome-do-lv] [nome-do-vg] # Cria um novo Volume Lógico com um tamanho específico.
lvdisplay                                          # Mostra informações detalhadas sobre os volumes lógicos.
lvs                                                # Fornece um resumo dos volumes lógicos.
lvextend -L +[tamanho] [caminho-do-lv]             # Expande o tamanho de um Volume Lógico.
lvreduce -L -[tamanho] [caminho-do-lv]             # Reduz o tamanho de um Volume Lógico. Atenção: Reduzir um LV é perigoso e requer que o sistema de arquivos seja reduzido primeiro.
lvremove [caminho-do-lv]                           # Remove um Volume Lógico.
```



##### Controle de bibliotecas compartilhadas

Bibliotecas no Linux são coleções de códigos pré-compilados que fornecem funcionalidades reutilizáveis para diversos programas. Elas permitem que os desenvolvedores não precisem reescrever funções comuns do zero, agilizando o desenvolvimento e otimizando o uso de recursos.

| Bibliotecas estáticas | Bibliotecas dinâmicas|
| --------------------- | -------------------- |
| Binário roda de forma independente| Binário faz referências a várias bibliotecas|
| O binários é mais rápido em sua execução | O binário é mais lento|
| Uso desncessário de memória | Menor uso da memória |
| Tamanho maior no final do arquivo | Tamanho menor final do arquivo|

Quando o comando `ldconfig -p` é executado ele busca as bibliotecas na localização definida pelo arquivo `/etc/ld.so.conf`

---
### Pacotes
Pacotes no Linux são arquivos que contêm todos os componentes necessários para instalar e executar um software, como o código do programa, bibliotecas, arquivos de configuração e documentação

> Esses programas, como o APT (para sistemas Debian/Ubuntu) e o YUM ou DNF (para sistemas baseados em Red Hat), são usados para instalar, remover e atualizar pacotes de forma eficiente. 

##### `apt-get`

O `apt-get` é um comando de linha para gerenciar pacotes em distribuições Linux baseadas em Debian. Ele é usado para instalar, atualizar e remover programas. Os comandos básicos incluem `apt-get` update para atualizar a lista de pacotes, `apt-get upgrade` para atualizar pacotes instalados e `apt-get install` para instalar novos pacotes. 

##### `dpkg`
O comando `dpkg` é uma ferramenta de gerenciamento de pacotes de baixo nível usada em distribuições Linux baseadas em Debian, como o Ubuntu, para instalar, remover e gerenciar pacotes de software em arquivos .deb. Exemplos comuns incluem `dpkg -i` para instalar, `dpkg -l` para listar pacotes instalados e `dpkg --purge` para remover um pacote e todos os seus arquivos de configuração

##### Comandos para gerenciar pacotes.
`dnf`/`yum`: Gerenciadores de pacotes de alto nível para distribuições baseadas em RPM, como Fedora e CentOS

```shell
apt update                   #  Atualiza a lista de pacotes disponíveis nos repositórios. 
apt upgrade                  # Atualiza os pacotes instalados para as versões mais recentes disponíveis nos repositórios. 
apt install <nome-do-pacote> # Instala um pacote específico. 
apt remove <nome-do-pacote>  # Remove um pacote, mas mantém os arquivos de configuração. 
apt purge <nome-do-pacote>   # Remove um pacote e seus arquivos de configuração. 
apt search <termo>           # Procura por pacotes. 
apt show <nome-do-pacote>    # Exibe informações detalhadas sobre um pacote, como versão, descrição e dependências. 
dpkg -i <arquivo.deb>        # Instala um pacote .deb usando o dpkg. 
dpkg -r <nome-do-pacote>     # Remove um pacote. 
dpkg -l                      # Lista todos os pacotes instalados. 
rpm -i <arquivo.rpm>         # Instala um pacote .rpm. 
rpm -e <nome-do-pacote>      # Remove um pacote. 
rpm -qa                      # Lista todos os pacotes instalados. 
dnf update                   # Atualiza todos os pacotes no sistema. 
yun update                   # Atualiza todos os pacotes no sistema. 
```
---
### Gerenciamento de particoes

O `fdisk` é um utilitário de linha de comando usado para gerenciar tabelas de partição em dispositivos de armazenamento no Linux, como discos rígidos e pen drives. Ele opera em modo interativo e é ideal para manipular partições no estilo MBR (DOS), mas também suporta GPT em algumas versões.

> Aviso: Fazer alterações em partições pode causar perda de dados. Sempre faça backup dos dados importantes antes de usar o fdisk.

##### Comandos principais do fdisk
```bash
sudo fdisk -l # Listar todas as partições de todos os discos
sudo fdisk -l /dev/sdX # Listar partições de um dispositivo específico (substitua sdX)
sudo fdisk /dev/sdX # Abrir fdisk para editar o disco especificado
n # Criar nova partição (dentro do modo interativo)
d # Apagar uma partição (modo interativo)
p # Mostrar tabela de partições (modo interativo)
w # Salvar mudanças e sair (modo interativo)
q # Sair sem salvar mudanças (modo interativo)
```

##### Gerenciar partições GPT com gdisk

O `gdisk` é uma alternativa para `fdisk`, especificamente projetada para discos com tabela de partições GPT. Oferece funcionalidades avançadas para manipular partições em discos modernos.

##### Comandos principais do gdisk
```bash
sudo gdisk /dev/sdX # Abrir gdisk para o disco especificado
p # Mostrar a tabela de partições atual
n # Criar nova partição
d # Deletar uma partição
t # Alterar o tipo da partição
w # Gravar alterações e sair
q # Sair sem salvar alterações
```
##### Comandos úteis para formatação e montagem de partições
```bash
sudo mkfs.ext4 /dev/sdXN # Formatar a partição no sistema de arquivos ext4
sudo mkdir /mnt/ponto_de_montagem # Criar diretório para montar a partição
sudo mount /dev/sdXN /mnt/ponto_de_montagem # Montar partição
sudo umount /mnt/ponto_de_montagem # Desmontar partição
```
O comando mkfs (make filesystem) no Linux é usado para criar (formatar) um sistema de arquivos em uma partição de disco ou dispositivo de armazenamento. Ele organiza a estrutura para armazenar arquivos e diretórios naquele dispositivo, preparando-o para uso pelo sistema.

`mkfs -t <tipo_sistema_arquivos> <dispositivo>`

- `-t` define o tipo de sistema de arquivos, como ext4, xfs, vfat, entre outros.

- `<dispositivo>` é a partição ou disco a ser formatado, por exemplo, /dev/sdb1.

##### Partição SWAP no linux

A partição Swap no Linux é um espaço reservado no disco rígido que funciona como uma memória virtual, atuando como uma extensão da memória RAM. Quando a RAM do sistema está cheia, o Linux move temporariamente dados pouco usados para essa partição Swap, liberando espaço na memória física para processos ativos. Isso evita que o sistema trave ou fique excessivamente lento quando a RAM se esgota.

`swapon [opções] [dispositivo|arquivo]`

> Ativa uma partição ou arquivo de swap para uso pelo sistema. 
`sudo swapon /dev/sdb1` || `sudo swapoff /swapfile`

> Desativa uma partição ou arquivo de swap.
`sudo swapoff /dev/sdb1` || `sudo swapoff /swapfile`

> Formata uma partição ou arquivo para ser usado como swap.
`sudo mkswap /dev/sdb1` || `sudo mkswap /swapfile` 

#### XFS
**XFS** é um sistema de arquivos de 64 bits, otimizado para arquivos grandes e cargas de trabalho paralelas. Ele é frequentemente usado em servidores, bancos de dados e armazenamento em massa devido à sua capacidade de lidar com arquivos e sistemas de arquivos massivos e suas operações de entrada/saída (E/S) paralelas, que melhoram o desempenho em tarefas como processamento de mídia. 

Usa um sistema de registro de metadados para garantir a consistência dos dados em caso de falha de energia ou travamento do sistema. As alterações são primeiro registradas em um log e, depois, aplicadas ao sistema de arquivos. 


```bash
 `mkfs.xfs`               # para criar um sistema de arquivos XFS.
 `xfsdump` e `xfsrestore` # utilitários para backup e restauração rápida e multi-thread.
 `xfs_freeze`             # para congelar o sistema de arquivos antes de tirar um snapshot.
 `xfs_quota               # gerenciamento avançado de cotas.
```

##### MOUNT
O comando mount no Linux é usado para montar um sistema de arquivos, tornando um dispositivo de armazenamento (como um pendrive, partição ou imagem ISO) acessível no sistema de arquivos hierárquico do Linux. Para usá-lo, você especifica o dispositivo e um ponto de montagem, que é um diretório vazio onde o conteúdo do dispositivo será exibido. Se o comando for executado sem parâmetros, ele lista todos os dispositivos já montados. 

Sintaxe básica: `mount [opções] <dispositivo> <ponto_de_montagem>`
mount [opções] <dispositivo> <ponto de montagem>

> Montar uma partição em um diretório: Para montar a partição /dev/sdb1 no diretório /mnt, execute:
`sudo mount /dev/sdb1 /mnt`

> Listar todas as unidades (units) de montagem (mount points) que estão atualmente ativas no sistema gerenciado pelo systemd.
` systemctl list-units --type=mount`
---

## Navegacao e manipulacao de arquivos

```bash
ls -lh                            # Lista arquivos com detalhes e tamanhos legíveis
  ls -R                           # Serve para visualizar conteúdos dos subdiretórios;
  ls -l                           # Exibe uma lista detalhada;
  ls -a                           # Mostra os arquivos ocultos.
  ls ~/diretório/                 # Lista os arquivos dentro da pasta da minha home.
cd /caminho                       # Entra em um diretório
  cd..                            # Para subir um diretório acima;
  cd ~                            # Para acessar a pasta do usuário logado
  cd -                            # Para retornar para diretórios anteriores
pwd                               # Mostra o diretório atual

mkdir nome                        # Cria um diretório
rmdir pasta                       # Ela exclui permanentemente um diretório vazio
  rmdir -p caminho/pasta          # Utilizado para apagar um diretório e seus subdiretórios
  rmdir -ignore-fail-on-non-empty # Faz com que o comando ignore o erro caso o diretório não esteja vazio.
rm arquivo                        # Remove um arquivo
  rm -r pasta                      # Remove uma pasta e tudo dentro dela
  rm -i                           # Solicita a confirmação do sistema antes de fazer uma exclusão
  rm -f                           # Permite que o sistema exclua arquivos sem solicitar confirmação

cp origem destino                 # Copia arquivos ou diretórios
  cp -r                           # copia o diretório de forma recursiva (todos os arquivos e subdiretórios)
  cp -v                           # Mostra o nome de cada arquivo copiado
  cp -f                           # Forma a cópia, sobrescreve os arquivos originais sem perguntar.
  cp -p                           # Preserva atributos originais
mv origem destino                 # Move ou renomeia arquivos/pastas
touch nome.txt                    # Cria um novo arquivo vazio

cat arquivo.txt                   # Mostra o conteúdo de um arquivo
cut                               # é usado para extrair seções específicas de cada linha de um arquivo de texto ou da saída de outro comando.
  cut -c5-15 teste.txt            # Extrair os caracteres do 5º ao 15º de cada linha
  cut -d: -f1,6 /etc/passwd > usuarios_home.txt # Salvar o resultado em um novo arquivo
zcat arquivo.gz                   # Serve para visualizar o conteúdo de um arquivo compactado com gzip

stat arquivo.txt                  # Com este comando, é possível visualizar informações detalhadas sobre os arquivos
less arquivo.log                  # Visualiza arquivo com rolagem (para logs grandes)
grep "palavra" /etc/arquivo.txt   # Busca texto em arquivos.
find /home -name "documento.txt"  # Localiza arquivos. (find [diretório] [opção] [ação])
scp / rsync                       # Cópia remota do arquivo.
cron                              # Agendamento de tarefas

wc [opção] texto.txt              # Ele serve para contar palavras, linhas, caracteres além de também indicar o comprimento da maior linha de um texto.
  wc -w texto.txt                 # para contar a quantidade de palavras;
  wc -c texto.txt                 # para contar a quantidade de caracteres;
  wc -l texto.txt                 # mostra o número de linhas;
  wc -m texto.txt                 # usado para mostrar o número de caracteres usando o formato Unicode;
  wc -L texto.txt                 # mostra o comprimento da maior linha do arquivo.

mount [opções] <dispositivo> <ponto de montagem> # Listar dispositivos montados
split [OPÇÕES] [ARQUIVO] [PREFIXO] # É usado para dividir arquivos grandes em pedaços menores.

tar [opções] [nome_do_arquivo.tar] [arquivos_ou_diretórios] # Serve para agrupar múltiplos arquivos e diretórios em um único arquivo
  -c (--create)            # Cria um novo arquivo .tar.
  -x (--extract)           # Extrai arquivos de um arquivo .tar.
  -f (--file)              # Especifica o nome do arquivo de saída ou entrada (.tar).
  -v (--verbose3)          # Mostra o progresso e os nomes dos arquivos sendo processados.
  -t (--list)              # Lista o conteúdo de um arquivo .tar sem extraí-lo.

gzip [opções] arquivo      # Comando para compressão de arquivos no Linux.
gunzip [opções] arquivo    # Comando para descompactar arquivos.

```
[FIND](#find)
#### SPLIT
O comando split no Linux é usado para dividir um arquivo grande em vários arquivos menores. Por padrão, ele divide o arquivo em pedaços de 1.000 linhas, a menos que você especifique um tamanho diferente. O arquivo original não é modificado.
`split [OPÇÕES] [ARQUIVO] [PREFIXO]` 
- [ARQUIVO]: O nome do arquivo grande a ser dividido.
- [PREFIXO]: O prefixo para os nomes dos novos arquivos. Se não for especificado, o split usará x como padrão, se quiser expedificar o número e linhas é só usar o prefixo -l seguido pelo número de linhas.

#### quoting
O **quoting" no Linux é o ato de usar caracteres especiais, como aspas (simples, duplas ou backticks) e a barra invertida, para instruir o shell a tratar o texto de forma literal, ignorando seu significado especial e evitando a interpretação de comandos, variáveis ou caracteres especiais.
- Aspas Simples ('): Protegem todo o texto entre elas, tratando-o como um literal.
- Aspas Duplas ("): Protegem o texto, mas permitem a expansão de variáveis (como $USER) e a      substituição de comandos (usando $(comando)). Elas também desabilitam o significado especial de curingas (como * ou ?). 
EX: `echo "Olá, $USER!"` imprimirá "Olá, [nome do usuário]!"
- Backticks (`` ` ``): São usados para executar um comando e substituir o texto entre eles pelo resultado desse comando. 
EX: ` echo "O diretório atual é: $(pwd)" `

> ` ls -l "/caminho/do meu/diretorio" ` é igual a: ` ls -l /caminho/do\ meu/diretorio `

#### DD
O comando `dd` realiza cópias byte a byte, ou seja, realiza cópia sequencial de qualquer origem para qualquer destino. Por isso, é especialmente útil para fazer cópias completas de discos ou partições.

> Criar uma copia da partição sda1:
`dd if=/dev/sda1 of=/tmp/part_sda1.hd bs=1M count=1024` -> if=arquivo de entrada; of=arquivo de saída; bs=informar a quantidade de bytes copiados por vez.

OBS: LPIC-1 - Preparatório para os Exames 101 e 102 V5 ATUALIZADO (aula: 27.103.3)

---

## Informacoes do sistema

```bash
uname -a           # Informações do kernel e arquitetura
uptime             # Tempo de atividade do sistema
top                # Monitoramento em tempo real de processos
htop               # Versão aprimorada do top (pode precisar instalar)
free -h            # Uso de memória
df -h              # Espaço em disco
  df -hTi          # Exibe a quantidade de idones total, usado e disponível por sistema de arquivos montados
  df - hT          # A opção "-h" exibe o espaço total, espaço usado e espaço disponível em megabytes ou
                   # gigabytes, já a opção "-T" informa qual o sistema de arquivos do dispositivo que está montado e emuso.
du -sh pasta/      # Tamanho da pasta
ps [opções] aux    # Lista todos os processos 
      -a - Mostra todos os processos existentes e ligados a terminais. 
      -e - Mostra as variáveis de ambiente relacionadas aos processos. 
      -f - Mostra a árvore de execução dos processos. 
      -l - Mostra mais campos no resultado. 
      -x - Mostra os processos que não estão associados a terminais. 
      -u - Mostra o nome do usuário que iniciou determinado processo e a hora em que isso ocorreu. 
      -m - Mostra a quantidade de memória ocupada por cada processo.
ps aux | grep nginx #verificar se o serviço/processo nginx está em execução no sistema
tail -f /var/log/syslog   # Acompanha logs em tempo real.
man <comando>             # É usado para exibir as páginas de manual de qualquer outro comando
apropos list directory    # É usado para pesquisar nas páginas de manual (man pages) por comandos cujas descrições contêm uma palavra-chave.
```
#### TAIL
O comando tail no Linux exibe as últimas linhas de um arquivo de texto, sendo útil para monitorar arquivos de log em tempo real. Por padrão, ele mostra as 10 linhas finais, mas essa quantidade pode ser alterada com a opção -n. A opção `-f` é muito usada para seguir o arquivo e exibir novas linhas à medida que são adicionadas no arquivo em tempo real.
> Exibir um número específico de linhas (por exemplo, 20)
`tail -n 20 nome_do_arquivo.txt`

> Monitorar um arquivo em tempo real (útil para logs)
`tail -f nome_do_arquivo.log`
`tail -f /var/log/messages`

> Exibir a 15° linha até a última
`nl /etc/passwd | tail -n +15` 

---

## Gerenciamento de usuarios

```bash
whoami             # Mostra o usuário atual
adduser nome       # Adiciona novo usuário
passwd nome        # Altera senha de um usuário
usermod -aG grupo nome # Adiciona usuário a um grupo
deluser nome       # Remove um usuário
groups nome        # Mostra os grupos de um usuário
chmod +x script.sh # Dá permissão de execução
```

---

## Processos e servicos

```bash
ps aux             # Lista todos os processos
kill PID           # Envia sinal para finalizar processo
kill -9 PID        # Finaliza forçadamente um processo
pgrep              # Usa expressões regulares, buscando por paret do nome do processo
systemctl status nome    # Verifica status de um serviço
systemctl start nome     # Inicia um serviço
systemctl stop nome      # Para um serviço
systemctl restart nome   # Reinicia um serviço
systemctl enable nome    # Ativa serviço na inicialização
```
#### PGREP
Utilitário pgrep usa expressões regulares semelhante ao comando grep, buscando por parte do nome do processo, retornando apenas seu PID. 

> Para listar o PID do processo CROND podemos fazer uma das seguintes formas:
`pgrep crond`

#### KILL

O sistemas GNU/Linux podem usar alguns comandos para enviar sinais de controle para os processos que estão em execução. para listar os tipos de sinais que podem ser usados

`kill -l`
- SIGHUP (1): Reinicia o processo. Faz o processo re-ler o arquivo de configuração. 
- SIGINT (2): Interrompe o processo. Equivale ao ctrl+c.
- SIGQUIT (3): Fecha o processo. 
- SIGKILL (9): Finaliza o processo. Imediatamente (Mata o processo). 
- SIGTERM (15): Solicita ao processo que termine. 
- CONT(18): Continuar a execução do processo, se interrompido. 
- STOP(19): Interromper processo que esta em execução.

> Criação de um cenário no qual o usuário root estará editando um arquivo e em outro terminal iremos encerrar o Editor de Texto VIM.

```
Primeiro terminal:
# cd /tmp
# vim arquivo.txt
Segundo terminal:
# ps aux | grep -i vim  # Listas todos os processos que tem 'vim' no nome
> root 10554 0.0 0.6 11056 3424 tty1 S+ 14:49 0:00 vim arquivo.txt  # Retorno
# kill 10554 # Finaliza o processo.
```

#### killall

**Função:** Encerra processos pelo **nome completo** do processo.

##### Sintaxe
```bash
killall nome_do_processo
```

##### Exemplo
```bash
killall firefox
```
> Encerra todos os processos chamados `firefox`.

**Observação:** Precisa de permissão adequada (`sudo`) para encerrar processos de outros usuários.

---

#### pkill

**Função:** Encerra processos usando **o nome completo ou parte do nome** do processo.

##### Sintaxe
```bash
pkill [opções] nome_do_processo
```

##### Exemplos
```bash
pkill firefox        # Encerra todos os processos que contêm "firefox"
pkill -9 firefox     # Força encerramento imediato (sinal SIGKILL)
```

**Observação:** Permite usar padrões parciais do nome do processo e sinais específicos.

---

#### bg

**Função:** Retoma a execução de um programa **parado (suspenso) no background**, mantendo-o no segundo plano.

##### Sintaxe
```bash
bg [número_do_job]
```

##### Exemplo prático
```bash
sleep 100        # Executa um comando longo
Ctrl+Z           # Suspende o processo
jobs             # Lista processos suspensos
bg %1            # Coloca o job 1 em execução no background
```

> O processo continuará executando no background, permitindo que o terminal seja usado normalmente.

---


#### NICE e RECEIVER

Os comandos nice e renice são ferramentas do Linux para gerenciar a prioridade de execução de processos. O valor que determina essa prioridade é chamado de "nice value" (valor de gentileza). 

O nice é usado para iniciar um novo comando ou script com uma prioridade de agendamento modificada.

- Prioridade: Um valor nice mais alto (mais "gentil") significa uma prioridade mais baixa. O processo receberá menos tempo de CPU em comparação com outros processos. Um valor nice mais baixo (menos "gentil") significa uma prioridade mais alta e mais tempo de CPU.
- Intervalo: O valor nice varia de -20 (prioridade mais alta) a 19 (prioridade mais baixa).

> Inicia um comando com a prioridade mais baixa (nice 19)
`nice -n 19 meu_comando_pesado`

> Inicia um comando com a prioridade mais alta (nice -20) **Requer permissões de root**
`sudo nice -n -20 meu_comando_importante`

O `renice` permite alterar a prioridade (nice value) de um processo que já está em execução, sem a necessidade de reiniciá-lo.

- Flexibilidade: Permite ajustar a prioridade de forma dinâmica, dependendo da carga atual do sistema.
- Uso: Você precisa do ID do processo (PID) para usar o renice.

> Altera a prioridade de um processo com o PID 1234 para o valor 10
`renice 10 -p 1234`

#### Gerenciar serviços (SystemD) - `systemctl`
- **Uso:** `systemctl [operação] [serviço]`
- **Exemplos:**
  - `systemctl status nginx`
  - `systemctl start apache2`
  - `systemctl enable sshd`

#### `journalctl` - Ver logs do sistema
- **Uso:** `journalctl [opções]`
- **Exemplos:**
  - `journalctl -xe` (últimos logs com erros)
  - `journalctl -u nginx.service` (logs do nginx)


#### HASH

Funções de hash para verificar a integridade de arquivos. Isso é feito através de comandos como md5sum e sha256sum, que geram uma "impressão digital" única para um arquivo.

Calcular o hash de um arquivo é uma prática essencial para garantir que um arquivo não foi corrompido ou alterado maliciosamente. Se você baixar um arquivo e o hash que você calculou localmente for diferente do fornecido pelo site, o arquivo pode estar comprometido.

`md5sum`
Gera uma hash MD5 de 128 bits. Embora ainda seja usado, é considerado criptograficamente inseguro e não recomendado para verificações críticas. 
- Sintaxe: md5sum [ARQUIVO]
```
md5sum minha_imagem.iso
sha256sum minha_imagem.iso
sha512sum minha_imagem.iso

```
Isso retornaria algo como d41d8cd98f00b204e9800998ecf8427e minha_imagem.iso.

#### Execucao de processos em primeiro e segundo plano

Nós podemos executar um comando para ser executado em background, liberando-seassimoterminalpara uso. Em vez de digitar less /etc/passwd e prender o terminal, execute-o embackground:

`less /etc/passwd &`

Para poder executar qualquer programa em backgroung, coloque o caracter “&” no final do comando. E para verificar os processos em segundo plano, devemos usar o comando `job` para a listagem dos processos.


---

## Rede

```bash
ip a               # Mostra interfaces de rede e IPs
ping 8.8.8.8       # Testa conectividade com destino
curl http://site   # Faz uma requisição HTTP
wget url           # Baixa um arquivo via terminal
netstat -tuln      # Lista portas em uso (pode ser necessário instalar)
ss -tuln           # Alternativa moderna ao netstat

```

---

## Gerenciamento de pacotes (Debian/Ubuntu)

```bash
apt update                 # Atualiza lista de pacotes
apt upgrade                # Atualiza pacotes instalados
apt install nome           # Instala pacote
apt remove nome            # Remove pacote
apt purge nome             # Remove completamente (incluindo configs)
apt autoremove             # Remove pacotes não utilizados
```

---

## Permissoes e acesso

```bash
chmod +x script.sh         # Torna o arquivo executável
chown user:grupo arquivo   # Altera dono e grupo de um arquivo
sudo comando               # Executa comando como root
su -                       # Troca para o usuário root
apt get                    # Pode ser utilizada para gerenciar, atualizar, pesquisar, instalar e desinstalar pacotes em um sistema.
```
As permissões são as informações que indicam que tipo de acesso pode ser realizado emdeterminadodiretórioou arquivo. No GNU/Linux cada arquivo e/ou diretório tem definido seu controle de acessoempermissõesatribuídas a:

- Usuário(user) - É o usuário que criou o arquivo ou o diretório. O nome do dono(proprietário)doarquivo/diretório é o mesmo do usuário usado para entrar no sistema GNU/Linux. Somenteodonopodemodificar as permissões de acesso do seu arquivo/diretório, além do usuário root.
- Grupo(group) - Permissão atribuída a um grupo, permitindo que vários usuários membrosdogrupotenhamacesso a um mesmo arquivo/diretório (já que somente o dono poderia ter acesso ao arquivo). Cadausuáriopode fazer parte de um ou mais grupos de usuários. 
- Outros(other) - Todos os usuários que não são donos ou não pertencem ao grupo do arquivo

As permissões em arquivos/diretórios são sequências de 12 bits, ou seja, bits de atributoeproteçãonoformato rwx rwx rwx, sendo, que os três bits iniciais são usados para permissões especiais e os nove restantes são conhecidos como bit do file mode(modo arquivo). 
|Permissão modo literal|Permissão modo octal|Ação|Efeito no arquivo|Efeito no diretório|
| -------------------- | ------------------ | -- | --------------- | ----------------- |
| r | 4 | leitura | Visualização de conteúdo | Visualização do conteúdo do diretório|
| w | 2 | Escrita| Modificar e deletar o arquivo | Criar/Apagar arquivos/diretórios |
| x | 1 | Execução/Acesso para diretório| Execução do arquivo como programa | Entrar no diretório |

---

## Limpeza e manutencao

```bash
history                    # Mostra histórico de comandos
clear                      # Limpa a tela do terminal
journalctl -xe             # Ver logs do sistema
```

---

## Atalhos uteis

- `TAB` → Autocompleta comandos e nomes de arquivos
- `CTRL + C` → Interrompe um comando em execução
- `CTRL + L` → Limpa a tela (igual `clear`)
- `CTRL + R` → Busca no histórico de comandos
#### Caracteres curinga no shell
| Caractere | Descrição | Exemplo | Resultado / Explicação |
|-----------|-----------|---------|------------------------|
| `*`       | Representa zero ou mais caracteres | `ls *.txt` | Lista todos os arquivos que terminam com `.txt` |
| `?`       | Representa um único caractere | `ls file?.txt` | Lista `file1.txt`, `fileA.txt`, mas não `file10.txt` |
| `[]`      | Representa qualquer caractere dentro dos colchetes; pode usar intervalos | `ls file[1-3].txt` | Lista `file1.txt`, `file2.txt`, `file3.txt` |
| `{}`      | Lista múltiplos padrões separados por vírgula | `ls {file1,file2,file3}.txt` | Lista `file1.txt`, `file2.txt`, `file3.txt` |
| `~`       | Representa o diretório home do usuário | `cd ~` | Vai para `/home/seu_usuario` |
| `[!...]`  | Negação de um conjunto de caracteres | `ls file[!0-3].txt` | Lista arquivos que não terminam com 0,1,2 ou 3 antes de `.txt` |
| `[a-z]`   | Intervalo de caracteres | `ls file[a-c].txt` | Lista `filea.txt`, `fileb.txt`, `filec.txt` |
| `[0-9]`   | Intervalo de números | `ls file[0-5].txt` | Lista arquivos de `file0.txt` a `file5.txt` |

---
## Expressoes regulares

Expressões regulares são elementos de texto, palavras-chave e modificares que formamumpadrão,usadopara encontrar e opcionalmente alterar um padrão correspondente. As expressões regularesutilizammetacaracteres, que são caracteres especiais que podem ser usados para ajudar na formacomoéfeitaumabusca.
```
   Caracteres especiais em expressões regulares:

?     # É usado para representar zero ou um(a) letra/palavra que está precedido. 
+     # Usamos para que a ocorrência apareça uma ou mais vezes.
^     # Inicio da linha. $ - Fim da linha.
.     # O ponto, representa qualquer caractere não importando se o caractere é letra, número ou qualquer coisa. 
*     # Usamos para representar zero ou mais caracteres precedidos. 
[]    # A lista representa um grupo de caracteres a serem procurados no texto. O "-" indica um intervalo. 
[^]   # Pode ser chamado de lista negada, pois faz exatamente o **oposto da lista "[]".**
{n}   # Usamos para informar exatamente o número "n" de vezes de pesquisa de um caracter e que precede.
```
#### SED

O comando sed é mais utilizado para procurar e substituir padrões em textos, mostrandooresultadoemstdout.

Sintáxe básica: `sed [opções] 'comando e expressão regular' [arquivo]`
```
Comandos do sed:
[Opções]
s - Substituir;
d - Apagar a linha;
g - Substitui todas as ocorrências da expressão na linha atual
```

No sed, a expressão fica circunscrita entre barras(/). Por exemplo: Deletar as linhas comentadas do arquivo “/tmp/fstab”:

> Trocar todos os caracteres igual a 8 pela palavra REGEX, no arquivo entrada.txt:
`sed 's/[8]/REGEX/g' entrada.txt`

#### GREP
O **grep** é como um localizador de texto no Linux, muito útil para analisar arquivos grandes ou filtrar informações específicas. Ele usa expressões regulares para encontrar ocorrências.

Sintaxe básica: `grep [opções] "texto" arquivo`
Exemplos:
> Procurar a palavra error dentro do arquivo log.txt
`grep "error" log.txt`

> Procurar de forma case-insensitive (ignora maiúsculas e minúsculas):
`grep -i "error" log.txt`

> Mostrar o número da linha onde a palavra aparece:
`grep -n "error" log.txt`

> Usar com pipe para filtrar a saída de outro comando, por exemplo, encontrar processos do nginx:
`ps aux | grep nginx`

> Realizar a contagem das ocorrências de uma palavra.
`grep -c root /tmp/passwd_copia`

> Encontrar sequência de números que começa com 19 e é seguida por exatamente mais dois outros dígitos:
`egrep'19[0-9]{2}` nome_do_arquivo

#### FIND
O comando find é uma ferramenta poderosa do Linux para pesquisar arquivos e diretórios em uma hierarquia de diretórios com base em diversos critérios. Diferentemente do locate, que usa um banco de dados pré-indexado, o find busca diretamente no sistema de arquivos, tornando-o mais preciso para encontrar arquivos recém-criados ou modificados.

> Para encontrar um arquivo chamado meuarquivo.txt a partir do diretório atual
`find . -name "meuarquivo.txt"`

> Para ignorar a distinção entre maiúsculas e minúsculas:
`find . -iname "meuarquivo.txt"`

> Excluir todos os arquivos .tmp
`find /tmp -name "*.tmp" -delete`

> Mostrar todos os arquivos modificados nas últimas 48h:
`find . -atime -2` ou `find . -atime 2` caso queira acessar os arquivos que foram modificados em exatas 48 horas. 

> Mostrar todos os arquivos modificados no último minuto:
`find . -mmin -1`
---
## Vim (Visual Editor)

O vim é uma versão melhorada do vi. Ele não está em 100% das distros por padrão, mas está presente na grande maioria das distribuições modernas (Ubuntu, Debian, Fedora, CentOS, Arch, etc.). Ele é rápido, leve, roda no terminal e é extremamente poderoso para edição de arquivos de texto e código.

>Abertura de arquivos: `vim arquivo.txt`

**Modo de inserção**: Usado para inserção comum de textos no qual as letras são letras mesmo. Paraentrarnesse modo podemos usar qualquer uma das teclas: "a" , "A" , "i" , "I" , "o" , "O" , "s" e"S". O modode inserção é identificado pela mensagem INSERT na parte inferior esquerda do editor. 

**Modo de comando**: Entramos nesse modo pelo pressionamento das teclas [esc] [:](TeclaESCedoispontos) e ele é usado para execução de comandos complexos e sequências especiais para edição de textos no arquivo. 

**Modo de navegação**: Entramos nesse modo pelo pressionamento da tecla [esc] se estivermos no modo de inserção, caso contrário, ele é o modo padrão do editor vi. E ele é usado para inserçãodecomandosnaqual cada letra tem uma função especifica.

**Parâmetros para inicialização:**
|Parâmetro/Opção|Comando de Exemplo|Descrição|
|---------------|------------------|---------|
Abrir Arquivo	| vim arquivo.txt |	Abre o arquivo para edição.|
Apenas Leitura | vim -R arquivo.txt ou view arquivo.txt |	Abre o arquivo no modo somente leitura (read-only).|

**Comandos executados no vim**
|Comando/Tecla|Modo|Descrição|
|-------------|----|---------|
|Salvar e sair| :wq| Salva as alterações (w - write) e sai (q - quit).|
|Salvar|:w| Salvar arquivo sem sair do editor|
|Sair (Sem Salvar)|	:q!|	Sai do editor forçadamente, descartando as alterações não salvas.|
|Salvar como	|:w novo_nome.txt |	Salva o arquivo com um novo nome.|
|Sair (Normal)	:q	| Sai do editor, mas só funciona se não houver alterações não salvas.|
|Modo Normal	Esc	| Sai do modo de inserção e volta ao modo de comando (ou modo Normal).|
| Desfazer	| u	| Desfaz a última alteração no Modo Normal.
|Ajuda	| :help |	Abre o sistema de ajuda do Vim.


|ESC + | Descrição  |
| ----- | ---------- |
| i  | entra no modo inserção antes do cursor     |
| a  | entra no modo inserção após o cursor.      |
| o  | nova linha abaixo e entra no modo inserção |
| dd | apaga a linha atual                        |
| yy | copia a linha atual.                       |
| p  | cola o conteúdo copiado.                   |
| u  | desfaz a última ação                       |
| CTRL + r  | refaz a ação desfeita.                     |
| /palavra | busca por “palavra” no texto         |
| n  | repete a busca                             |
| x  | apaga o caractere sob o cursor             |
| gg | vai para o início do arquivo               |
| G  | vai para o fim do arquivo                  |
| :set number | exibe números de linha            |

---
### Redirecionamento de Entrada Saida e Erros padrao

Processos Unix (e consequentemente Linux) geralmente abrem três descritores padrão de arquivos,que os permitem processar entrada e saída de dados. Esses descritores podem ser redirecionados de e para outros arquivos ou processos. 

Por padrão, o descritor de entrada, stdin é o teclado representado também pelo número 0 e os descritores de saída padrão é stdout que pode ser representado pelo número 1 e odesaídadeerroédescritor stderr representado pelo número 2. 
```
> - O caractere maior que ">" é usado para trabalhar a saída padrão (STDOUT). 
2> - O número 2 seguido do caractere maior que "2>" é usado para trabalhar a saída de erro(STDERR).
< - O caractere menor que "<" é usado para trabalhar a entrada padrão (STDIN).
```
> Após realizar um comando ele criar um arquivo chamado error.out para colocar a saída de erro encontrada.
`cat /etc/group1 2> ~/tmp/error.out`

> Lê todo o conteúdo de file1.txt, e adiciona esse conteúdo ao final de file2.txt.
`cat file1.txt >> file2.txt`

#### PIPE

O pipe "|", simplesmente envia a saída de um comando para a entrada do próximo comando para continuídade do processamento. O uso mais comum dele é quando desejamos procurar por algo no sistema cujo o resultado é maior que nossa tela, então fazemos um pipe com os comandos:

`dpkg -l | grep -i iptables`
`ps -aux|grep -i suporte`
`ls -l /etc|less`

#### TEE

O comando tee permite redirecionar a saída padrão e erro simultaneamente para um arquivo e tela, podendo até anexar o conteúdo quando utiliza a opção -a

> Para enviar a saída do comando cat para a tela e para um arquivo:
`cat /etc/passwd | tee /tmp/passwd_copy`

> Para anexar a saída de uma comando dentro de um arquivo sem sobrescrever o conteúdoexistente
`cat /etc/group | tee -a /tmp/passwd_copy`

---
## Camadas da arquitetura do linux

#### Hardware
É a camada física, que inclui a CPU, memória RAM, discos rígidos, placas de rede, dispositivos de entrada/saída, etc. O Kernel Linux interage diretamente com esta camada.
#### Kernel (núcleo do sistema operacional)
O Kernel é o coração do Linux e é o componente mais importante. Ele reside em um espaço de memória protegido (o Espaço do Kernel) e atua como uma ponte entre o hardware e o software de aplicação.

O Kernel Linux é classificado como monolítico modular:
- Monolítico: Todos os serviços principais (gerenciamento de memória, gerenciamento de processos, sistema de arquivos, drivers de dispositivo) estão contidos em um único programa.
- Modular: Permite que novas funcionalidades (como drivers para novos hardwares) sejam carregadas ou descarregadas dinamicamente como módulos de kernel carregáveis (LKM), sem a necessidade de reiniciar o sistema.

Funções principais do Kernel:

Gerenciamento de Processos (Escalonador): Cria, encerra e gerencia a execução de todos os programas, alocando tempo de CPU entre eles.

Gerenciamento de Memória: Aloca e protege a memória do sistema, implementando memória virtual (incluindo o uso de swap).

#### Chamadas de Sistema (System Calls)
Esta camada é a interface que permite aos programas (que rodam no Espaço do Usuário) solicitar serviços do Kernel. Uma aplicação não acessa o hardware diretamente; ela usa uma chamada de sistema que passa a requisição para o Kernel, que a executa e retorna o resultado.

##### Inicializacao do sistema

O **Systemd** é um gerenciador de sistema e serviços para sistemas operacionais Liux. Podendo ser executado como um sistema init para inicializar o sistema.

O SystemD monitora processos usando cgroups do Linux, garantindo que ao parar umdeterminadoserviço, todos os processos que tenham sido iniciados por ele sejam finalizados;

**SysVinit** é um sistema de inicialização (sistema init) usado em muitas distribuições GNU/Linux por padrão. No SysVinit existe um processo que é iniciado primeiro após o carregamento do kernel e, portanto, recebe o primeiro PID (Identificador de processo).

##### Características do UEFI
- Secure Boot (Inicialização Segura);
- Velocidade de Boot;
- Módulo de Suporte à compatibilidade;
- ESP (EFI System Partition)

#### Desligando e reiniciando o sistema
```bash
shutdown            # Agenda o desligamento para 1 minuto por padrão
  shutdown -h now   #	Desliga o sistema imediatamente (-h para halt).
  shutdown -r now   #	Reinicia o sistema imediatamente (-r para reboot).
  shutdown -h +10   #	Desliga em 10 minutos.
  shutdown -h 20:00 #	Desliga às 20:00 (horário do sistema).
  shutdown -c	    # Cancela um shutdown agendado.
telinit             # Um link ou alias para o init com a mesma função
init                # Um comando versátil que, quando executado com um número (0 a 6), instrui o processo init (o processo pai de todos os outros) a mudar o runlevel.
systemctl reboot    # Ele envia um sinal ao systemd para iniciar o processo de reinicialização
systemctl poweroff  # Ele instrui o systemd a iniciar o processo de desligamento seguro do hardware
```