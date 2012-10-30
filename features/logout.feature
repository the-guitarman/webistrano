#language: pt
Funcionalidade: Logout

  Cenário: Logout (administrador)
    Dado que um administrador esteja logado
    Quando o usuário clica em "Logout"
    Então o usuário deve estar na página de login

  Cenário: Logout (usuário não administrador)
    Dado que um usuário não administrador esteja logado
    Quando o usuário clica em "Logout"
    Então o usuário deve estar na página de login