Rodar seu site em um container Nginx no servidor Linux e acessá-lo via navegador.

 1. Transferir os arquivos para o servidor Linux:
 - `scp -r ./meu-site/ usuario@IP_DO_SERVIDOR:/home/usuario/`
 - `-r` = recursivo; é usado para coipar diretórios inteiros
 2. Criar Dockerfile (no diretório onde o site foi copiado):
 - `cd /home/usuario/meu-site`
 - `nano Dockerfile`
 ```
    FROM nginx:alpine
    COPY . /usr/share/nginx/html
    EXPOSE 80
 ```
 3. Construir a imagem Docker:
 - `docker build -t meu-site-nginx .`
 - `-t`= tag; nome da imagem
 4. Rodar o container:
 - `docker run -d --name site-nginx -p 8080:80 meu-site-nginx`
 - `-d` serve para executar o container em segundo plano.