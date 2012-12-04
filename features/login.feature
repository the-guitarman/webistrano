#language: pt
Funcionalidade: Login

  Contexto:
    Dado que exista um usuário
    E que o usuário esteja na página de login

  Cenário: Sucesso no login
    Quando o usuário preenche os campos de login e senha corretamente
    E o usuário clica no botão "Sign in"
    Então o usuário deve estar na página home do sistema

  Cenário: Falha no login
    Quando o usuário preenche o campo de senha com uma senha incorreta
    E o usuário clica no botão "Sign in"
    Então o usuário deve estar na página de login
    E o usuário deve ver uma mensagem de login ou senha inválidos