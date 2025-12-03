# Exame 101
## 1. Arquitetura do Sistema (System Architecture)

### **Comandos para pegar informações do sistema**
A arquitetura do Linux é modular e baseada em um kernel monolítico, capaz de carregar módulos dinamicamente. O sistema é dividido em kernel space (onde o kernel opera diretamente com o hardware) e user space (onde os aplicativos são executados). O kernel funciona como a camada intermediária entre hardware e software.

O kernel é o núcleo do sistema, executado em uma área protegida da memória. Ele é considerado monolítico modular porque:
- Monolítico: reúne em um único componente os principais serviços do sistema (gerenciamento de memória, processos, arquivos e drivers).
- Modular: permite adicionar ou remover funcionalidades por meio de módulos carregáveis (LKM) sem reiniciar o sistema.

Após o login, o bash aguarda comandos do usuário, que podem ser:
- Internos (builtins): comandos integrados ao próprio bash, executados diretamente. Ex.: cd, echo, exit.
- Externos: programas armazenados no sistema de arquivos, executados via caminho absoluto ou por diretórios listados em $PATH. Ex.: /bin/ls, /usr/bin/grep.

Use o comando type para verificar se um comando é interno ou externo.


##### Diferencas entre terminal e shell
O **terminal** é a aplicação (geralmente gráfica) que fornece a interface para interação textual.
O **shell** é o interpretador de comandos responsável por executar instruções do usuário e comunicar-se com o kernel.

#### **`uptime`**
O comando `uptime` exibe o tempo de atividade do sistema, o número de usuários logados e a média de carga do sitema dos últimos 1, 5 e 15 minutos. 
`uptime`: Retorno: `23:03:09 up 2 min,  1 user,  load average: 2.13, 1.64, 0.68`
> Load average é a média de processos em execução ou aguardando por recursos do sistema (como CPU ou disco)

| Opção       | Função                                                    |
| ----------- | --------------------------------------------------------- |
| `-p`        | Mostra o tempo ligado em formato legível (human-readable) |
| `-s`        |  Exibe a data e hora exatas em que o sistema foi iniciado. no formato `AAAA-MM-DD HH:MM:SS`.|
| `--help`    | Ajuda                                                     |
| `--version` | Versão do comando                                         |

#### **`hostnamectl`**
Esse comando mostra informações do host (systemd), ele mostra hostname, kernel, arquitetura, OS etc.

#### **`top`**
#### **`htop`**
#### **`free`**
#### **`df`**
#### **`du`**
#### **`ps`**
#### **`ps aux`**
#### **`tail`**
#### **`man`**
#### **`apropos`**
#### **`last`**
#### **`lshw`**

#### **`lsusb`**
Lista dispositivos USBs
| Opção | Descrição       |
| ----- | --------------- |
| `lsusb -v`  | Verboso         |
| `lsusb -t`  | Exibe em árvore |


#### **`lspci`**
comando em sistemas operacionais do tipo Unix que imprime informações detalhadas sobre todos os barramentos e dispositivos PCI no sistema.
| Opção | Descrição                 |
| ----- | ------------------------- |
| `lspci -v`  | Verboso                   |
| `lspci -vv` | Muito verboso             |
| `lspci -k`  | Mostra drivers associados |

### Determinar e configurar hardware e software do sistema.
### Inicialização do sistema e processos.
##### Arquivos de configuracao do Bash
É possível automatizar a criação de variáveis, aliases, funções e outras personalizações do bash, tanto para entrada do usuário no sistema quanto para cada nova instância do bash. Para uso de todos os usuários que se autenticarem temos:

`/etc/profile` - Esse arquivo contém comandos que são executados para todos os usuários do sistema no momento do login. Somente o usuário administrador(root) pode fazer alterações nesse arquivo. Esse arquivo é lido antes dos arquivos de configurações individual de cada usuário. 
`/etc/bashrc` ou `/etc/bash.bashrc` - Esse arquivo tem a mesma utilidade do arquivo `/etc/profile`, mas é lido por shells que não precisam de autenticação para iniciar uma nova sessão no terminal, como por exemplo, gnome-terminal que emula um shell no ambiente gráfico.

Além dos arquivos já vistos podemos personalizar o ambiente shell de cada usuário individualmente usando os seguintes arquivos:

