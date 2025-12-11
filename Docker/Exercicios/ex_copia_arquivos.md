##  📖 Exercício 

Criar um container baseado na imagem ubuntu, copiar um script de shell para dentro do container, executá-lo e visualizar a saída.

1. Criar um arquivo hello.sh
    → `mkdir arq_copia`
    → `cd arq_copia`
    → `nano hello.sh`
    → `chmod +x hello.sh`: Permissão para execução
#
2. Executar o container Ubuntu
    → `docker run -dit --name meu_ubuntu ubuntu`
    - -d: modo em segundo plano
    - -i: interativo
    - -t: terminal
    - --name ubuntu-exercicio: nome para o container
    - ubuntu: imagem base usada
#
3. Compiar script para dentro do container
    → `docker cp hello.sh meu_ubuntu:/home/hello.sh`
    - `cp`: Comando Docker para copiar arquivos entre o host e o container.
    - `hello.sh`: Caminho do arquivo no host
    - `ubuntu-exercicio:/home/hello.sh`: Destino dentro do container 
    - `/home/hello.sh`: Caminho completo dentro do container onde o arquivo será copiado.
#
4. Executando o Script
    → `docker exec meu_ubuntu bash /home/hello.sh`
#
---
Copiar um arquivo do container para uma pasta no host (máquina).
→ docker cp meu_ubuntu:/home/hello.sh ./hello.sh
*Primeiro é selecionado o caminho do arquivo, depois é selecionado para onde ele irá*

