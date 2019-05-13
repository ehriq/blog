---
title: "Como usar o hugo"
date: 2019-05-12T17:21:49-03:00
draft: true
---

# Parte 1:  iniciando o site

Crie o diretório onde vai ficar o projeto, entre no diretório e rode os comandos, sem esquecer do ponto ao final do segundo comando.

```sh
mkdir meu-site
cd meu-site
hugo new site .
```

Esses comandos criam a estrutura de arquivos e inicializam o repositório *git*. Depois de rodar os comando, são criados vário diretórios, e os mais importantes, nesse momento, são:

- **content**: onde ficam os arquivos de conteúdo.
- **public**: onde fica o site gerado.

Nesse momento, seu site não tem um tema, que é o layout do site. Como ele não tem um tema, não é possível ainda ver o site "funcionando". Você pode criar um tema, mas é mais fácil usar um que já existe; é só escolher um tema em [https://themes.gohugo.io](https://themes.gohugo.io) e baixar para o seu projeto, usando o comando:

```bash
git submodule add *endereço-do-tema* themes/*nome-do-tema*
```

Por exemplo, para usar o tema Ghostwriter, selecione o endereço do tema (normalmente na seção *"installation"* do tema), rode o comando acima como:

```bash
git submodule add https://github.com/jbub/ghostwriter themes/ghostwriter
```

E depois edite o arquivo config.toml para configurar o tema, inserindo ao final a linha `theme = "ghostwriter"`

Com o tema instalado, você já pode ver seu novo site, rodando o comando:

```bash
hugo serve -DF
```

E abrindo o endereço `http://localhost:1313` em seu browser.

## Parte 2: adicionando conteúdo ao seu site.

