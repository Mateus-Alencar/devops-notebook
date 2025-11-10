# 📦 Subindo Imagens para o Docker Hub

Fazer o upload de uma imagem para o Docker Hub permite compartilhar seu projeto com outras pessoas, reutilizar a imagem em diferentes máquinas ou servidores e manter versões controladas do ambiente com o uso de tags. Isso facilita a colaboração em equipe, a automação de deploys em pipelines de CI/CD e evita a necessidade de reconstruir a imagem sempre que for preciso rodar a aplicação em outro lugar.

## 🔐 1. Autenticando no Docker Hub

Antes de enviar qualquer imagem, é necessário estar autenticado com a minha conta:

```bash
docker login
```

Se o login for bem-sucedido, as credenciais ficarão salvas em `~/.docker/config.json`.

---

## 🛠️ 2. Criando uma Imagem com `docker build`

Crie um arquivo `Dockerfile` com sua configuração. Exemplo:

```Dockerfile
FROM nginx:alpine
COPY ./meu-site/ /usr/share/nginx/html/
```

Depois, crie a imagem:

```bash
docker build -t meu-site-nginx .
```

---

## 🏷️ 3. Tagueando a Imagem

O Docker Hub identifica imagens com o formato:

```
<nome-de-usuário>/<nome-da-imagem>:<tag>
```

Para preparar a imagem para envio, use o comando `docker tag`:

```bash
docker tag meu-site-nginx meuusuariodockerhub/meu-site:latest
```
---

## ⬆️ 4. Enviando a Imagem com `docker push`

Agora, envie sua imagem para sua conta no Docker Hub:

```bash
docker push meuusuariodockerhub/meu-site:latest
```

> Será apresentando no terminal o progresso da transferência camada por camada.

---

## 📄 5. Verificando no Docker Hub

- Acesse: https://hub.docker.com/
- Vá até o repositório com o nome usado (ex: `meu-site`)
- Verifique se a imagem foi enviada com sucesso.

---

## ❌ 6. Logout (opcional)

Se estiver em um ambiente compartilhado ou quiser encerrar a sessão:

```bash
docker logout
```

---

## 📌 Dicas Importantes

- O nome da imagem **deve começar com seu nome de usuário no Docker Hub**.
- Se não fizer `tag` corretamente, o `push` falhará com erro de permissão.
- Você pode subir múltiplas `tags` da mesma imagem (ex: `v1`, `stable`, `latest`).

---

## Imagens Docker em Harbor

Para trabalhar com imagens Docker em Harbor, você utiliza os comandos padrão do Docker para login, pull (baixar) e push (enviar) de imagens, porém apontando para o endereço do seu registro Harbor.

1. Fazer login no Harbor (substitua <harbor_address> pelo domínio/endereço do seu Harbor):
> `docker login <harbor_address>`

2. Baixar (pull) uma imagem do Harbor:
> `docker pull <harbor_address>/<projeto>/<nome-da-imagem>:<tag>`
EX: `docker pull harbor.minhaempresa.com/library/nginx:latest`

3. Enviar (push) uma imagem para o Harbor:
- Primeiro, você deve “taggear” a imagem local com o endereço do Harbor, projeto e nome desejado: `docker tag <imagem-local> <harbor_address>/<projeto>/<nome-da-imagem>:<tag>`

>`docker tag nginx:latest harbor.minhaempresa.com/library/nginx:latest`

- Depois, faça o push para o Harbor: `docker push <harbor_address>/<projeto>/<nome-da-imagem>:<tag>`

> `docker push harbor.minhaempresa.com/library/nginx:latest`

| Ação             |  Comando exemplo   |
| ---------------- |  ----------------- |
| Login no Harbor  | `docker login harbor.minhaempresa.com`   |
| Pull da imagem   | `docker pull harbor.minhaempresa.com/meuprojeto/minhaimagem:tag`  |
| Taggear a imagem | `docker tag minhaimagem:tag harbor.minhaempresa.com/meuprojeto/minhaimagem:tag` |
| Push da imagem   | `docker push harbor.minhaempresa.com/meuprojeto/minhaimagem:tag` |
