
# 🖥️ Comandos Essenciais do Terminal Linux (Servidor)

Este documento reúne os **principais comandos usados em servidores Linux**, com foco em administração, rede, manipulação de arquivos, processos e pacotes.

> Sintaxe padrão para comandos no Linux: COMANDO -OPCOES ARQUIVOS/DIRETORIOS
---

## 🐧 Entendendo o Prompt do terminal linux

### `mateus@linux_server:~$`
  - **`mateus` (antes do @)** → Nome do usuário logado.
  - **`linux_server` (depois do @)** → Nome do computador/host.
  - **`$`** → Indica que o usuário logado é **comum (não root)**.

### `root@linux_server:/home/mateus#`
- **`root`** → Agora o terminal está logado como o superusuário (**administrador do sistema**).
- **`linux_server`** → Nome do host (computador).
- **`/home/mateus`** → Diretório atual continua o mesmo.
- **`#`** → Indica que o shell atual é de um **usuário root** (diferente do `$`, que é para usuário comum).

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

## 🗒️ Vim

O vim é uma versão melhorada do vi. Ele não está em 100% das distros por padrão, mas está presente na grande maioria das distribuições modernas (Ubuntu, Debian, Fedora, CentOS, Arch, etc.). Ele é rápido, leve, roda no terminal e é extremamente poderoso para edição de arquivos de texto e código.

>Abertura de arquivos: `vim arquivo.txt`

- Normal → Navegação e execução de comandos (modo inicial).
- Inserção (Insert) → Edição de texto (tecla i entra nesse modo).
- Linha de comando (Command-line) → Para salvar, sair, buscar, etc. (ativado com `:` ).
    - :q → sair (se não houver alterações).
    - :q! → sair sem salvar.
    - :wq ou :x → salvar e sair.
    - ZZ → salvar e sair (atalho, em maiúsculo).

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