- `~/.bash_profile` - Semelhante ao arquivo `/etc/profile`, mas o arquivo `~/.bash_profile` é válido para ousuário e fica no diretório pessoal de cada e contém comandos, aliases, funções que são executados para o usuário no momento do login no sistema após a leitura do arquivo `/etc/profile`.
- `~/.bash_login` - Em algumas distribuições esse arquivo substitui o `~/.bash_profile`.
- `~/.profile` - Em algumas distribuições esse arquivo substitui o `~/.bash_profile`.
- `~/.bashrc` - Faz o mesmo que o arquivo `/etc/bashrc` ou `/etc/bash.bashrc`, mas nesse caso só se aplica ao usuário individualmente e que não precisa de autenticação, por exemplo, usando o gnome-terminal.

> Note que antes de cada arquivo foi incluso o sinal "~", que indica o diretório HOME do usuário.

> A linha #!/bin/bash, conhecida como shebang (ou hashbang), tem a função de indicar ao sistema operacional qual interpretador deve ser usado para executar um script. Ele deve ser a primeira linha de qualquer script executável.

### Níveis de execução (runlevels).
### Uso de dmesg, uname e outros comandos para diagnóstico do sistema.
#### **`dmesg`**
O comando dmesg (diagnostic message) exibe mensagens geradas pelo kernel do Linux. Essas mensagens incluem informações sobre inicialização do sistema, detecção de hardware, carregamento de drivers, erros do kernel e eventos do sistema.

| Opção      | Descrição                     |
| ---------- | ----------------------------- |
| `-T`       | Converte timestamps           |
| `-k`       | Filtra só mensagens do kernel |
| `--follow` | Acompanha em tempo real       |


#### **`uname`**
Comando usado para exibir informações sobre o sistema operacional, como o nome do kernel, a versão do kernel, o tipo de máquina, o nome da rede e o tipo de processador: 
`uname`: Retorno: `x86_64`
| Opção       | Descrição                                              |
| ----------- | ------------------------------------------------------ |
| `uname -a`  | Mostra tudo (kernel, hostname, data, arquitetura etc.) |
| `uname -r`  | Versão do kernel                                       |
| `uname -s`  | Nome do kernel                                         |
| `uname -m`  | Arquitetura da máquina                                 |
| `uname -n`  | Nome do host                                           |

### Diretórios Linux

Os diretórios Linux são pastas que organizam o sistema de arquivos, seguindo uma estrutura hierárquica a partir do diretório raiz (\(/\)). Cada diretório tem uma função específica, como armazenar programas (\(/bin\), \(/usr\)), configurações (\(/etc\)), arquivos dos usuários (\(/home\)), ou dados temporários (\(/tmp\)). 

![alt text](image.png)

#### **`cat`**
O comando cat é usado para visualizar, combinar e criar arquivos de texto.

 O diretório `/proc` é um sistema de arquivos,que exibe informações sobre o kernel e os processos em execução em tempo real. Ele é criado dinamicamente na memória e contém subdiretórios com números (identificadores dos processos - PID) e arquivos que descrevem o estado do sistema, como memória, hardware e configuração do kernel. 

| Arquivo            | Informação       |
| ------------------ | ---------------- |
| `cat /proc/cpuinfo`    | CPU              |
| `cat /proc/meminfo`    | Memória          |
| `cat /proc/partitions` | Partições        |
| `cat /proc/uptime`     | Tempo ligado     |
| `cat /proc/version`    | Versão do kernel |

> Comando para verificar qual shell está disponível no sistema: **`chsh -l`** ou **`cat /etc/shells`**.

`/bin/ls`, `/usr/bin/grep` -> Diretórios no linux para armazenar arquivos executáveis (binários) de comandos que os usuários e o sistema podem utilizar.

`/etc/shadow` -> Armazena senhas de usuários de forma criptografada, junto com outras informações como data de validade da senha e configurações de segurança
## 2. Instalação de Pacotes e Gerenciamento de Pacotes (Linux Installation and Package Management)

- Instalar e remover pacotes com RPM e DEB.
- Trabalhar com apt, yum, zypper e gerenciadores de pacotes locais.
- Consultar informações de pacotes.
- Resolver dependências de pacotes.

## 3. Comandos GNU e Unix (GNU and Unix Commands)

- Trabalhar com arquivos e diretórios (ls, cp, mv, rm, find, locate).
- Manipulação de texto (cat, less, more, grep, cut, sort, awk, sed).
- Gerenciamento de processos (ps, top, kill, nice, jobs, fg, bg).
- Redirecionamento de entrada/saída e pipes.
- Comandos de compressão (tar, gzip, bzip2, zip).

