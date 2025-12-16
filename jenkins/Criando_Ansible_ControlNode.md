## Cenário final
- Servidor Ansible (control node)
- Usuário: `jenkins`
- Targets: (hosts gerenciados):
  - 192.168.100.200
  - 192.168.100.201
  - 192.168.100.202
- Acesso: SSH por chave

### Instalar o Ansible no servidor control node
```bash
sudo apt update
sudo apt install ansible -y
```
### Criar usuário `jenkins` no servidor control node
```bash
sudo adduser jenkins
su - jenkins
```
### Gerar chave SSH para o usuário jenkins no control node
```bash
ssh-keygen -t rsa -b 4096
```
Isso cria:
- Chave pública: ~/.ssh/id_rsa.pub
- Chave privada: ~/.ssh/id_rsa
### Criar usuário jenkins nos targets
```bash
sudo adduser jenkins
sudo userrmod -aG sudo jenkins
groups jenkins
```
### Copiar a chave SSH para os targets
```bash
ssh-copy-id jenkins@192.168.100.200
ssh-copy-id jenkins@192.168.100.201
ssh-copy-id jenkins@192.168.100.202
# Teste o acesso
ssh jenkins@192.168.100.200
```
### Criar o arquivo de inventário do Ansible
```bash
mkdir home/jenkins/ansible
cd home/jenkins/ansible
vim hosts.ini
```
Conteúdo:
```yaml
[targets]
192.168.100.200
192.168.100.201
192.168.100.202
```
### Configurar o Ansible para usar o usuário jenkins
```bash
cd home/jenkins/ansible/
vim ansible.cfg
```
```yaml
[defaults]
inventory = hosts.ini
remote_user = jenkins
host_key_checking = False
```
### Testar configurações
```bash
ansible targets -m ping
# OU
ansible targets -a "hostname"
```