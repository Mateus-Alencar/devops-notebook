# Comandos Essenciais do Terminal do Windows (CMD e PowerShell)

## 📁 Navegação entre diretórios

| Comando             | Descrição                                   |
|---------------------|---------------------------------------------|
| `cd`                | Navega entre pastas                         |
| `cd ..`             | Volta um nível na hierarquia                |
| `dir`               | Lista arquivos e pastas no diretório atual |
| `cls`               | Limpa a tela do terminal                   |
| `tree`              | Exibe estrutura de diretórios em árvore     |

## 📂 Manipulação de arquivos e pastas

| Comando                             | Descrição                                   |
|-------------------------------------|---------------------------------------------|
| `mkdir nome_pasta`                  | Cria uma nova pasta                         |
| `rmdir nome_pasta` ou `rd`          | Remove uma pasta vazia                      |
| `del arquivo.txt`                   | Exclui um arquivo                           |
| `copy origem destino`               | Copia arquivos                              |
| `xcopy origem destino /s /e`        | Copia arquivos e pastas                     |
| `move origem destino`               | Move arquivos                               |
| `ren antigo.txt novo.txt`           | Renomeia arquivos                           |

## ⚙️ Informações do sistema

| Comando         | Descrição                              |
|------------------|------------------------------------------|
| `systeminfo`     | Exibe detalhes do sistema               |
| `hostname`       | Exibe o nome do computador              |
| `echo %username%`| Mostra o nome do usuário atual          |
| `ipconfig`       | Exibe informações de rede               |
| `tasklist`       | Lista processos em execução             |
| `taskkill /PID 1234 /F` | Encerra processo pelo ID          |

## 📦 Gerenciamento de programas

| Comando                   | Descrição                              |
|---------------------------|----------------------------------------|
| `choco install nome`      | Instala um programa com Chocolatey     |
| `winget install nome`     | Instala um programa com o Winget       |
| `start nome_arquivo.exe`  | Executa um programa                    |

## 🔐 Usuários e permissões

| Comando                         | Descrição                                 |
|----------------------------------|-------------------------------------------|
| `net user`                      | Lista usuários do sistema                 |
| `net user nome /add`           | Adiciona novo usuário                     |
| `net localgroup administrators nome /add` | Torna o usuário administrador      |

## 💾 Disco e arquivos

| Comando         | Descrição                               |
|------------------|-------------------------------------------|
| `diskpart`       | Gerenciador de discos                    |
| `format`         | Formata partições (com cautela!)         |
| `chkdsk`         | Verifica o disco por erros               |
| `sfc /scannow`   | Verifica e repara arquivos do sistema    |

## 🔄 Outros úteis

| Comando               | Descrição                                 |
|------------------------|-------------------------------------------|
| `exit`                | Fecha o terminal                          |
| `help`                | Mostra ajuda para comandos do Windows     |
| `assoc`               | Mostra associações de extensões de arquivos |
| `set`                 | Mostra variáveis de ambiente              |
| `echo`                | Exibe mensagens no terminal               |
| `powershell`          | Abre o terminal PowerShell                |

---



