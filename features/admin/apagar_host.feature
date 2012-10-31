#language: pt
Funcionalidade: Apagar um host

  Contexto:
    Dado que um administrador esteja logado
    E que exista um host
    E que o administrador esteja na página de listagem de hosts

  @javascript
  Cenário: Sucesso na remoção de um host
    Quando o administrador clica em "Delete"
    E o administrador confirma
    Então o administrador deve estar na página de listagem de hosts
    E o administrador deve ver uma mensagem de host removido com sucesso
    E o nome do host removido não deve mais existir na listagem