## Sumário
1. Introdução ao Ansible
2. Conceitos principais
3. Funcionamento
4. ansible.cfg e configuração
5. Inventário
6. Variáveis
7. Playbooks
8. Módulos e Pacotes
9. Collections
10. Roles
11. Ansible-doc
12. Exemplos práticos


## Ansible
O Ansible oferece automação de código que reduz a complexidade e pode ser executado em qualquer lugar. Usar o Ansible permite automatizar praticamente qualquer tarefa. Ele se conecta aos servidores de destino (nós) remotamente, via SSH para sistemas Unix e via Windows Remote Management para Windows, utilizando os módulos para realizar as ações.

> O Ansible automatiza o gerenciamento de sistemas remotos e controla seu estado desejado.

Casos de uso com Ansible:
- Eliminação de repetições e simplificação dos fluxos de trabalho
- Gerenciar e manter a configuração do sistema
- Implementação de software complexo de forma contínua
- Execução de atualizações contínuas sem tempo de inatividade

> 👉 O Ansible usa scripts chamados de `playbooks`

### Conceitos principais do Ansible
| Conceito     | Descrição resumida                           |
| ------------ | -------------------------------------------- |
| Idempotência | Executar várias vezes não altera o resultado |
| Agentless    | Não requer agente, usa SSH/WinRM             |
| Playbook     | Arquivo YAML com instruções declarativas     |
| Inventário   | Lista de hosts ou grupos gerenciados         |
| Módulo       | Unidade de ação executada em um host         |
| Task         | Execução de um módulo com parâmetros         |
| Role         | Estrutura modular de automação reutilizável  |
| Collection   | Pacote que reúne roles, módulos e plugins    |
| Ad-hoc       | Execução rápida de comandos sem playbook     |


![alt text](Imagens/image.png)

#### Funcionamento
- Desenvolvido em Python
  - Pyhton >=3.5 ou Python >=2.7
  - Procura sempre o interpretador em /usr/bin/python
- Utiliza a variável ansible_python_interpreter para configurar o PATH
- Por padrão, utiliza-se do serviço SSH para comunicação com seus targets (servidores
- Unix Like, Roteadores, Switches) 
- Para servidores Micro$oft Window$, utiliza-se do WinRM para comunicação
sks, Handlers, Variáveis, Templates, entre outros.

![alt text](Imagens/image-1.png)

##### Utilitário ansible-config
- Comando utilizado para realizar a criação e/ou alteração do arquivo ansible.cfg
- Permite a visualização de todas as configurações padrões aplicadas ao Ansible
Sintaxe: `ansible-config [opções] [argumentos]`
Opções:
- list: Exibe todas as configurações disponíveis
- dump: Exibe todas as configurações disponíveis, e cruza com as aplicadas no arquivo ansible.cfg
- view: Exibe as configurações dentro do arquivo ansible.cfg
- init: cria um arquivo de configurações inicial

``` bash
Plugins disponíveis no ansible.cfg:
- base       # define funcionalidades fundamentais para outros plugins Ansible.
- become     # escalonar privilégios, permite executar comandos com permissões elevadas (sudo, su).
- cache      # gerencia o cache de fatos (facts) coletados para acelerar execuções futuras.
- callback   # controla a saída do Ansible, permite customizar como os resultados são exibidos.
- cliconf    # configuração de dispositivos de rede via CLI (interface de linha de comando).
- connection # gerencia o método de conexão com os hosts remotos (SSH, local, paramiko, etc).
- httpapi    # permite comunicação com dispositivos via APIs HTTP/REST.
- inventory  # obtém e gerencia o inventário de hosts, podendo ser estático ou dinâmico.
- lookup     # busca dados de diferentes fontes (arquivos, variáveis, bases externas).
- netconf    # comunicação com dispositivos de rede via protocolo NETCONF.
- shell      # executa comandos shell nos hosts remotos como parte da conexão.
- vars       # gerencia variáveis dentro do Ansible, permitindo manipulação e definição.
```
### Guia passo a passo para configurar um control node do zero

