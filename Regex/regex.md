Regex (Regular Expressions) é uma forma de descrever padrões de texto para encontrar, validar, substituir ou extrair informações dentro de uma string.

> Uma expressão regular é um método formal de se especificar um padrão de texto.

##### Encontra-se Regex em: 
 
 - Validação de dados (e-mail, CPF, CEP, telefone, senhas)
 - Busca e substituição em editores de texto ou códigos
 - Extração de informações de logs, planilhas ou textos grandes
 - Filtros em ferramentas como grep, sed, awk

Regex utiliza uma linguagem específica com caracteres especiais para definir padrões. Por exemplo: 

 - O ponto (.) significa "qualquer caractere".
 - O asterisco (*) significa "zero ou mais ocorrências" do caractere anterior.
 - O sinal de mais (+) significa "uma ou mais ocorrências" do caractere anterior. 

> Site utilizado para testar scripts REGEX [regex101.com](https://regex101.com/).

#### **RegEx Essencial**
- **`^`**: Linha que **começa** com o termo
- **`$`**: Linha que **termina** com o termo
- **`.`**: Coringa que substitui **qualquer caractere** único
- **`*`**: O caractere anterior aparece **zero ou mais vezes**
- **`[abc]`**: Lista permitida (busca por "a", "b" ou "c")
- **`[a-z]`** / **`[0-9]`**: Intervalos (letras minúsculas ou números)
- **`[^0-9]`**: Lista negada (qualquer caractere que **não** seja número)
- **`+`**: O termo anterior deve aparecer **uma ou mais vezes**
- **`?`**: O termo anterior é **opcional** (zero ou uma vez)
- **`{n,m}`**: Quantificador (ocorre de _n_ a _m_ vezes)
- **`|`**: Operador OU lógico

**Comandos**
- `grep '^root' /etc/passwd` -> Busca linhas que começam com "root"
- `grep 'bash$' /etc/passwd` -> Encontra usuários que o terminal padrão termina com "bash"
- `grep 'd.a' arquivo.txt` -> Casará com "dia", "data", "d3a", etc.
- `grep -E '[0-9]+' texto.txt` -> Extrai linhas que possuem qualquer sequência numérica.
- `grep -E 'erro|falha' /var/log/syslog` -> Filtra logs que contenham "erro" OU "falha".
- `grep -E '^[A-Z]{2,4}' arquivo.txt` -> Linhas iniciando com 2 a 4 letras maiúsculas.


#### Exemplos:

1. Validar CEP (formato 00000-000)
```
^\d{5}-\d{3}$
```

 - `^` → início
 - `\d{5}` → 5 dígitos
 - `-` → traço literal
 - `\d{3}` → 3 dígitos
 - `$` → fim

2. Encontrar todas as palavras que começam com “cat”
```
\bcat\w*\b
``` 

 - `\b`→ limite de palavra
 - `cat` → exatamente "cat"
 - `\w*` → zero ou mais letras/números depois
 - `\b`→ limite final da palavra

3. Validar email
```
^[\w.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$
```

 - `[\w.-]+` → parte antes do @ (letras, números, _, ponto ou hífen)
 - `@` → arroba
 - `[a-zA-Z0-9.-]+` → domínio
 - `\.` → ponto literal
 - `[a-zA-Z]{2,}` → extensão com pelo menos 2 letras