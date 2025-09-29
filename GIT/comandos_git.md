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

## ⚡ Comandos avançados em GIT

| Comando                           | Descrição                                                                             |
| --------------------------------- | ------------------------------------------------------------------------------------- |
| `git log --oneline --graph --all` | Mostra o histórico de commits de forma resumida, em formato de grafo.                 |
| `git diff`                        | Mostra as diferenças entre o que foi modificado e o que está no último commit.        |
| `git stash`                       | Salva alterações não commitadas de forma temporária (como um rascunho).               |
| `git stash pop`                   | Recupera alterações salvas com `stash`.                                               |
| `git reset --hard <hash>`         | Volta o repositório para um commit específico, apagando alterações locais. ⚠️         |
| `git revert <hash>`               | Desfaz um commit específico criando um novo commit que reverte as mudanças.           |
| `git cherry-pick <hash>`          | Aplica um commit de outra branch no seu histórico atual.                              |
| `git rebase -i HEAD~3`            | Permite reescrever o histórico dos últimos 3 commits (editar, unir, excluir).         |
| `git branch -d <nome>`            | Deleta uma branch local.                                                              |
| `git push origin --delete <nome>` | Deleta uma branch remota.                                                             |
| `git tag -a v1.0 -m "versão 1.0"` | Cria uma tag anotada (geralmente usada em releases).                                  |
| `git push origin v1.0`            | Envia a tag para o repositório remoto.                                                |
| `git fetch --all --prune`         | Atualiza todas as refs locais de branches remotas, removendo as que não existem mais. |

> **Refs** são ponteiros que apontam para commits específicos, EX: 26031f6

### Corrigindo Mensagem de Commit Incorreta no Git

Durante o desenvolvimento de projetos, pode acontecer de você cometer um **commit com a mensagem errada**. Felizmente, o Git permite corrigir isso facilmente.  

---

#### 1. Alterar a mensagem do **último commit**

  Se o commit incorreto é o mais recente, utilize:
  
  ```bash
  git commit --amend
  ```
  Passos:
  - O Git abrirá o editor configurado (normalmente o Vim) com a mensagem atual do commit.
  - Edite a mensagem do commit.
  - Caso o commit já tenha sido enviado ao GitHub, force o push:
  ```
  git push --force
  ```
#### 2. Alterar a mensagem de commits antigos
Se o commit errado não é o último, use rebase interativo:
```
git rebase -i HEAD~N
```
> Substitui `N` pelo número de commits que deseja revisar.

- No editor que abrir:
- Troque pick por reword no commit cuja mensagem deseja alterar.
- Salve e feche o editor.
- O Git abrirá o editor novamente para você modificar a mensagem.
- Após alterar todas as mensagens desejadas, finalize o rebase:
```
git rebase --continue
```
- Para commits já enviados para o GitHub, force o push:
```
git push --force
```