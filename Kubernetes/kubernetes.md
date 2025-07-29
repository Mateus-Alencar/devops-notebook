# Conceitos de Orquestração

Orquestradores de Containers são responsáveis pela implementação, monitoramento e controle de containers em ambientes de múltiplos servidores. Eles são essenciais para ambientes empresariais de hospedagem de aplicações.

Hoje existem diversos Orquestradores de Containers disponíveis tanto na nuvem quanto para instalações on-premises, ou locais. Entre os principais estão: Kubernetes, Docker Swarm, Openshift e Mesos.

No caso dos Orquestradores de Containers, um projeto é em geral definido de maneira declarativa e é chamado de Estado do Cluster. Basicamente nós decidimos qual é o estado desejado do ambiente e o Orquestrador irá monitorar todo o ambiente fazendo modificações para alcançar o estado desejado.

## Kubernetes

O Orquestrador de Containers mais utilizado no mercado atualmente é o Kubernetes. Kubernetes (K8s) é um produto Open Source utilizado para automatizar a implantação, o dimensionamento e o gerenciamento de aplicativos em contêiner.

### Componentes

O Kubernetes é formado por uma série de componentes que compartilham um mesmo estado em um banco dedados do tipo Chave-Valor, o ETCD. A interação entre esses diversos componentes gerenciam um cluster que pode ser formado por centenas ou até mesmo milhares de containers e servidores. Podemos dividir esses componentes em 3 camadas: Os componentes do Control Plane, os componentes do Node Plane e os Addons.

 - O Control Plane é responsável pelas decisões administrativas do ambiente. Pense nele como a cabeça por trás das decisões tomadas pelo Kubernetes.
 - No Node Plane são reunidos os componentes que são executados em todos os servidores do Cluster. Nele temos os componentes que gerenciam os container e rede dos servidores. 
 - Por fim, os Addons são componentes que usam recursos do Kubernetes para adicionar capacidades extras ao Cluster.

```
Kube-scheduler

    O Kube-controller-manager é responsável por gerir as tarefas administrativas do cluster. Nele, diversos Controladores com diversas responsabilidades distintas são executados a fim de manter o estado do cluster atualizado.
 ```

```
Endpoints Controller

    O Endpoint Controller é responsável por adicionar Endpoints, ou IP’s de Pods, a lista de Endpoint de um Service. Ele observa as regras definidas no campo Selector de um Service para descobrir que Pods devem ser adicionados a lista, tornando possével a descoberta de Serviço de forma fácil e prática usando DNS e Services.
```

 ```
Kubelet

    O Kubelet é o processo responsável por iniciar os containers definidos nos pods. Ele conversa com o Container Runtime instalado no servidor garantindo a execução e a saúde dos containers definidos no Estado do Cluster.
 ```