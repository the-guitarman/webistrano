# language: pt
Funcionalidade: Administrador cria um novo recipe

Contexto:
    Dado que um administrador esteja logado
    E que o administrador visite a página de criação de recipes

Cenário: criação de recipe com sucesso
    Quando o administrador preenche os campos de criação de recipes com dados coerentes
    E o administrador clica no botão "Create recipe"
    Então o aplicação direciona para a página do novo recipe

Cenário: erro de criação de recipe com campo nome vazio
    Quando o administrador deixa o campo nome recipe vazio
    E o administrador clica no botão "Create recipe"
    Então o aplicativo continua na página de criação de recipes
    E o aplicação mostra erro por campo de name do recipe vazio

Cenário: erro de criação de recipe com campo body vazio
    Quando o administrador deixa o campo body de recipe vazio
    E o administrador clica no botão "Create recipe"
    Então o aplicativo continua na página de criação de recipes
    E o aplicação mostra erro por campo de body do recipe vazio

Cenário: erro de criação de recipe com recipe existente
    Quando o administrador preenche o campo de recipe com dado existente
    E o administrador clica no botão "Create recipe"
    Então o aplicativo continua na página de criação de recipes
    E o aplicação mostra erro de recipe existente