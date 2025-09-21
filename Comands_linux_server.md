
# 🖥️ Comandos Essenciais do Terminal Linux (Servidor)

Este documento reúne os **principais comandos usados em servidores Linux**, com foco em administração, rede, manipulação de arquivos, processos e pacotes.

> Sintaxe padrão para comandos no Linux: COMANDO -OPCOES ARQUIVOS/DIRETORIOS
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
grep "palavra" /etc/arquivo.txt # Busca texto em arquivos.
find /home -name "documento.txt" #Localiza arquivos.
```

### GREP
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
ps aux             # Lista todos os processos 
ps aux | grep nginx #verificar se o serviço/processo nginx está em execução no sistema
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
chmod +x script.sh # Dá permissão de execução
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
#### `systemctl` - Gerenciar serviços (SystemD)
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

---

## Diferenças entre terminal e shell

Um terminal é a aplicação gráfica que fornce uma janela para interação, é um font-end para o shell. 
O Shell, é o programa que interpresa e executa os comandos do utilizador, interagindo com o kernel do sistema operativo.