# Helm Chart

Helm é um gerenciador de pacotes kubernetes que simplicafica `deployment` para construir aplicações com configurações reutilizáveis e controlar versões **Helm charts**
Com o Helm, é possível implantar aplicações com um simples comando, gerenciar atualizações, e fazer roll back para versões antigas caso necessário.

## Arquitetura do Helm Chart e componentes

1. **Helm CLI** - Interface de linha de comando para gerenciar Helm Charts, releses e repositórios.  
É responsável por renderizar templates e enviar os manifests para a API do Kubernetes.  
  
2. **Helm Charts** - Pacote versionado que define uma aplicação Kubernetes.  
  Contém:  
    - Templates (Deployments, Services, ConfigMaps, Secrets etc.)  
    - Chart.yaml  
    - values.yaml  
    - Dependências  

3. **Helm Repository** - Repositório que armazena Helm Charts versionados (local ou remoto).  
Funciona como um registry para distribuição de charts.  

4. **Helm Release** - Instância instalada de um Helm Chart dentro do cluster  Kubernetes.  
  Ele armazena:  
    - Valores utilizados  
    - Versão do chart  
    - Histórico de revisões  
    - Esses dados ficam salvos no cluster (como Secrets ou ConfigMaps).  

5. **API Server Kubernetes** - O Helm se comunica com a API do Kubernetes para aplicar os manifests renderizados e criar os recursos no cluster.

>[!WARNING]
> Helm não faz deploy “do chart”, ele renderiza templates e cria uma Release que aplica manifests na API do Kubernetes.

## Estrutura básica de um Helm Chart
```pgsql
meu-chart/
  Chart.yaml
  values.yaml
  templates/
  charts/
```
### Chart.yaml — Identidade do Chart

Ele define: Nome do chart, versão do chart, versão da aplicação, descrição e dependências.

### values.yaml — Configurações padrão

O `values.yaml` define valores padrão que serão injetados nos templates.

## Comandos 
### helm dependency build
```bash
helm dependency build
```
Serve para:
- Baixar dependências declaradas no Chart.yaml
- Popular a pasta charts/