### Certificados no kubernetes
A rotação dos certificados no Kubernetes é um processo de segurança que garante que os certificados usados para autenticação e comunicação entre os componentes do cluster sejam renovados antes de expirarem, evitando falhas e mantendo a segurança do ambiente.
O Kubernetes automaticamente emite novos certificados para os componentes do cluster (como o kubelet, que roda nos nós) antes dos atuais expirarem. Isso é feito por meio da geração de novas chaves e envio de solicitações de certificados (CSRs) para a Autoridade Certificadora (AC) do cluster, que os assina e emite os novos certificados.

Os certificados no Kubernetes faz parte de um sistema de segurança que usa criptografia assimétrica (chaves públicas e privadas) para garantir a autenticidade, a confidencialidade e a integridade das comunicações.

**Certificado digital:** é um documento eletrônico, normalmente no formato X.509, que contém uma chave pública e informações de identidade, assinada por uma Autoridade Certificadora (CA) confiável.​

**Chave pública e privada:** a chave pública é disponibilizada em certificados, enquanto a chave privada é guardada de forma segura pelo proprietário. Quando alguém quer se comunicar de forma segura, usa a chave pública do destinatário para criptografar os dados, e o destinatário usa sua chave privada para descriptografar.​

**Autenticação e conexão segura:** em uma conexão TLS/SSL, por exemplo, o servidor apresenta seu certificado digital ao cliente. O cliente verifica a validade do certificado (assinatura, data de validade, revogação), garantindo que está se comunicando com o servidor legítimo. Depois, uma troca de chaves segura é estabelecida para criptografar os dados trocados.

- **Resumo**
Os certificados funcionam como uma forma de autenticação e troca de chaves durante a configuração segura de uma conexão, mas não são enviados junto com os dados por si só, como se fosse uma chave de criptografia embutida na transferência de pacotes. Eles são usados na negociação inicial do TLS para estabelecer uma conexão segura, e depois essa conexão é criptografada com chaves que foram geradas naquele momento, usando os certificados apenas para validar identities.

Link para a documentação oficial: Rotação de certificados - RKE2/Rancher
https://gitea.ljussara.com/TI/APP-Rancher/src/branch/main/docs/01-manutencao/rotacao_de_certificados.md