**Instalar o Ansible**
🐧 No Ubuntu / Debian
```bash
sudo apt update
sudo apt install -y ansible
```
ou
```bash
python3 -m pip install --user ansible
ansible --version
```

**Criar o inventário de hosts**

Crie o arquivo /etc/ansible/hosts
```bash
[webservers]
192.168.56.101
192.168.56.102

[dbservers]
192.168.56.201
```

**Configurar acesso SSH**

O Ansible usa SSH para conectar-se aos nós gerenciados.

1. Gere uma chave SSH:
`ssh-keygen -t ed25519`
2. Copie a chave pública para cada servidor:
```bash
ssh-copy-id usuario@192.168.56.101
ssh-copy-id usuario@192.168.56.102
```
> Testar acessso: `ssh usuario@192.168.56.101`

3. Testar a comunicação com o Ansible: `ansible all -m ping -u usuario`

4. Montar o arquivo ansible.cfg, ele é um dos arquivos mais importantes do Ansible, pois define como o Ansible se comporta (onde está o inventário, opções SSH, controle de privilégios, cache, etc).

O Ansible lê o arquivo de configuração em ordem de prioridade, do mais específico para o mais genérico:

| Prioridade | Local    | Descrição        |
| ---------- | -------------------------- | ------------------------------- |
| 1️⃣        | Variável de ambiente `ANSIBLE_CONFIG` | Se você definir manualmente `export ANSIBLE_CONFIG=/caminho/para/ansible.cfg` |
| 2️⃣        | `./ansible.cfg`                       | No diretório atual onde você executa o comando                                |
| 3️⃣        | `~/.ansible.cfg`                      | No diretório *home* do seu usuário                                            |
| 4️⃣        | `/etc/ansible/ansible.cfg`            | Arquivo global do sistema                                                     |

Na prática, é comum criar um arquivo por projeto, dentro do diretório onde estão seus playbooks.

```bash
mkdir -p ~/ansible-project
cd ~/ansible-project
touch ansible.cfg
```

##### Exemplo de arquivo ansible.cfg
```bash
# Ansible Configuration File: ansible.cfg

[defaults]

#--- General settings
forks                   = 5               # Número de tarefas paralelas que o Ansible executa
log_path                = /var/log/ansible.log  # Caminho para o log do Ansible
executable              = /bin/bash       # Shell a ser usado nos hosts remotos
ansible_managed         = Ansible managed # Texto padrão adicionado a arquivos gerenciados

#--- Files/Directory settings
inventory               = /etc/ansible/hosts  # Arquivo ou diretório com a lista de hosts
library                 = /usr/share/my_modules  # Diretório de módulos customizados
remote_tmp              = ~/.ansible/tmp   # Diretório temporário nos hosts remotos
local_tmp               = ~/.ansible/tmp   # Diretório temporário local
roles_path              = /etc/ansible/roles  # Caminho onde os roles do Ansible estão localizados

#--- Users settings
remote_user             = mateus          # Usuário padrão para conexões SSH
ask_pass                = no              # Não pedir senha de SSH interativamente

#--- SSH settings
remote_port             = 22              # Porta usada para SSH
timeout                 = 10              # Timeout de conexão SSH em segundos
host_key_checking       = False           # Desativa verificação de host key (não recomendado em produção)
ssh_executable          = /usr/bin/ssh    # Caminho para o cliente SSH
private_key_file        = /home/mateus/.ssh/id_ed25519  # Caminho para a chave privada usada na autenticação

[privilege_escalation]

become                  = True            # Permitir elevação de privilégios (sudo)
become_method           = sudo            # Método de elevação de privilégios
become_user             = root            # Usuário alvo após o 'become'
become_ask_pass         = False           # Não pedir senha sudo interativamente

[ssh_connection]

scp_if_ssh              = smart           # Usa scp se possível para transferir arquivos
transfer_method         = smart           # Método de transferência de arquivos
retries                 = 3               # Número de tentativas de conexão SSH antes de falhar

```
>Verificar qual configuração o Ansible está usando:
`ansible-config dump --only-changed` ou `ansible-config list`

