### Traefik

Traefik  é um proxy reverso e balanceador de carga muito usado para gerenciar o tráfego em clusters de microsserviços, como em um cluster Kubernetes com 3 nós. Ele atua como um controlador de ingress, cuidando da rota das requisições externas para os serviços que rodam dentro do cluster, de modo dinâmico e escalável.

O Traefik é implantado como um serviço distribuído em todos os nós do cluster. Ele pode ser configurado para rodar em modo "daemonset" (um pod em cada nó) ou com réplicas múltiplas balanceadas.

> O DaemonSet é um objeto que garante que todos os nós do cluster executem uma réplica de um Pod, ou seja, ele garante que todos os nós do cluster executem uma cópia de um Pod.

O Traefik se integra ao orquestrador (ex: Kubernetes, Docker Swarm) para descobrir automaticamente os serviços que estão rodando e suas rotas, atualizando suas rotas sem necessidade de reiniciar. Ele pode gerenciar certificados TLS automaticamente usando Let's Encrypt, habilitando HTTPS de forma transparente.

![alt text](image-1.png)