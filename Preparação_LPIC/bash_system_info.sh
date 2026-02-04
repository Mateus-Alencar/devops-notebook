#!/bin/bash
clear
echo "=================================================="
echo " 🖥️  INFORMAÇÕES DO SISTEMA"
echo "=================================================="

# Host e sistema
echo "Hostname        : $(hostname)"
echo "Sistema         : $(uname -s)"
echo "Kernel          : $(uname -r)"
echo "Arquitetura     : $(uname -m)"
echo "Uptime          : $(uptime -p)"

echo "--------------------------------------------------"

# Data e hora
echo "Data/Hora       : $(date '+%d/%m/%Y %H:%M:%S')"

echo "--------------------------------------------------"

# CPU
echo "CPU:"
lscpu | awk -F: '
/Model name/ {print "  Modelo        :" $2} 
/CPU\(s\)/ {print "  Núcleos       :" $2}
'
# /Model name/ -> Padrão regex
echo "--------------------------------------------------"

# Memória
echo "Memória:"
free -h | awk '
/Mem:/ {print "  Total         : " $2 "\n  Usada         : " $3 "\n  Livre         : " $4}
'

echo "--------------------------------------------------"

# Usuários existentes
echo "Usuários do sistema:"
cut -d: -f1 /etc/passwd
# -d: (Define o delimitador ':')
# -f1 (Seleciona o campo 1)

echo "--------------------------------------------------"

# Usuários logados
echo "Usuários logados agora:"
who || echo "  Nenhum usuário logado"
# Falhar = exit code diferente de 0
echo "--------------------------------------------------"

# Processos
echo "Processos:"
echo "  Total         : $(ps aux | wc -l)"
echo "  Top 5 CPU:"
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 6
# --sort=-%cpu (Ordena pelo uso de CPU)
echo "=================================================="
