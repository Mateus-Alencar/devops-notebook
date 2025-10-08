## Ansible
O Ansible automatiza o gerenciamento de sistemas remotos e controla seu estado desejado.

**Nó de controle**
- Um sistema no qual o Ansible está instalado. Você executa comandos do Ansible, como `ansible` ou `ansible-inventoryem` um nó de controle.

**Inventário**
- Uma lista de nós gerenciados organizados logicamente. Você cria um inventário no nó de controle para descrever as implantações do host no Ansible.

**Nó gerenciado**
- Um sistema remoto, ou host, que o Ansible controla.

O Ansible ofere automação de código que reduz a complexidade e pode ser executado em qualquer lugar. Usar o Ansible permite automatizar praticamente qualquer tarefa. Ele se conecta aos servidores de destino (nós) remotamente, via SSH para sistemas Unix e via Windows Remote Management para Windows, utilizando os módulos para realizar as ações.

Casos de uso com Ansible:
- Eliminação de repetições e simplificação dos fluxos de trabalho
- Gerenciar e manter a configuração do sistema
- Implementação de software complexo de forma contínua
- Execução de atualizações contínuas sem tempo de inatividade

> 👉 O Ansible usa scripts chamados de `playbooks`

Playbooks: São conjuntos de instruções escritas em YAML que descrevem o estado desejado de um sistema. Você escreve o que quer que aconteça, e o Ansible cuida da execução.

### Conceitos principais do Ansible
- Idempotência → se você rodar o mesmo playbook várias vezes, o resultado será sempre o mesmo (não instala pacotes repetidos, por exemplo).
- Agentless → não precisa instalar agente nos servidores; só precisa de SSH e Python básico instalado no destino.
- Playbook → arquivo YAML onde você descreve as tarefas.
- Inventário → lista de servidores onde as tarefas serão aplicadas.
- Módulos → blocos prontos para executar ações (ex: instalar pacotes, copiar arquivos, reiniciar serviços, etc.).

[Documentação Ansible](https://docs.ansible.com/)

#### Playbook para instalar Nginx (playbook.yml)
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
**Rodar o playbook**: `ansible-playbook -i hosts.ini playbook.yml`

#### Estrutura de um playbook

- hosts → onde rodar (grupo do inventário ou host específico)
- become → se precisa de sudo
- tasks → lista de tarefas
- modules → cada tarefa usa um módulo (ex: apt, yum, copy, service, file, etc.)

#### Exemplo: Criar um usuário em múltiplos servidores
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

> 👉 No Ansible você descreve o estado desejado da infraestrutura, e o Ansible garante que ela vai ficar daquele jeito.