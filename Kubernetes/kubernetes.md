# Conceitos de Orquestração

Orquestradores de Containers são responsáveis pela implementação, monitoramento e controle de containers em ambientes de múltiplos servidores. Eles são essenciais para ambientes empresariais de hospedagem de aplicações.

Hoje existem diversos Orquestradores de Containers disponíveis tanto na nuvem quanto para instalações on-premises, ou locais. Entre os principais estão: Kubernetes, Docker Swarm, Openshift e Mesos.

No caso dos Orquestradores de Containers, um projeto é em geral definido de maneira declarativa e é chamado de Estado do Cluster. Basicamente nós decidimos qual é o estado desejado do ambiente e o Orquestrador irá monitorar todo o ambiente fazendo modificações para alcançar o estado desejado.