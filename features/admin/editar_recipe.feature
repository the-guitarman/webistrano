# language: pt
Funcionalidade: Administrador edita recipe

  Contexto:
    Dado que um administrador esteja logado
    E que exista uma recipe
    E que o administrador esteja na página de edição da recipe

  Cenário: Sucesso na edição de uma recipe
    Quando o administrador preenche os campos de edição de recipe corretamente
    E o administrador clica no botão "Update"
    Então o administrador deve estar na página de visualização da recipe
    E o administrador deve ver uma mensagem de sucesso na edição da recipe

  Cenário: Falha na edição de uma recipe (nome não preenchido)
    Quando o administrador deixa o campo de nome da recipe vazio
    E o administrador clica no botão "Update"
    Então o administrador deve estar na página de edição da recipe
    E o administrador deve ver uma mensagem de nome da recipe não preenchido

  Cenário: Falha na edição de uma recipe (body não preenchido)
    Quando o administrador deixa o campo de body da recipe vazio
    E o administrador clica no botão "Update"
    Então o administrador deve estar na página de edição da recipe
    E o administrador deve ver uma mensagem de body da recipe não preenchido

  Cenário: Falha na edição de uma recipe (nome já existente)
    Quando o administrador preenche o campo de nome da recipe com um nome já existente
    E o administrador clica no botão "Update"
    Então o administrador deve estar na página de edição da recipe
    E o administrador deve ver uma mensagem de nome já existente
