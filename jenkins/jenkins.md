## Jenkins
Jenkins é uma ferramenta de automação de código aberto bastante utilizada para integração contínua (CI) e entrega contínua (CD) no desenvolvimento de software. Com ela, é possível automatizar várias etapas do ciclo de desenvolvimento, como a compilação, testes e deploy, facilitando a entrega de novas versões do software de forma rápida e confiável.

##### Executando um Comando Simples com Projeto Freestyle

1. Crie um Novo Item
    - No painel principal do Jenkins, clique em "Novo Item" (New Item).
    - Dê um nome ao seu projeto (ex: ComandoSimplesShell).
    - Selecione a opção "Projeto estilo livre" (Freestyle project).
    - Clique em "OK".

2. Configure a Etapa de Construção
    - Na página de configuração do seu novo item, role para baixo até a seção "Build" (Construção).
    - Clique no botão "Adicionar etapa de construção" (Add build step).
    - Selecione "Executar shell" (Execute shell).

##### Execução de playbooks do ansible no jenkins

- Instale o plugin Ansible no Jenkins (Manage Jenkins > Manage Plugins > Available, procure por "Ansible" e instale).
- Configure o caminho do executável Ansible em Manage Jenkins > Global Tool Configuration.
- Adicione as credenciais necessárias para acesso SSH aos hosts em Manage Jenkins > Credentials.
- Crie um pipeline de Jenkins e, no script do pipeline, utilize o passo ansiblePlaybook para executar o playbook.

Para executar um playbook Ansible que precise de autoridade root, usa-se o recurso chamado "become". Ele permite que uma tarefa ou o playbook inteiro seja executado com privilégios elevados.

- become: true 
ou
```yaml
tasks:
  - name: Faça algo com privilégios root
    become: true
    command: seu_comando
```

##### ⚠️ Pontos Importantes
- Agente/Node: Os comandos shell são executados no agente (slave) ou master (controlador) do Jenkins que o job está configurado para usar.
- Permissões: O usuário do sistema operacional que executa o agente Jenkins precisa ter permissão para executar os comandos e acessar os diretórios necessários.
- Pipeline é o Padrão: O tipo de job Pipeline é o padrão moderno e mais recomendado no Jenkins, pois permite definir todo o fluxo de CI/CD como código (Jenkinsfile).

##### Execução de um `Jenkinsfile`

1. Preparação do Jenkinsfile
    - Primeiro, certifique-se de que seu Jenkinsfile esteja:
        - Criado: O arquivo deve ser nomeado exatamente como Jenkinsfile (sem extensão, com "J" maiúsculo).
        - Armazenado: Ele deve estar na raiz do seu repositório Git (ou outro SCM) que contém o código do seu projeto.

Exemplo básico de um Jenkinsfile:
```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Iniciando o build...'
                sh 'pwd'
                sh 'ls -l'
            }
        }
        stage('Test') {
            steps {
                echo 'Executando testes...'
                // Exemplo de comando de teste real: sh 'npm test'
            }
        }
    }
}
```
2. Criação do Job no Jenkins (Tipo Pipeline)
    1. Crie um Novo Item:
        - No painel principal do Jenkins, clique em "Novo Item" (New Item).
        - Dê um nome ao seu projeto (ex: MeuPipelineDeProjeto).
        - Selecione a opção "Pipeline".
        - Clique em "OK".
    2. Configuração do Pipeline:
        - Na página de configuração, role para baixo até a seção "Pipeline".
        - Em "Definition" (Definição), selecione a opção:
            - "Pipeline script from SCM" (Script de Pipeline do SCM).
    3. Configuração do SCM (Source Code Management):
        - Em "SCM", selecione o tipo de repositório que você está usando.
        - Repository URL: Insira a URL do seu repositório Git (ex: https://github.com/seuusuario/seuprojeto.git).
        - Credentials: Selecione as credenciais (se o repositório for privado).
        - Branches to build: Mantenha como */master ou */main (ou a branch que contém seu Jenkinsfile).
        - Script Path: Mantenha o valor padrão: Jenkinsfile (se você o colocou na raiz do repositório com esse nome).
    4. Salve e Execute:
        - Clique em "Salvar".


##### Jenkinsfile

O Jenkinsfile é o script que define o Pipeline as Code no Jenkins, utilizando a sintaxe Declarative Pipeline (mais moderna e estruturada) ou Scripted Pipeline (mais flexível e complexa).

| Parâmetro | Função (O que faz) | Onde é Usado | Exemplo Simples |
| --------- | ------------------ | ------------ | --------------- |
| pipeline  | O bloco obrigatório que encapsula toda a definição do pipeline. Define que o script está usando a sintaxe Declarativa.  | Raiz do Jenkinsfile  | pipeline { ... }    |
| agent     | Define onde o pipeline (ou uma etapa específica) será executado. Ele especifica qual máquina (nó/slave) ou contêiner deve ser usado. | Dentro de pipeline (Global) ou Dentro de stage (Específico) | agent any(em qualquer agente disponível) `agent { label 'linux-node' }` |
| stages    | Um bloco obrigatório que contém uma ou mais seções stage. Ele estrutura o pipeline em estágios lógicos e sequenciais.                                                   | Dentro de pipeline                                          | stages { stage('Build') { ... } stage('Test') { ... } }                                                    |
| stage     | Define uma fase única, lógica e nomeada do Pipeline. É a unidade de trabalho que aparece no painel de visualização do Jenkins.                                          | Dentro de stages                                            | stage('Build') { steps { ... } }                                                                           |
| steps     | O bloco que contém a sequência de ações (os comandos reais) a serem executadas dentro de um stage. É onde você usa comandos shell (sh), Groovy ou chama outros plugins. | Dentro de stage                                             | steps { sh 'npm install'; sh './run-tests.sh' }                                                            |
| post      | Define ações que devem ser executadas após a conclusão de um Pipeline ou de um stage, independentemente do resultado (sucesso, falha, aborto, etc.).                    | Dentro de pipeline (Global) ou Dentro de stage (Específico) | post { always { echo 'Sempre executa'; } success { slackSend 'Sucesso!' } failure { archiveArtifacts } }   |

```groovy
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building...'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}
```
```groovy
pipeline {
    agent any
    stages{
        stage ('Build') {
            steps{
                sh 'echo "My first pipeline"'
            }
        }
    }
}
```
```groovy
pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh 'echo "Fail!"; exit 1'
            }
        }
    }
    post {
        always {
            echo 'I will always get executed :D'
        }
        success {
            echo 'I will only get executed if this success'
        }
        failure {
            echo 'I will only get executed if this fails'
        }
        unstable {
            echo 'I will only get executed if this is unstable'
        }
    }
}
```