# language: pt
Funcionalidade: Administrador habilita um usuário

  Contexto:
    Dado que um administrador esteja logado
    E que exista um usuário
    E que o usuário esteja desabilitado
    E que o administrador esteja na página do usuário desabilitado

  @javascript
  Cenário: Habilitação de um usuário
    Quando o administrador clica em "Enable"
    E o administrador confirma
    Então o administrador deve estar na página de usuários
    E o administrador deve ver uma mensagem de usuário habilitado com sucesso
    E deve existir a opção de desabilitação daquele usuário