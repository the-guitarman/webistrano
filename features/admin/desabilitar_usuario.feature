# language: pt
Funcionalidade: Administrador desabilita um usuário

  Contexto:
    Dado que um administrador esteja logado
    E que exista um usuário
    E que o administrador esteja na página de usuários

  @javascript
  Cenário: Desabilitação de um usuário
    Quando o administrador clica em "Delete"
    E o administrador confirma
    Então o administrador deve estar na página de visualização dos detalhes do usuário desabilitado
    E o administrador deve ver uma mensagem de usuário desabilitado com sucesso