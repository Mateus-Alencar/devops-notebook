# Guia Prático de Comandos MariaDB

Guia direto e instrutivo para administração de bancos de dados, gerenciamento de usuários e controle de permissões no MariaDB.

---

## 1. Conexão ao Servidor

* **Acessar localmente como root:**
  ```sql
  mysql -u root -p
  ```
* **Acessar servidor remoto:**
  ```sql
  mysql -h IP_DO_SERVIDOR -u USUARIO -p
  ```
* **Sair do terminal do MariaDB:**
  ```sql
  EXIT;
  ```

---

## 2. Gerenciamento de Bancos de Dados (Databases) e Tabelas

* **Listar todos os bancos de dados:**
  ```sql
  SHOW DATABASES;
  ```
* **Criar um novo banco de dados:**
  ```sql
  CREATE DATABASE nome_do_banco;
  ```
* **Selecionar um banco de dados para uso:**
  ```sql
  USE nome_do_banco;
  ```
* **Excluir um banco de dados:**
  ```sql
  DROP DATABASE nome_do_banco;
  ```
* **Listar tabelas do banco selecionado:**
  ```sql
  SHOW TABLES;
  ```
* **Ver a estrutura de uma tabela específica:**
  ```sql
  DESCRIBE nome_da_tabela;
  ```

---

## 3. Gerenciamento de Usuários

* **Listar todos os usuários e seus hosts:**
  ```sql
  SELECT user, host FROM mysql.user;
  ```
* **Criar usuário com acesso apenas local:**
  ```sql
  CREATE USER 'usuario_local'@'localhost' IDENTIFIED BY 'sua_senha';
  ```
* **Criar usuário com acesso de qualquer IP:**
  ```sql
  CREATE USER 'usuario_remoto'@'%' IDENTIFIED BY 'sua_senha';
  ```
* **Alterar senha de um usuário:**
  ```sql
  ALTER USER 'usuario'@'host' IDENTIFIED BY 'nova_senha';
  ```
* **Excluir um usuário:**
  ```sql
  DROP USER 'usuario'@'host';
  ```

---

## 4. Controle de Permissões (Privilégios)

* **Conceder todos os privilégios em um banco específico:**
  ```sql
  GRANT ALL PRIVILEGES ON nome_do_banco.* TO 'usuario'@'host';
  ```
* **Conceder apenas permissões de leitura e escrita:**
  ```sql
  GRANT SELECT, INSERT, UPDATE ON nome_do_banco.* TO 'usuario'@'host';
  ```
* **Conceder privilégios globais de administrador:**
  ```sql
  GRANT ALL PRIVILEGES ON *.* TO 'usuario'@'host' WITH GRANT OPTION;
  ```
* **Remover todas as permissões de um usuário:**
  ```sql
  REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'usuario'@'host';
  ```
* **Recarregar as tabelas de privilégios (Aplicar mudanças):**
  ```sql
  FLUSH PRIVILEGES;
  ```

---

## 5. Auditoria de Acessos e Permissões

* **Ver permissões de um usuário específico:**
  ```sql
  SHOW GRANTS FOR 'usuario'@'host';
  ```
* **Listar quais usuários têm acesso a quais bancos de dados:**
  ```sql
  SELECT User, Host, Db FROM mysql.db;
  ```
* **Ver conexões ativas no momento:**
  ```sql
  SHOW PROCESSLIST;
  ```
