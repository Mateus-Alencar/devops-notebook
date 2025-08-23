1. Comando para subir os containers:
`docker-compose up -d`

2. Acesso aó Jenkins: `http://localhost:8080`

3. Realizar instalação do plugin Active Directory no Jenkins
 -  Manage Jenkins → Plugins → instale Active Directory plugin.

4. Configuração da integração:
    - Manage Jenkins → Security → Configure Global Security 
    - Em "Security Realm", escolha Active Directory.
    - Configure:
        - Domain: LAB.LOCA
        - Domain controller: ad.lab.local
        - Bind DN: Administrator@LAB.LOCAL
        - Password: Admin@123 (a do Samba 4 que configuramos).
    - Agora os logins no Jenkins podem ser feitos com usuários do AD.