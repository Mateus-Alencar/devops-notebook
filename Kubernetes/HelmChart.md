# Helm Chart

Helm é um gerenciador de pacotes kubernetes que simplicafica `deployment` para construir aplicações com configurações reutilizáveis e controlar versões **Helm charts**
O Helm atua como um template engine e package manager para Kubernetes, permitindo versionamento, reutilização e gerenciamento de aplicações declarativas.

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
mychart/
│── charts/           # Diretório utilizado para armazenar dependências do chart  
│── templates/        # Contém os arquivos de template em YAML  
│   ├── deployment.yaml  
│   ├── service.yaml  
│   ├── ingress.yaml  
│   ├── _helpers.tpl  # Contains reusable template functions  
│── Chart.yaml        # Arquivo obrigatório que contém os metadados do chart 
│── values.yaml       # Arquivo que define os valores padrão de configuração da aplicação.  
```

## Comandos 
### helm dependency build
```bash
helm dependency build
```
Serve para:
- Baixar dependências declaradas no Chart.yaml
- Popular a pasta charts/

### helm package
```bash
helm package .
```
Transforma o chart em um pacote versionado.