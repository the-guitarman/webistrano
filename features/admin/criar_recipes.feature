# language: pt
Funcionalidade: Administrador cria uma nova recipe

  Contexto:
    Dado que um administrador esteja logado
    E que o administrador esteja na página de criação de recipes

  Cenário: Sucesso na criação de uma recipe
    Quando o administrador preenche os campos de criação de recipe corretamente
    E o administrador clica no botão "Create recipe"
    Então o administrador deve estar na página de visualização da nova recipe
    E o administrador deve ver uma mensagem de sucesso na criação da recipe

  Cenário: Falha na criação de uma recipe (nome não preenchido)
    Quando o administrador deixa o campo de nome da recipe vazio
    E o administrador clica no botão "Create recipe"
    Então o administrador deve estar na página de criação de recipes
    E o administrador deve ver uma mensagem de nome da recipe não preenchido

  Cenário: Falha na criação de uma recipe (body não preenchido)
    Quando o administrador deixa o campo de body da recipe vazio
    E o administrador clica no botão "Create recipe"
    Então o administrador deve estar na página de criação de recipes
    E o administrador deve ver uma mensagem de body da recipe não preenchido

  Cenário: Falha na criação de uma recipe (nome já existente)
    Quando o administrador preenche o campo de nome da recipe com um nome já existente
    E o administrador clica no botão "Create recipe"
    Então o administrador deve estar na página de criação de recipes
    E o administrador deve ver uma mensagem de nome já existente
