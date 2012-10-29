#language: pt
Funcionalidade: Logout

  Contexto:
    Dado que exista um usuário no sistema
    E que o usuário esteja logado

  Cenário: Logout
    Quando o usuário clica em "Logout"
    Então o usuário deve estar na página de login