# 📦 Exemplo Prático: Renomeando Imagem Existente do Docker Hub

 - Utilizar a imagem oficial `httpd` (servidor Apache), que já está disponível no Docker Hub. 
 - Download da imagem
 - Executaremos um container
 - Renomearemos a imagem (retag) para uso próprio.

---

### 🔽 1. Baixando uma imagem oficial

Baixar a imagem oficial do Apache HTTP Server:

```bash
    docker pull httpd:2.4
```

### 🔽 2. Rodando um container com a imagem baixada

```bash
    docker run -d --name meu-apache -p 8080:80 httpd:2.4
```

### 🔽 3.  Renomeando a imagem (tag)
```bash
    docker tag httpd:2.4 meuusuario/apache-custom:meu-projeto
```

### 🔽 4. Verificando a nova tag
```bash
    docker images
```
Saída:
```bash
REPOSITORY                  TAG             IMAGE ID       SIZE
httpd                      2.4             abcd1234efgh   138MB
meuusuario/apache-custom   meu-projeto     abcd1234efgh   138MB
```
