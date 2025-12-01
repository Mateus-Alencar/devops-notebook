# Exame 101
## 1. Arquitetura do Sistema (System Architecture)

A arquitetura Linux é um design modular centrado em um kernel monolítico que pode carregar módulos de forma flexível. Ele é dividido em kernel space (o núcleo, que gerencia o hardware) e user space (onde os aplicativos rodam), com o kernel agindo como a ponte entre o hardware e o software.
O Kernel é o coração do Linux e é o componente mais importante. Ele reside em um espaço de memória protegido (o Espaço do Kernel) e atua como uma ponte entre o hardware e o software de aplicação.

O Kernel Linux é classificado como **monolítico modular**:
- Monolítico: Todos os serviços principais (gerenciamento de memória, gerenciamento de processos, sistema de arquivos, drivers de dispositivo) estão contidos em um único programa.
- Modular: Permite que novas funcionalidades (como drivers para novos hardwares) sejam carregadas ou descarregadas dinamicamente como módulos de kernel carregáveis (LKM), sem a necessidade de reiniciar o sistema.

**`uname`**
Comando usado para exibir informações sobre o sistema operacional, como o nome do kernel, a versão do kernel, o tipo de máquina, o nome da rede e o tipo de processador: 
`uname`: Retorno: `x86_64`
  - `uname -a`: Mostra todas as informações do sistema.
  - `uname -r`: Exibe a versão do kernel.
  - `uname -n`: Mostra o nome da rede do sistema (hostname).
  - `uname -m`: Exibe o tipo de máquina (hardware).
  - `uname -p`: Mostra o tipo de processador (CPU).

**`uptime`**
O comando `uptime` exibe o tempo de atividade do sistema, o número de usuários logados e a média de carga do sitema dos últimos 1, 5 e 15 minutos. 
`uptime`: Retorno: `23:03:09 up 2 min,  1 user,  load average: 2.13, 1.64, 0.68`
> Load average é a média de processos em execução ou aguardando por recursos do sistema (como CPU ou disco)

`uptime -p`: Mostra o tempo de atividade em um formato mais legível para os humanos.
`uptime -s`: Exibe a data e hora exatas em que o sistema foi iniciado. no formato `AAAA-MM-DD HH:MM:SS`.

**`top`**
**`htop`**
**`free`**
**`df`**
**`du`**
**`ps`**
**`ps aux`**
**`tail`**
**`man`**
**`apropos`**
**`last`**
**`cat`**
**`lshw`**
**`lsusb`**
**`lspci`**

**Comandos para pegar informações do sistema**

```bash
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

```

#### Determinar e configurar hardware e software do sistema.
#### Inicialização do sistema e processos.
#### Níveis de execução (runlevels).
#### Uso de dmesg, uname e outros comandos para diagnóstico do sistema.
#### Diretórios Linux
![alt text](image.png)

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