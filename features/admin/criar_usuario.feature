# language: pt
Funcionalidade: Administrador cria um novo usuário

  Contexto:
    Dado que um administrador esteja logado
    E que o administrador visite a página de criação de usuários

  Cenário: Sucesso na criação de um usuário
    Quando o administrador preenche todos os campos com dados coerentes
    E o administrador clica no botão "Create User"
    Então a aplicação direciona para a página do perfil do usuário criado

  Cenário: Desistência
    Quando o administrador clica em "Back to users"
    Então a aplicação direciona para a página dos usuários

  Cenário: Falha na criação de um usuário (login não preenchido)
    Quando o administrador preenche o campo de login vazio
    E o administrador clica no botão "Create User"
    Então a aplicação continua na página de criação de usuários
    E a aplicação mostra erro por campo de login vazio

  Cenário: Falha na criação de um usuário (login já existente)
    Quando o administrador preenche o campo de login com um login existente
    E o administrador clica no botão "Create User"
    Então a aplicação continua na página de criação de usuários
    E a aplicação mostra erro de login existente

  Cenário: Falha na criação de um usuário (e-mail não preenchido)
    Quando o administrador preenche o campo de e-mail vazio
    E o administrador clica no botão "Create User"
    Então a aplicação continua na página de criação de usuários
    E a aplicação mostra erro por campo de e-mail vazio

  Cenário: Falha na criação de um usuário (e-mail já existente)
    Quando o administrador preenche o campo de e-mail com um e-mail existente
    E o administrador clica no botão "Create User"
    Então a aplicação continua na página de criação de usuários
    E a aplicação mostra erro de e-mail existente

  Cenário: Falha na criação de um usuário (senha e confirmação diferentes)
    Quando o administrador preenche o campo de senha e confirmação de senha diferentes
    E o administrador clica no botão "Create User"
    Então a aplicação continua na página de criação de usuários
    E a aplicação mostra erro de senha e confirmação de senha diferentes

