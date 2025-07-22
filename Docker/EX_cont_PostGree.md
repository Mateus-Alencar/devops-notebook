##  📖 Exercício 

Criação de um container com Docker com PostgreSQL, usando um volume para persistir os dados fora do container.

1. Criação do volume Docker para armazenar os dados:

```
docker volume create pgdata
```

2. Criação do container PostgreSQL usando o volume pgdata

```
docker run -d \
  --name meu-postgres \
  -e POSTGRES_PASSWORD=minhasenha \
  -v pgdata:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres
```

 - -d: roda o container em background.

 - --name meu-postgres: nome do container.

 - -e POSTGRES_PASSWORD=minhasenha: define a senha do usuário padrão postgres.

 - -v pgdata:/var/lib/postgresql/data: conecta o volume pgdata à pasta onde o PostgreSQL guarda os dados

 - -p 5432:5432: expõe a porta 5432 para a máquina host (padrão do PostgreSQL)

 - postgres: imagem oficial do PostgreSQL.


 3. 💡 Possibilidade de mapear uma pasta do sistema para armazenar os arquivos do banco:

 ```

docker run -d \
  --name meu-postgres \
  -e POSTGRES_PASSWORD=minhasenha \
  -v /arquivos_banco:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres

```
 - A pasta: arquivos_banco guarda os dados no disco local, visível fora do container.