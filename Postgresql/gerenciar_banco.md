# Guia Rápido de PostgreSQL

### Comandos de Listagem e Conexão (\)
* `\l` ou `\list` - Lista bancos de dados.
* `\c nome_do_banco` - Conecta ao banco.
* `\du` - Lista usuários e permissões.
* `\dt` - Lista tabelas atuais.
* `\dt+` - Mostra tamanho das tabelas.
* `\dn` - Lista todos os schemas.
* `\df` - Lista funções e procedimentos.
* `\dv` - Lista todas as views.
* `\dx` - Lista extensões instaladas.
* `\conninfo` - Detalhes da conexão atual.
* `\?` - Ajuda dos comandos internos.
* `\h comando` - Ajuda para sintaxe SQL.
* `\q` - Sair do terminal psql.

### Usuários e Permissões (SQL)
* `CREATE USER usuario WITH PASSWORD 'senha';` - Cria novo usuário.
* `ALTER USER usuario WITH SUPERUSER;` - Concede privilégios de superusuário.
* `DROP USER usuario;` - Exclui um usuário.
* `GRANT ALL PRIVILEGES ON DATABASE banco TO usuario;` - Dá controle total do banco.
* `REVOKE ALL PRIVILEGES ON DATABASE banco FROM usuario;` - Revoga acessos ao banco.

### Gerenciamento de Bancos (SQL)
* `CREATE DATABASE nome_do_banco;` - Cria um banco.
* `DROP DATABASE nome_do_banco;` - Exclui um banco permanentemente.
* `ALTER DATABASE banco RENAME TO novo_nome;` - Renomeia o banco de dados.

### Administração e Monitoramento
* `SELECT pg_size_pretty(pg_database_size('nome_do_banco'));` - Exibe tamanho formatado do banco.
* `SELECT * FROM pg_stat_activity;` - Monitora conexões e consultas ativas.
* `SELECT pg_terminate_backend(pid);` - Encerra conexões travadas via PID.

### Arquivos de Configuração (/var/lib/postgresql/data/)
* `postgresql.conf` - Ajusta memória, portas, logs e performance.
* `pg_hba.conf` - Define regras de segurança, IPs permitidos e autenticação.
