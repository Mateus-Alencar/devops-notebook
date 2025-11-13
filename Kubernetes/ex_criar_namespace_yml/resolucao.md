comand: `vim backend-namespace.yaml`
```yaml

apiVersion: v1
kind: Namespace

metadata:
  name: backend-ns
  labels:
    apps: backend-apps

```
ou
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis-pod
  namespace: backend-ns #### definição do campo namespace =)
  labels:
    apps: backend
spec:
  containers:
    - name: redis-container
      image: redis
```
comand: `kubectl apply -f backend-namespace.yaml`
comand: `kubectl get ns`
comand: `kubectl apply -f tomcat-pod.yaml --namespace=backend-ns`
Listar pods do namespace backend-ns
comand: `kubectl get pods -n backend-ns`
comand: `kubectl delete pods tomcat-pod -n backend-ns`
comand: `kubectl delete ns backend-ns`
