# language: pt
Funcionalidade: Administrador cria um novo projeto

  Contexto:
    Dado que um administrador esteja logado
    E que o administrador visite a página de criação de projetos

  Cenário: Sucesso na criação do projeto
    Quando o administrador preenche os campos de criação de projeto corretamente
    E o administrador clica no botão "Create Project"
    Então o administrador deve estar na página de visualização daquele projeto
    E o administrador deve ver uma mensagem de sucesso na criação do projeto
    E deve ser registrada uma atividade recente de criação do objeto

  Cenário: Falha na criação do projeto (sem nome)
    Quando o administrador preenche os campos de criação de projeto sem preencher o nome
    E o administrador clica no botão "Create Project"
    Então o administrador deve estar na página de criação de projetos
    E o administrador deve ver uma mensagem de nome do projeto obrigatório

  Cenário: Falha na criação do projeto (nome já existente)
    Quando o administrador preenche os campos de criação de projeto com um nome já existente
    E o administrador clica no botão "Create Project"
    Então o administrador deve estar na página de criação de projetos
    E o administrador deve ver uma mensagem de nome do projeto já existente

  Cenário: Desistência
    Quando o administrador clica em "Back to project"
    Então o administrador deve estar na lista de visualização dos projetos