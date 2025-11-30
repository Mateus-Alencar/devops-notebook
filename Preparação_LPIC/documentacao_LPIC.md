# Exame 101
## 1. Arquitetura do Sistema (System Architecture)

A arquitetura Linux é um design modular centrado em um kernel monolítico que pode carregar módulos de forma flexível. Ele é dividido em kernel space (o núcleo, que gerencia o hardware) e user space (onde os aplicativos rodam), com o kernel agindo como a ponte entre o hardware e o software.

Comando usado para exibir informações sobre o sistema operacional, como o nome do kernel, a versão do kernel, o tipo de máquina, o nome da rede e o tipo de processador: 
`uname`: Retorno: `x86_64`
  - `uname -a`: Mostra todas as informações do sistema.
  - `uname -r`: Exibe a versão do kernel.
  - `uname -n`: Mostra o nome da rede do sistema (hostname).
  - `uname -m`: Exibe o tipo de máquina (hardware).
  - `uname -p`: Mostra o tipo de processador (CPU).

#### Determinar e configurar hardware e software do sistema.
#### Inicialização do sistema e processos.
#### Níveis de execução (runlevels).
#### Uso de dmesg, uname e outros comandos para diagnóstico do sistema.

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

- Configuração de rede TCP/IP.
- Ferramentas de rede (ping, netstat, ss, ip, route).
- Diagnóstico básico de rede.
- Configuração de hosts, DNS e roteamento básico.

## 6. Segurança (Security)

- Princípios básicos de segurança.
- Configuração de permissões e ownership.
- Uso de sudo.
- Criptografia básica (gpg, ssh).
- Firewalls simples (iptables, ufw).