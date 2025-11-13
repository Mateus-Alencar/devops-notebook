Esse exercício mostra um exemplo prático de como implantar um container do Nginx no Kubernetes e expor esse serviço externamente.

`Arquivo:`my-deploy-nginx.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-daora
spec:
  selector:               # indica como o Deployment vai encontrar os pods que ele deve gerenciar.
    matchLabels:          # aqui ele seleciona pods que tenham o rótulo (label) app: nginx-daora
      app: nginx-daora
  template:               # define como os pods devem ser criados.
    metadata:
      labels:
        app: nginx-daora
    spec:
      containers:
      - name: ngix-daora
        image: nginx
```
Esse arquivo cria um Service, que é o recurso responsável por expor os pods dentro (ou fora) do cluster.
`Arquivo: ` my-service.yaml
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort      # significa que o serviço será exposto externamente, abrindo uma porta em cada nó do cluster (entre 30000 e 32767).
  selector:
    app: nginx-daora
  ports:             # define as portas do serviço.
  - port: 80
    targetPort: 80

```