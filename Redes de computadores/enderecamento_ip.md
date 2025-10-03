
# Endereçamento IP, Máscaras de Sub-rede e Cálculo de Sub-redes

## 1. Conceitos Fundamentais

### O que é Endereço IP?
- **IP (Internet Protocol)**: Identificador único para dispositivos em uma rede.
- **IPv4**: Endereços de 32 bits (ex: `192.168.1.10`).
- **IPv6**: Endereços de 128 bits (ex: `2001:0db8:85a3::8a2e:0370:7334`).

### Estrutura de um Endereço IPv4
- Dividido em **4 octetos** (8 bits cada), separados por pontos.
- Exemplo: `192.168.1.10` → `11000000.10101000.00000001.00001010`.

---

## 2. Classes de Endereços IPv4
- **Classe A**: `1.0.0.0 a 126.255.255.255` → Máscara padrão: `/8`
- **Classe B**: `128.0.0.0 a 191.255.255.255` → Máscara padrão: `/16`
- **Classe C**: `192.0.0.0 a 223.255.255.255` → Máscara padrão: `/24`
- **Classe D**: `224.0.0.0 a 239.255.255.255` (Multicast)
- **Classe E**: `240.0.0.0 a 255.255.255.255` (Reservado)

---

## 3. Máscaras de Sub-rede

### O que é Máscara de Sub-rede?
- Define a **parte de rede** e a **parte de host** em um endereço IP.
- Exemplo: `255.255.255.0` → `/24`.

### Máscaras Comuns (CIDR)
- `/8` → `255.0.0.0` → 16.777.214 hosts
- `/16` → `255.255.0.0` → 65.534 hosts
- `/24` → `255.255.255.0` → 254 hosts
- `/30` → `255.255.255.252` → 2 hosts (usado em enlaces ponto a ponto)

---

## 4. Cálculo de Sub-redes

**Sub-rede**

- É a divisão lógica de uma rede IP maior em partes menores.
- Serve para organizar e segmentar uma rede, aumentando a eficiência e a segurança.
- Cada sub-rede tem:
  - Endereço de rede (primeiro endereço).
  - E dereço de broadcast (último endereço).
  - Intervalo de endereços de hosts válidos (os que podem ser atribuídos a dispositivos).

📌 Exemplo:
Rede 192.168.1.0/24 → 1 sub-rede com 254 hosts válidos.
Se dividirmos em /26, teremos 4 sub-redes, cada uma com 62 hosts válidos.

**Hosts**

- São os dispositivos conectados à rede que recebem endereços IP dentro da sub-rede.
- Podem ser computadores, impressoras, servidores, roteadores, celulares etc.
- Os hosts utilizam os endereços entre o de rede e o de broadcast.

### Fórmulas
- **Número de sub-redes**: `2^n` (n = número de bits emprestados da parte de host)
- **Número de hosts por sub-rede**: `2^h - 2` (h = bits de host, subtraímos 2: rede e broadcast)

### Exemplo 1: Divisão em Sub-redes
- Rede: `192.168.1.0/24`
- Necessidade: 4 sub-redes
- Passo 1: `/24` = 8 bits para hosts. Para 4 sub-redes → `2^2 = 4` → emprestamos 2 bits.
- Nova máscara: `/26` → `255.255.255.192`
- Sub-redes:
  - `192.168.1.0/26` → hosts de `.1 a .62`
  - `192.168.1.64/26` → hosts de `.65 a .126`
  - `192.168.1.128/26` → hosts de `.129 a .190`
  - `192.168.1.192/26` → hosts de `.193 a .254`

### Exemplo 2: Quantidade de Hosts
- Rede: `10.0.0.0/16`
- Máscara: `/16` → 16 bits para host.
- Hosts por rede: `2^16 - 2 = 65.534`.

### Exemplo 3: Quantidade de Sub-redes
- Rede: `172.16.0.0/16`
- Máscara: `/20` → emprestamos 4 bits (de 16 disponíveis).
- Sub-redes: `2^4 = 16`.

---

## 5. Endereços Especiais
- **Endereço de Rede**: Primeiro endereço da sub-rede (ex: `192.168.1.0` em `/24`).
- **Endereço de Broadcast**: Último endereço da sub-rede (ex: `192.168.1.255` em `/24`).
- **Endereços Válidos para Hosts**: Entre rede e broadcast.

---

## 6. Subnetting em Grandes Empresas
- Utilizar **VLANs** + sub-redes para separar setores.
- Exemplo:
  - TI: `192.168.10.0/24`
  - Financeiro: `192.168.20.0/24`
  - RH: `192.168.30.0/24`
- Isso aumenta segurança e organização.

---

## 7. Ferramentas de Apoio
- **Calculadoras de Sub-rede Online**
- **Comandos no Linux**:
  - `ip addr show` → mostra endereços configurados
  - `ifconfig` (em algumas distribuições)
- **Wireshark**: análise de pacotes de rede.

---

## Conclusão
O domínio de **endereçamento IP, máscaras de sub-rede e subnetting** é essencial para projetar, administrar e expandir redes corporativas. Um planejamento bem-feito garante eficiência, escalabilidade e segurança.
