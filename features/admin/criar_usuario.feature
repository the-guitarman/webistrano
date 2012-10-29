# language: pt
Funcionalidade: Administrador cria um novo usuário

  Contexto:
    Dado que um administrador esteja logado
    E que o administrador visite a página de criação de usuários

  Cenário: criação de usuário com sucesso
    Quando o administrador preenche todos os campos com dados coerentes
    E o administrador clica no botão "Create User"
    Então a aplicação direciona para a plágina do perfil do usuário criado

  Cenário: botão de voltar
    Quando o administrador clica em "Back to users"
    Então a aplicação direciona para a página dos usuários

  Cenário: erro de criação de usuário com campo login vazio
    Quando o administrador preenche o campo de login vazio
    E o administrador clica no botão "Create User"
    Então a aplicação continua na página de criação de usuários
    E a aplicação mostra erro por campo de login vazio

  Cenário: erro de criação de usuário com campo login repetido
    Quando o administrador preenche o campo de login com um login existente
    E o administrador clica no botão "Create User"
    Então a aplicação continua na página de criação de usuários
    E a aplicação mostra erro de login existente

  Cenário: erro de criação de usuário com campo de e-mail vazio
    Quando o administrador preenche o campo de e-mail vazio
    E o administrador clica no botão "Create User"
    Então a aplicação continua na página de criação de usuários
    E a aplicação mostra erro por campo de e-mail vazio

  Cenário: erro de criação de usuário com campo de e-mail repetido
    Quando o administrador preenche o campo de e-mail com um e-mail existente
    E o administrador clica no botão "Create User"
    Então a aplicação continua na página de criação de usuários
    E a aplicação mostra erro de e-mail existente

  Cenário: erro de criação de usuário com campos de senha e confirmação de senha diferentes
    Quando o administrador preenche o campo de senha e confirmação de senha diferentes
    E o administrador clica no botão "Create User"
    Então a aplicação continua na página de criação de usuários
    E a aplicação mostra erro de senha e confirmação de senha diferentes

