# 🧠 Principais Comandos Git

## 📦 Inicialização e Configuração
- `git init`  
  Inicia um repositório Git local.
  
- `git config --global user.name "Seu Nome"`  
  Define seu nome de usuário global.

- `git config --global user.email "seu@email.com"`  
  Define seu e-mail global para commits.

---

## 🔍 Verificações
- `git status`  
  Mostra o estado atual do repositório.

- `git log`  
  Lista o histórico de commits.

- `git diff`  
  Mostra as diferenças entre arquivos modificados.

---

## 📝 Commits
- `git add nome_arquivo`  
  Adiciona arquivo à área de staging.

- `git add .`  
  Adiciona todas as alterações.

- `git commit -m "mensagem"`  
  Cria um commit com a mensagem.

---

## 🔄 Sincronização com Repositório Remoto
- `git remote add origin URL`  
  Conecta o repositório local a um remoto.

- `git push -u origin main`  
  Envia commits para o repositório remoto.

- `git pull origin main`  
  Baixa e aplica atualizações do repositório remoto.

---

## 🌿 Branches
- `git branch`  
  Lista as branches locais.

- `git branch nome`  
  Cria uma nova branch.

- `git checkout nome`  
  Muda para a branch desejada.

- `git checkout -b nome`  
  Cria e muda para nova branch.

- `git merge nome`  
  Mescla a branch "nome" na branch atual.

- `git branch -d nome`  
  Deleta a branch.

---

## 🧽 Outros Comandos Úteis
- `git clone URL`  
  Clona um repositório remoto.

- `git stash`  
  Salva temporariamente alterações não commitadas.

- `git reset --hard`  
  Desfaz alterações e retorna ao último commit.

- `git revert hash_commit`  
  Reverte um commit específico (mantendo histórico).

---

## 💡 Dica
Use `git --help` ou `git comando --help` para ver mais detalhes.