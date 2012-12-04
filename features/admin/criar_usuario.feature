# language: pt
Funcionalidade: Administrador cria um novo usuário

  Contexto:
    Dado que um administrador esteja logado
    E que o administrador esteja na página de criação de um usuário

  Cenário: Sucesso na criação de um usuário
    Quando o administrador preenche todos os campos de criação de usuário corretamente
    E o administrador clica no botão "Create User"
    Então o administrador deve estar na página do perfil do usuário criado
    E o administrador deve ver uma mensagem de sucesso na criação do usuário

  Cenário: Falha na criação de um usuário (login não preenchido)
    Quando o administrador preenche os campos de criação de usuário com login vazio
    E o administrador clica no botão "Create User"
    Então o administrador deve estar na página de criação de um usuário
    E o administrador deve ver uma mensagem de login não preenchido

  Cenário: Falha na criação de um usuário (login já existente)
    Quando o administrador preenche o campo de login com um login existente
    E o administrador clica no botão "Create User"
    Então o administrador deve estar na página de criação de um usuário
    E o administrador deve ver uma mensagem de login já existente

  Cenário: Falha na criação de um usuário (e-mail não preenchido)
    Quando o administrador preenche os campos de criação de usuário com e-mail vazio
    E o administrador clica no botão "Create User"
    Então o administrador deve estar na página de criação de um usuário
    E o administrador deve ver uma mensagem de e-mail não preenchido

  Cenário: Falha na criação de um usuário (e-mail já existente)
    Quando o administrador preenche o campo de e-mail com um e-mail já existente
    E o administrador clica no botão "Create User"
    Então o administrador deve estar na página de criação de um usuário
    E o administrador deve ver uma mensagem de e-mail já existente

  Cenário: Falha na criação de um usuário (e-mail com formato inválido)
    Quando o administrador preenche o campo de e-mail com um e-mail inválido
    E o administrador clica no botão "Create User"
    Então o administrador deve estar na página de criação de um usuário
    E o administrador deve ver uma mensagem de e-mail inválido

  Cenário: Falha na criação de um usuário (senha não preenchida)
    Quando o administrador preenche os campos de criação de usuário com senha vazia
    E o administrador clica no botão "Create User"
    Então o administrador deve estar na página de criação de um usuário
    E o administrador deve ver uma mensagem de senha não preenchida

  Cenário: Falha na criação de um usuário (senha e confirmação diferentes)
    Quando o administrador preenche os campos de senha e confirmação de senha com valores diferentes
    E o administrador clica no botão "Create User"
    Então o administrador deve estar na página de criação de um usuário
    E o administrador deve ver uma mensagem de senha e confirmação diferentes

  Cenário: Desistência
    Quando o administrador clica em "Back to users"
    Então o administrador deve estar na página de listagem de usuários