## 4. Dispositivos, Sistemas de Arquivos Linux e Hierarquia FHS (Devices, Linux Filesystems, Filesystem Hierarchy Standard)

- Criar, montar e desmontar sistemas de arquivos.
- Ferramentas de disco (fdisk, parted, df, du).
- Permissões e propriedades de arquivos (chmod, chown, chgrp).
- Sistema de arquivos padrão e hierarquia Linux (FHS).

# Exame 102:

## 1. Shells, Scripts e Gerenciamento de Dados (Shells, Scripting and Data Management)

- Shells e inicialização.
- Scripts básicos em Bash.
- Redirecionamento e uso de variáveis.
- Trabalhar com streams e filtros.

## 2. Interfaces de Usuário e Ambiente do Desktop (User Interfaces and Desktops)

- Configuração de variáveis de ambiente.
- Configuração de perfis de usuário.
- Instalação e configuração de ambientes gráficos.

## 3. Tarefas Administrativas (Administrative Tasks)

- Gerenciar contas de usuário e grupos.
- Modificar senhas.
- Planejamento e automação de tarefas (cron, at).
- Backup e restauração de dados.
- Política de segurança básica.

## 4. Serviços Essenciais do Sistema (Essential System Services)

- Gerenciar impressoras (CUPS).
- Agendamento de serviços e logs.
- Sincronização de horário (ntp/chrony).
- Diagnóstico de logs do sistema.

## 5. Fundamentos de Rede (Networking Fundamentals)

#### Configuração de rede TCP/IP.
#### Ferramentas de rede (ping, netstat, ss, ip, route).
#### Diagnóstico básico de rede.
#### Configuração de hosts, DNS e roteamento básico.

## 6. Segurança (Security)

#### Princípios básicos de segurança.
#### Configuração de permissões e ownership.

Os níveis de permissão em arquivos no Linux são organizados em dois tipos principais: as categorias de acesso (dono, grupo e outros) e os tipos de permissão (leitura, escrita e execução). As permissões de leitura (\(r\)), escrita (\(w\)) e execução (\(x\)) podem ser combinadas para definir os direitos de cada categoria, sendo \(r=4\), \(w=2\) e \(x=1\) no modo numérico (octal). 

**Categoria de acesso**
Dono (user - u): O proprietário do arquivo ou diretório.
Grupo (group - g): Os usuários que pertencem ao mesmo grupo do proprietário.
Outros (others - o): Todos os outros usuários do sistema. 
**Tipos de permissão**
- Leitura (\(r\)): Permite visualizar o conteúdo do arquivo ou listar os arquivos dentro de um diretório.
- Escrita (\(w\)): Permite modificar o conteúdo do arquivo ou adicionar/remover arquivos em um diretório.
- Execução (\(x\)): Permite executar um script ou um programa. Em diretórios, permite o acesso. 

**Exemplos de combinações**
- Modo simbólico (rwx):
`rwx`: Permissão total (leitura, escrita e execução)
`rw-`: Leitura e escrita, mas não pode executar
`r-x`: Leitura e execução, mas não escrita
`r--`: Apenas leitura
- Modo octal (numérico): Cada categoria (dono, grupo, outros) tem um número que é a soma das permissões concedidas.
4 = r (leitura), 2 = w(escrita), 1 =  x (execução)

**Exemplo: `$755` siginifica:**
- Dono: 7 (4 + 2 + 1) = leitura, escrita e execução
- Grupos: 5 (4 + 1) = leitura e execução
- Outros: 5 (4 + 1) = leitura e execução

**Exemplo: `$644` significa:**
- Dono: 6 (4 + 2) = leitura e escrita
- Grupos: 4 = leitura
- Outros: 4 = leitura
Exemplo: 
```bash
ls -l     # Visualizar as permissões e a propriedade de arquivos e diretórios
```
Saída: `-rwxr-xr-- 1 usuario grupo 4096 Nov 27 08:43 nome_do_arquivo.txt`
- rwx → permissões do dono (ler, escrever, executar)
- r-x → permissões do grupo (ler, executar)
- r-- → permissões de outros usuários (apenas ler)

> O primeiro caractere (-) indica o tipo de arquivo: (`-` arquivo comum), (`-d` diretório), (`-l` link simbólico)


#### Uso de sudo.
#### Criptografia básica (gpg, ssh).
#### Firewalls simples (iptables, ufw).