## Sumário

- [Diferenças entre terminal e shell](#diferencas-entre-terminal-e-shell)
- [Variáveis em Shell](#variaveis-em-shell)
- [Entendendo o Prompt do terminal linux](#entendendo-o-prompt-do-terminal-linux)
- [Navegação e manipulação de arquivos](#navegacao-e-manipulacao-de-arquivos)
  - [GREP](#grep)
- [Informações do sistema](#informacoes-do-sistema)
- [Gerenciamento de usuários](#gerenciamento-de-usuarios)
- [Processos e serviços](#processos-e-servicos)
- [Rede](#rede)
- [Gerenciamento de pacotes (Debian/Ubuntu)](#gerenciamento-de-pacotes-debianubuntu)
- [Permissões e acesso](#permissoes-e-acesso)
- [Limpeza e manutenção](#limpeza-e-manutencao)
- [Atalhos úteis](#atalhos-uteis)
- [Vim](#vim)



# Comandos Essenciais do Terminal Linux (Servidor)

Este documento reúne os **principais comandos usados em servidores Linux**, com foco em administração, rede, manipulação de arquivos, processos e pacotes.

> Sintaxe padrão para comandos no Linux: COMANDO -OPCOES ARQUIVOS/DIRETORIOS
---
### Diferenças entre terminal e shell

Um terminal é a aplicação gráfica que fornce uma janela para interação, é um font-end para o shell. 
O Shell, é o programa que interpreta e executa os comandos do utilizador, interagindo com o kernel do sistema operativo.

**SHELL dentro do sistema**
```
4 -             Programas/Comandos
3 -  SHELL - interpretador de comandos / bibliotecas
2 -                   Kernel
1 -                  Hardware
```
> Comando para verificar qual shell está disponível no sistema: **chsh -l** ou **cat /etc/shells**

Quando o shell bash é executado após o usuário fazer login no sistema o mesmo aguarda um ou mais comandos na entrada pardrão para interagir com o sistema, este comandos podem ser:

- **Internos (Builtins) -** Estes comandos fazem parte do interpretador de comandos bash, ou seja, estão imbutidos no bash, e quando são executados são lidos antes de qualquer outro comando externo.

- **Externos** Estes tipos de comandos são programas armazenados no HD e precisam ser chamados por linha de comando informando o caminho absoluto ou o diretório que o armazena pode está dentro da variável **PATH**.

> Para saber se o comando é externo ou interno(builtin) execute o  **comando type**, por exemplo.

### Variáveis em Shell
Quando falamos em variáveis em "shell" temos que ter em mente a divisão entre variáveis locais e de ambiente (ou globais). A diferença entre elas é que uma variável locla tem visibilidade restrita, apenas a sessão do shell onde ela foi definida, e uma variável de ambiente tem visibilidade não só na sessão do shell em que foi definida mas também em ambientes derivados, ou seja, subshells.

O comando **echo** é utilizado para exibir um texto ou conteúdo na tela, por exemplo para exibir o conteúdo de uma variável.
> EX: echo $PATH
```
echo $HOME      # Diretório home do usuário
echo $PATH      # Caminhos de diretórios para buscar executáveis
echo $USER      # Nome do usuário logado
```

" var " -> Consegue ler o conteúdo das variáveis
' var ' -> Não interpreta os valores das variáveis
```
 EX: echo "print de uma variável chamada UID: $ UID" --> nesse caso é realizado a leitura da variával 
     echo 'print de uma variável chamada UID: $ UID'
```

### Variáveis especiais do shell Linux

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
for arg in "$@"; do echo "$arg"; done
echo "Todos os argumentos: $*"
ls arquivo_inexistente; echo "Status: $?"
echo "último argumento" seguido de echo $_ resulta em último argumento
```

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
### Elementos que compõem um tipo de requisição

**ComandName** (nome do comando): a requisição que o usuário deseja executar;
**Flag** (opção): serve para modificar a operação do comando. Ele pode ser incluído por meio de um ou dois hífens;
**Argument**: usado para adicionar informações à requisição. Não é obrigatório para todos os comandos. 

### Estrutura de Diretórios Importantes
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
---

## Navegação e manipulação de arquivos

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
#### SPLIT
O comando split no Linux é usado para dividir um arquivo grande em vários arquivos menores. Por padrão, ele divide o arquivo em pedaços de 1.000 linhas, a menos que você especifique um tamanho diferente. O arquivo original não é modificado.
`split [OPÇÕES] [ARQUIVO] [PREFIXO]` 
- [ARQUIVO]: O nome do arquivo grande a ser dividido.
- [PREFIXO]: O prefixo para os nomes dos novos arquivos. Se não for especificado, o split usará x como padrão, se quiser expedificar o número e linhas é só usar o prefixo -l seguido pelo número de linhas.

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


#### MOUNT
O comando mount no Linux é usado para montar um sistema de arquivos, tornando um dispositivo de armazenamento (como um pendrive, partição ou imagem ISO) acessível no sistema de arquivos hierárquico do Linux. Para usá-lo, você especifica o dispositivo e um ponto de montagem, que é um diretório vazio onde o conteúdo do dispositivo será exibido. Se o comando for executado sem parâmetros, ele lista todos os dispositivos já montados. 

Sintaxe básica: `mount [opções] <dispositivo> <ponto_de_montagem>`
mount [opções] <dispositivo> <ponto de montagem>

> Montar uma partição em um diretório: Para montar a partição /dev/sdb1 no diretório /mnt, execute:
`sudo mount /dev/sdb1 /mnt`

#### quoting
O **quoting" no Linux é o ato de usar caracteres especiais, como aspas (simples, duplas ou backticks) e a barra invertida, para instruir o shell a tratar o texto de forma literal, ignorando seu significado especial e evitando a interpretação de comandos, variáveis ou caracteres especiais.
- Aspas Simples ('): Protegem todo o texto entre elas, tratando-o como um literal.
- Aspas Duplas ("): Protegem o texto, mas permitem a expansão de variáveis (como $USER) e a      substituição de comandos (usando $(comando)). Elas também desabilitam o significado especial de curingas (como * ou ?). 
EX: `echo "Olá, $USER!"` imprimirá "Olá, [nome do usuário]!"
- Backticks (`` ` ``): São usados para executar um comando e substituir o texto entre eles pelo resultado desse comando. 
EX: ` echo "O diretório atual é: $(pwd)" `

> ` ls -l "/caminho/do meu/diretorio" ` é igual a: ` ls -l /caminho/do\ meu/diretorio `
---

## Informacoes do sistema

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
tail -f /var/log/syslog   # Acompanha logs em tempo real.
man <comando>             # É usado para exibir as páginas de manual de qualquer outro comando
apropos list directory    # É usado para pesquisar nas páginas de manual (man pages) por comandos cujas descrições contêm uma palavra-chave.
```
### TAIL
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


### HASH

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

---


## Vim

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

