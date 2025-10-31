## YAML

 **YAML** é uma linguagem de serialização de dados versátil e legível por humanos, comumente utilizada para criar arquivos de configuração. **O YAML não é uma linguagem de marcação.**

  Ela é utilizada para arquivos de configuração, inclusive do Docker, para configurar o Docker Compose. Ela é de fácil leitura para humanos.

Exemplo de um arquivo **YAML**:
```
#Comment: This is a supermarket list using YAML
#Note that - character represents the list
---
food: 
  - vegetables: tomatoes #first list item
  - fruits: #second list item
      citrics: oranges 
      tropical: bananas
      nuts: peanuts
      sweets: raisins
```
>  (---) Eles sinalizam o início de um documento. Já o final do documento é marcado por três pontos (...).  
##### Espaçamento e indentação

  - O fim de uma linha indica o fim de uma instrução, não há ponto e vírgula;
  - A indentação deve conter um ou mais espaços, e não devemos utilizar tab;
  - O espaço é obrigatório após a declaração da chave;
  - Comentários iniciam com o caracter: "#";
  - O processador de YAML ignora comentáiros;
  - Em YAML podemos escrever textos de duas formas: Sem aspas e com aspas;
  - Em YAML podemos definir um dado como nulo de duas formas: ***~*** ou ***null***, os dois vão resultar em None;

  - Podmeos inserir booleanos da seguinte forma:
    - True e On = verdadeiro;
    - False e Off = falso;
  - Os arquivos YAML são estruturados em formato de mapas ou lista
    - Mapas:
      - Com os mapas, é possivel associar pares de chave-valor
      - Cada chave precisa ser única, e qualquer ordem é aceita
    - Listas:
      - Incluem valores em uma ordem específica e podem conter qualquer quantidade de itens
      - A sequência de uma lista inicia com um traço (-) e um espaço
      - É separada da sequência mãe por um recuo
  - Arrys, tipos de dados para listas:
    - Primeira forma:
    ```
    lista: [1,2,3,4,5]
    ```
    - Segunda forma:
    ```
        lista_dois:
            - "teste"
            - 10
            - teste
            - True
    ```
  - Mapas:
  ```
  Idenficacao:
    nome: Phillipe
    sobrenome: Farias
    idade: 32
    sexo: masculino
  ```
  - Dicionário, tipos de dados para objetos ou listas com chaves e valores:
    - Primeira forma:
    ```
    obj: [a:1,b:2,c:3,d:4]
    ```
    - Segunda forma:
    ```
        lista_dois:
            - chave: 1
            - chave: 2
    ```
> É como um dicionário Python ou uma atribuição de variável em um script bash.

#### Análise de dados YAML

A "análise de dados YAML" refere-se ao processo de processar e compreender dados estruturados dentro de arquivos YAML, utilizando a sintaxe legível por humanos e baseada em indentação do YAML para diversas aplicações como configuração, troca de dados e automação, sendo essencial para ferramentas como Kubernetes, Ansible e Docker. A análise envolve a interpretação das estruturas de dados que o YAML suporta, como sequências (listas) e mapeamentos (pares chave-valor), para extrair e utilizar as informações contidas. 

> PyYAML é um analisador e emissor YAML para Python.

 