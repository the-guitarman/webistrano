# language: pt
Funcionalidade: Administrador cria um novo host

Contexto:
    Dado que um administrador esteja logado
    E que o administrador visite a página de criação de hosts

Cenário: criação de host com sucesso
    Quando o administrador preenche os campos de criação de hosts com dados coerentes
    E o administrador clica no botão "Create Host"
    Então a aplicação direciona para a página do novo host

Cenário: erro de criação de host com campo vazio
    Quando o administrador deixa o campo de host vazio
    E o administrador clica no botão "Create Host"
    Então a aplicação mostra erro por campo de name vazio