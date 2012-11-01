# language: pt
Funcionalidade: Administrador cria um novo host

  Contexto:
    Dado que um administrador esteja logado
    E que o administrador esteja na página de criação de hosts

  Cenário: Sucesso na criação de um host
    Quando o administrador preenche os campos de criação de hosts corretamente
    E o administrador clica no botão "Create Host"
    Então o administrador deve estar na página de visualização do novo host
    E o administrador deve ver uma mensagem de sucesso na criação do host
    E deve ser registrada uma atividade recente de criação do objeto

  Cenário: Falha na criação de um host (campo vazio)
    Quando o administrador deixa o campo de host vazio
    E o administrador clica no botão "Create Host"
    Então o administrador deve estar na página de criação de host
    E o administrador deve ver uma mensagem de campo de nome do host obrigatório

  Cenário: Falha na criação de um host (host já existente)
    Quando o administrador preenche o campo de host com um nome já existente
    E o administrador clica no botão "Create Host"
    Então o administrador deve estar na página de criação de host
    E o administrador deve ver uma mensagem de campo de nome do host já existente
