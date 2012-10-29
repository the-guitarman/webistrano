# language: pt
Funcionalidade: Administrador cria um novo projeto

  Contexto:
    Dado que um administrador esteja logado
    E que o administrador visite a página de criação de projetos

  Cenário: Sucesso na criação do projeto
    Quando o usuário preenche os campos de criação de projeto corretamente
    E o usuário clica no botão "Create Project"
    Então o usuário deve estar na página de visualização daquele projeto
    E o usuário deve ver uma mensagem de sucesso na criação do projeto

  Cenário: Falha na criação do projeto (sem nome)
    Quando o usuário preenche os campos de criação de projeto sem preencher o nome
    E o usuário clica no botão "Create Project"
    Então o usuário deve estar na página de criação de projetos
    E o usuário deve ver uma mensagem de nome do projeto obrigatório

  Cenário: Falha na criação do projeto (nome já existente)
    Quando o usuário preenche os campos de criação de projeto com um nome já existente
    E o usuário clica no botão "Create Project"
    Então o usuário deve estar na página de criação de projetos
    E o usuário deve ver uma mensagem de nome do projeto já existente

  Cenário: Desistência
    Quando o usuário clica em "Back to project"
    Então o usuário deve estar na lista de visualização dos projetos