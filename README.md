# intR64 (interpretador Rinha 64)
Interepretador / Rinha de Compiladores / Escrito em Dart

# Envolvidos

Estrutura e configuração Dart e Docker 
<https://github.com/marleirafa>

Desenvolvimento 
<https://github.com/valmorflores>

# Executar em linux
Para executar use o ./execute.sh

# Executar manualmente em Linux

```sudo docker build --tag 'intr64compile' .
sudo docker run -v /var/rinha/source.rinha.json:/var/rinha/source.rinha.json intr64compile:latest```



# Compilação em Windows (Direta, sem docker)
- Vá na pasta src ;)
- dart compile exe main.dart -o ..\bin\intR64.exe

# Desafio

Desafio publicado em:
https://github.com/aripiprazole/rinha-de-compiler

# Todo
- ~~Fazer pegar do diretorio correto os arquivos~~
- ~~Criar um docker compativel para o projeto~~
- ~~Analisar os critérios~~
- ~~Testar com os demais scripts disponíveis~~
- ~~Adicionar funcionalidades~~
- ~~Compilar em Linux~~
- Fazer pegar pelo prompt nome do programa a executar

# Copie, ~~mas não use~~ mas, use com cuidado
Este é um projeto absultamente experimental. Copie somente para fins de experimentação, mas, jamais em produção.


