#### 1. (Arquivos e Permissões)
Você tem o seguinte arquivo:
```bash
-rwsr-xr-- 1 root devops  29512 jan 10 14:22 /usr/local/bin/backup
```
a) Explique exatamente o efeito da permissão s neste arquivo.
```
Resposta: Quando o arquivo é executado, ele roda com os privilégios do usuário dono do arquivo — neste caso, root.
```
b) O que acontece se um usuário comum executar este arquivo?
```
Resposta: Se esse usuário pertencer ao grupo devops, ele irá conseguir executar o programa como root.
```
c) Qual o risco de segurança desse tipo de configuração?
```
Resposta: O risco é que o arquivo roda como root, podendo permitir escalonamento de privilégios caso tenha vulnerabilidades.
```

#### 2. (Gerenciamento de Processos e Sinais)

Explique a diferença entre:

```bash
kill -9 <PID> 
kill -15 <PID>
kill -0 <PID>
```

E diga em qual situação cada um é adequado. Em seguida, explique por que kill -9 deve ser evitado na maioria dos casos.
```
Resposta: 
kill -9 <PID>  # Ele envia um sinal SIGKILL e força o encerramento imediato.
Kill -15 <PID> # Ele envia um sinal SIGTERM, instruí o processo a encerrar de forma limpa
Kill -0 <PIC>  # Ele serve apenas para testar se o processo existe e se o usuário tem permissão para enviar sinais para ele.

Os efeitos do Kill -9 pode resultar em efeitos imprevisíveis, pois o processo não consegue fazer limpeza, pode corromper arquivos abertos e pode deixar recursos travados.
```

#### 3. (Init, Boot e Systemd) Liste em ordem correta todas as etapas que ocorrem desde o momento em que a máquina liga até o sistema iniciar o primeiro shell para o usuário.
Inclua:
- BIOS/UEFI
- Bootloader
- Kernel
- initramfs
- systemd
- target padrão

Explique cada etapa.
```
Resposta:
```
#### 4. (Pacotes – apt/dpkg) Explique a diferença exata entre:

- apt remove pacote
- apt purge pacote
- dpkg -r pacote
- dpkg -P pacote

Depois explique por que às vezes um pacote removido continua deixando arquivos em /etc.

```
Resposta:
```

#### 5. (Kernel e Modulos) Você quer carregar um módulo chamado snd_hda_intel, mas recebe erro:
```bash
modprobe: FATAL: Module snd_hda_intel not found in directory /lib/modules/6.1.0
```
a) Cite 3 possíveis causas para esse erro.
```
Resposta:
```
b) Como listar todas as versões de kernel disponíveis?
```
Resposta:
```
c) Após instalar um novo kernel, qual comando é usado para gerar novamente o initramfs?
```
Resposta:
```

#### 6. (Gerenciamento de Disco e SWAP) Um servidor está com problemas de swap e você precisa:

- Criar um arquivo de swap de 2GB em /swapfile
- Ativar esse arquivo
- Tornar essa mudança permanente

Escreva os comandos exatos necessários. Depois explique por que o comando chmod 600 /swapfile é obrigatório para arquivos de swap.
```
Resposta:
```

#### 7. (Networking / DNS) Explique detalhadamente a diferença entre:

- /etc/hosts
- /etc/resolv.conf
- /etc/nsswitch.conf

Mostre a ordem usada pelo Linux para resolver nomes e o que determina essa ordem. Depois explique por que alterar /etc/resolv.conf manualmente nem sempre funciona em sistemas modernos.
```
Resposta:
```

#### 8. (Processos e Journaling) Você quer analisar logs de um serviço no systemd chamados sshd.service.

Responda:
a) Como visualizar apenas os registros das últimas 2 horas?
```
Resposta:
```
b) Como visualizar os logs do boot anterior?
```
Resposta:
```
c) Por que usar journalctl é superior a ler diretamente /var/log/auth.log em alguns sistemas?
```
Resposta:
```

#### 9. (Sistema de Arquivos e Links) Explique a diferença entre hard link e soft link, citando:

número de inodes
comportamento ao mover arquivos
comportamento ao apagar arquivos
limitações (ex.: partições diferentes)

Depois, considere:

ln file1 file2
rm file1


O que acontece ao acessar file2? Explique usando o conceito de inode.
```
Resposta:
```

#### 10. (Segurança e Permissões Especiais) Um diretório possui as permissões:
```
drwxrws--T 5 root dev 4096 jan 12 09:22 /dados
```

Explique o significado de cada permissão especial:

- s no grupo
- T no others

```
Resposta:
```

Depois responda:

a) O que acontece quando um usuário do grupo dev cria um arquivo dentro de /dados?
```
Resposta:
```
b) O que impede outros usuários de apagar arquivos dentro desse diretório?
```
Resposta:
```
c) Qual comando adiciona ou remove esses bits especiais?
```
Resposta:
```

#### 11) Which command will display the UID of the current user?
A) id -u
B) whoami
C) ls -l
D) groups

#### 12) Which of the following are valid runlevels in SysV init? (Choose TWO)
A) 0
B) 3
C) 8
D) 9