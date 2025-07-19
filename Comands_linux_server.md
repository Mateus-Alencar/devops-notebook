
# 🖥️ Comandos Essenciais do Terminal Linux (Servidor)

Este documento reúne os **principais comandos usados em servidores Linux**, com foco em administração, rede, manipulação de arquivos, processos e pacotes.

---

## 📁 Navegação e manipulação de arquivos

```bash
ls -lh             # Lista arquivos com detalhes e tamanhos legíveis
cd /caminho        # Entra em um diretório
pwd                # Mostra o diretório atual
mkdir nome         # Cria um diretório
rm arquivo         # Remove um arquivo
rm -r pasta        # Remove uma pasta e tudo dentro dela
cp origem destino  # Copia arquivos ou diretórios
mv origem destino  # Move ou renomeia arquivos/pastas
touch nome.txt     # Cria um novo arquivo vazio
cat arquivo.txt    # Mostra o conteúdo de um arquivo
less arquivo.log   # Visualiza arquivo com rolagem (para logs grandes)
```

---

## 🧠 Informações do sistema

```bash
uname -a           # Informações do kernel e arquitetura
uptime             # Tempo de atividade do sistema
top                # Monitoramento em tempo real de processos
htop               # Versão aprimorada do top (pode precisar instalar)
free -h            # Uso de memória
df -h              # Espaço em disco
du -sh pasta/      # Tamanho da pasta
```

---

## 👥 Gerenciamento de usuários

```bash
whoami             # Mostra o usuário atual
adduser nome       # Adiciona novo usuário
passwd nome        # Altera senha de um usuário
usermod -aG grupo nome # Adiciona usuário a um grupo
deluser nome       # Remove um usuário
groups nome        # Mostra os grupos de um usuário
```

---

## ⚙️ Processos e serviços

```bash
ps aux             # Lista todos os processos
kill PID           # Envia sinal para finalizar processo
kill -9 PID        # Finaliza forçadamente um processo
systemctl status nome    # Verifica status de um serviço
systemctl start nome     # Inicia um serviço
systemctl stop nome      # Para um serviço
systemctl restart nome   # Reinicia um serviço
systemctl enable nome    # Ativa serviço na inicialização
```

---

## 🌐 Rede

```bash
ip a               # Mostra interfaces de rede e IPs
ping 8.8.8.8       # Testa conectividade com destino
curl http://site   # Faz uma requisição HTTP
wget url           # Baixa um arquivo via terminal
netstat -tuln      # Lista portas em uso (pode ser necessário instalar)
ss -tuln           # Alternativa moderna ao netstat
```

---

## 📦 Gerenciamento de pacotes (Debian/Ubuntu)

```bash
apt update                 # Atualiza lista de pacotes
apt upgrade                # Atualiza pacotes instalados
apt install nome           # Instala pacote
apt remove nome            # Remove pacote
apt purge nome             # Remove completamente (incluindo configs)
apt autoremove             # Remove pacotes não utilizados
```

---

## 🔐 Permissões e acesso

```bash
chmod +x script.sh         # Torna o arquivo executável
chown user:grupo arquivo   # Altera dono e grupo de um arquivo
sudo comando               # Executa comando como root
su -                       # Troca para o usuário root
```

---

## 🧹 Limpeza e manutenção

```bash
history                    # Mostra histórico de comandos
clear                      # Limpa a tela do terminal
journalctl -xe             # Ver logs do sistema
```

---

## 🐚 Atalhos úteis

- `TAB` → Autocompleta comandos e nomes de arquivos
- `CTRL + C` → Interrompe um comando em execução
- `CTRL + L` → Limpa a tela (igual `clear`)
- `CTRL + R` → Busca no histórico de comandos