**Nó de controle**
- Um sistema no qual o Ansible está instalado. Você executa comandos do Ansible, como `ansible` ou `ansible-inventoryem` um nó de controle.

**Inventário**
- Uma lista de nós gerenciados organizados logicamente. Você cria um inventário no nó de controle para descrever as implantações do host no Ansible.

**Nó gerenciado**
- Um sistema remoto, ou host, que o Ansible controla.


[Documentação Ansible](https://docs.ansible.com/)

Arquivo de inventário:
```bash
192.168.0.197    # Host sem grupo

[target]         # Grupo de hosts chamado target
192.168.0.195    # IP dentro do grupo target
```
> Comando para pegar todos os targets que não estão vinculados a nenhum grupo
`ansible ungrouped -m ping`

> Comando para pegar todos os targets que estão vinculados a um grupo
`ansible <nome-grupo> -m ping`


Exemplos de comandos ad hoc do Ansible:

> Fazer o ping em vários hosts:
`ansible -i /caminho/do/inventario -m ping`

> Verificar o tempo de atividade (uptime) em todos os hosts:
`ansible -i /caminho/do/inventario all -m command -a "uptime"`

> Para verificar o uso de memória:
`ansible -i /caminho/do/inventario all -a "free -m"`

> Para verificar o espaço em disco de todos os hosts:
`ansible -i inventario all -m shell -a "df -h"`

Arquivo inventário:
```bash
[target02]
192.168.0.197

[target01]
192.168.0.195

[linux:children]    
target01
target02

[webservers:children]
target01

# O parâmetro children do arquivo de inventário do Ansible permite organizar seus hosts 
# em uma hierarquia de grupos, criando uma relação de "pai-filho". 
```
versão do arquivo inventário em `.yaml`
```bash
all:
  hosts:
  children:
    target01:
      hosts:
        192.168.0.195:
    target02:
      hosts:
        192.168.0.195:
```

#### Variáveis

Variáveis no Ansible são pares de chave-valor usados para armazenar dados dinâmicos que podem ser reutilizados em playbooks e funções, proporcionando flexibilidade, personalização e reutilização das configurações.

No Ansible, as variáveis podem ser declaradas em diversos locais práticos, cada um com seus usos específicos:

- Dentro do próprio playbook, na seção vars, onde se define diretamente as variáveis aplicáveis naquele playbook. Exemplo:
```bash
- hosts: localhost
  vars:
    nome: Ansible
    versao: 2.9
  tasks:
    - debug:
        msg: "O nome é {{ nome }} e a versão é {{ versao }}"
```
ou 
```bash

[target02]
192.168.0.197

[target01]
192.168.0.195

[linux:children]
target01
target02

[webservers:children]
target01

[target01:vars]

[target02:vars]

# Definição de variáveis no grupo [webservers:vars], onde são declarados ansible_port=22
# e ansible_ssh_user=adm22. Essas variáveis serão aplicadas a todos os hosts dentro do grupo webservers.
[webservers:vars]
ansible_port=22
ansible_ssh_user=adm22
```

> Execute o módulo de debug do Ansible no grupo ou host chamado "target02".
`ansible target02 -m debug -a var=var_teste`
Esse módulo imprime o valor da variável chamada var_teste que está definida para o host ou grupo alvo.

### Ansible Playbooks
- Playbooks do Ansible são conjuntos de instruções (escritas em YAML) que oferecem um gerenciamento de configuração repetível, reutilizável e simples, permitindo o gerenciamento de configurações em diferentes targets de forma simultânea.
- Uma playbook é composta por uma ou mais tarefas, conhecidas como "Plays".
- Playbooks são executadas aplicando o conceito de "Top Down"

##### Estrutura de um playbook

- hosts → onde rodar (grupo do inventário ou host específico)
- become → se precisa de sudo
- tasks → lista de tarefas
- modules → cada tarefa usa um módulo (ex: apt, yum, copy, service, file, etc.)

##### Definição de cada linha na playbook
```yaml
---    # Indica o início do arquivo YAML, padrão para arquivos Ansible playbook.
- name: Update Debian Linux Servers - Starting Deploy #  "name" é uma descrição legível para identificar esse bloco de execução.
  hosts: target02 # Especifica os hosts destino onde as tarefas do play serão executadas.
  tasks:  # Define o início da lista de tarefas que serão executadas neste play.
    - name: APT | Update System # Nome da tarefa específica, para identificar o que será feito nesta etapa.
      ansible.builtin.apt: # Chama o módulo Ansible "apt" (gerenciador de pacotes para distribuições Debian-like) para gerenciar pacotes.
        name: "*" # Indica que a operação deve ser aplicada a todos os pacotes instalados
        state: latest # Define que os pacotes devem ser atualizados para a versão mais recente disponível.
        update_cache: yes # Atualiza o cache dos pacotes antes de realizar a instalação ou atualização.
- name: Update Debian Linux Servers 2 - Starting Deploy
  hosts: target01
  tasks:
    - name: Debian Like | Update System
      ansible.builtin.apt:
        name: "*"
        state: latest
        update_cache: yes
...
```

##### Playbook para instalar Nginx (playbook.yml)
```yaml
- name: Configuração de servidores web
  hosts: webservers
  become: yes   # executa como sudo
  tasks:
    - name: Instalar Nginx
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Garantir que o serviço Nginx está rodando
      service:
        name: nginx
        state: started
        enabled: yes

```

```yaml
# Esse código é um playbook Ansible que executa comandos shell para criar ou atualizar 
# arquivos de texto em hosts específicos. 
---
- name: Update Debian Linux Servers - Starting Deploy
  hosts: target02
  tasks:
    - name: APT | Update System
      ansible.builtin.shell: "echo 'Esse é o target 2' > /tmp/teste.txt"
      become: true

- name: Update Debian Linux Servers 2 - Starting Deploy
  hosts: target01
  tasks:
    - name: Debian Like | Update System
      ansible.builtin.shell: "echo 'Teste' > /tmp/teste.txt"
      become: true

...

```


**Rodar o playbook**: `ansible-playbook -i hosts.ini playbook.yml`
**Rodar uma playbook, onde não tem uma chave ssh configurada**: `ansible-playbook -i inventory/hosts -u adm22 -k -k -b playbooks/1_updateLinux.yml`

##### Exemplo: Criar um usuário em múltiplos servidores
```yaml
- name: Criar usuários em servidores
  hosts: all
  become: yes
  tasks:
    - name: Criar usuário dev
      user:
        name: devuser
        state: present
        groups: sudo

```
```yaml
---
- name: Ansible Prompt | Creating user on Linux
  hosts: all
  vars_prompt:
    - name: username
      prompt: What is your username?
      private: false
    - name: password
      prompt: What is your password?
      private: true # Opcional - default = true
      encrypt: "md5_crypt"
      confirm: yes
    - name: shell
      prompt: What is your shell?
      private: false
  tasks:
      - name: Print a message
        ansible.builtin.debug:
          msg: 'Usuario: {{ username }} | Password: {{ password }} | Shell: {{ shell }}'
      - name: USER | Add user
        ansible.builtin.user:
          name: "{{ username }}"
          comment: "User create by Ansible"
          shell: "{{ shell }}"
          home: "/home/{{ username }}"
          password: "{{ password }}"

...
```


Código para procurar arquivos .cfg em /tmp, salva a lista e mostra só os caminhos desses arquivos para o usuário.

```yaml
---
- name: Ansible Register Filers
  hosts: all
  tasks:
    - name: SISOP | Find files
      find:
        path: /tmp
        patterns: '*.cfg'
      register: output

    - name: SISOP | Show files
      debug:
        msg: "{{ output.files | map(attribute='path') }}"
...
# Essa tarefa usa o módulo debug para mostrar no console os caminhos dos arquivos encontrados
# (armazenados em output.files). O filtro map(attribute='path') é usado para extrair apenas o 
# caminho completo (path) de cada arquivo da lista de arquivos retornados pelo módulo find.
```
Condicionais (when)
```yaml
---
- name: Ansible Conditionals (when)
  hosts: all
  tasks:
    - name: DNF | Update Systems
      ansible.builtin.dnf:
        name: "*"
        state: latest
        update_cache: yes
      when: ansible_distribution == "Rocky"

    - name: APT | Update cache
      ansible.builtin.apt:
        update_cache: yes
      when: ansible_distribution == "Debian"
...
```

### Pacotes

Os pacotes no Ansible são representados principalmente por "módulos", que são trechos de código que executam ações específicas em sistemas gerenciados. 

- Definição de Módulo: Um módulo é um pedaço de código, geralmente escrito em Python, que realiza uma tarefa específica, como instalar pacotes, gerenciar serviços ou copiar arquivos.​

- Uso em Tarefas: Os módulos são utilizados em tarefas dentro de playbooks para aplicar ações em hosts gerenciados. Por exemplo, o módulo apt gerencia pacotes em distribuições baseadas em Debian, enquanto o dnf é usado para Fedora ou RHEL-based.​

> 👉 No Ansible você descreve o estado desejado da infraestrutura, e o Ansible garante que ela vai ficar daquele jeito.

| Módulo           | Sistema compatível                           | Descrição                                      |
| ---------------- | -------------------------------------------- | ---------------------------------------------- |
| `apt`            | Debian, Ubuntu                               | Gerencia pacotes via APT                       |
| `yum`            | CentOS, RHEL, Amazon Linux (versões antigas) | Gerencia pacotes via YUM                       |
| `dnf`            | Fedora, RHEL 8+, Rocky, AlmaLinux            | Gerencia pacotes via DNF                       |
| `zypper`         | openSUSE, SLES                               | Gerencia pacotes via Zypper                    |
| `package`        | Todos os Linux                               | Módulo genérico (usa o gerenciador disponível) |
| `win_chocolatey` | Windows                                      | Gerencia pacotes com Chocolatey                |
| `pip`            | Todos                                        | Gerencia pacotes Python (via pip)              |

```yaml
---
- name: Instalar pacotes no Debian/Ubuntu
  hosts: webservers
  become: yes
  tasks:
    - name: Atualizar o cache de pacotes
      ansible.builtin.apt:
        update_cache: yes

    - name: Instalar pacotes essenciais
      ansible.builtin.apt:
        name:
          - nginx
          - curl
          - git
        state: present
# O parâmetro state: present garante que o pacote esteja instalado. 
# state: latest força a atualização para a versão mais recente.
```
```yaml
---
- name: Criar diretórios para aplicação
  hosts: all
  become: yes
  tasks:
    - name: Criar diretório de logs
      ansible.builtin.file:
        path: /var/log/minha_app
        state: directory
        owner: ubuntu
        group: ubuntu
        mode: '0755'
# Criar diretórios, ajustar permissões ou remover arquivos antigos.
```
```yaml
---
- name: Criar usuários do sistema
  hosts: all
  become: yes
  tasks:
    - name: Criar usuário deploy
      ansible.builtin.user:
        name: deploy
        shell: /bin/bash
        state: present
        groups: sudo
        create_home: yes
# automatizar criação de contas de usuários ou times.
```

```yaml
---
- name: Agendar backup diário
  hosts: all
  become: yes
  tasks:
    - name: Adicionar tarefa no cron
      ansible.builtin.cron:
        name: "Backup diário"
        minute: "0"
        hour: "2"
        job: "/usr/local/bin/backup.sh"
# Criar tarefas agedadas
```

```yaml
---
- name: Clonar projeto do GitHub
  hosts: webservers
  become: yes
  tasks:
    - name: Baixar código da aplicação
      ansible.builtin.git:
        repo: 'https://github.com/exemplo/meu-projeto.git'
        dest: /var/www/meu-projeto
        version: main
# Deply automático de aplicações.
```

### Collections no Ansible

Collections no Ansible são um formato padronizado para agrupar e distribuir conteúdo de automação, como módulos, plugins, roles e playbooks, em um único pacote. Elas facilitam o compartilhamento, a reutilização e a organização do conteúdo, tornando a automação mais escalável e modular.

```bash
ansible-galaxy collection install <nome_da_collection> # instala uma coleção específica no ambiente local.
ansible-galaxy collection list           #lista todas as collections instaladas no sistema.
ansible-galaxy collection search <termo> # pesquisa collections disponíveis no repositório Ansible Galaxy.
ansible-galaxy collection build          # empacota uma coleção local para distribuição.
ansible-galaxy collection publish        # publica uma coleção no repositório Ansible Galaxy.
```

### Roles no Ansible

No Ansible, roles são uma forma estruturada e modular de organizar automações, agrupando tarefas, variáveis, handlers, templates, arquivos e meta-informações em uma estrutura padrão de diretórios. Isso facilita reutilização, manutenção e compartilhamento de conteúdo.

```bash
roles/
  nome_do_role/
    tasks/
      main.yml          # Tarefas principais do role
    handlers/
      main.yml          # Handlers, ex: restart serviços
    templates/          # Arquivos Jinja2 para templates
    files/              # Arquivos estáticos para copiar
    vars/
      main.yml          # Variáveis específicas do role
    defaults/
      main.yml          # Variáveis padrão do role (menos prioridade)
    meta/
      main.yml          # Dependências e metadados
```

Para usar um Ansible Role, basta referenciá-lo em um playbook. Você pode listá-lo com a opção roles ou adicioná-lo à seção de tarefas de role com os comandos include_role, ou import_role. Os roles listados por meio da opção roles ou adicionados via import_role são executados antes das outras tarefas em um play. Ao listá-los utilizando include_role, os roles são executados na ordem definida na lista de tarefas.


### Ansible-doc

Comando para acessar a documentação de plugins (módulos) do ansible: 
`ancible-doc -h`

Plugins (módulos) disponíveis no ambiente: `ansible-doc -l`

Exemplo de pesquisa por um módulo em especifico: `ansible-doc -l -t shell`
Retorno: 
```bash
ansible.builtin.cmd        Windows Command Prompt
ansible.builtin.powershell Windows PowerShell
ansible.builtin.sh         POSIX shell (/bin/sh)
ansible.posix.csh          C shell (/bin/csh)
ansible.posix.fish         fish shell (/bin/fish)
```

comando para listar todos os hosts do inventário: `ansible-inventory -i invetory/hosts --list`. # o comando `-i <caminho do host>` serve para passar o caminho do host apartir do etc/ansible/.


### Criptografia no Ansible

A criptografia no Ansible é realizada principalmente pelo Ansible Vault, uma ferramenta que permite criptografar e descriptografar dados sensíveis, como senhas e chaves, em arquivos inteiros, playbooks ou variáveis individuais. Ele usa o algoritmo AES 256 para criptografia simétrica e exige uma senha para criptografar e descriptografar os dados. 

`ansible-vault encrypt_string <password_source> '<string_to_encrypt>' --name '<string_name_of_variable>'`

> Visualizar arquivo criptografado:
`ansible-vault view foo.yml`

> Editar arquivo criptografado:
`ansible-vault edit foo.yml`