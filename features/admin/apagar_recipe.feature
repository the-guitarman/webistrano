#language: pt
Funcionalidade: Apagar uma recipe

  Contexto:
    Dado que um administrador esteja logado
    E que exista uma recipe
    E que o administrador esteja na página de listagem de recipes

  @javascript
  Cenário: Sucesso na remoção de uma recipe
    Quando o administrador clica em "Delete"
    E o administrador confirma
    Então o administrador deve estar na página de listagem de recipes
    E o nome da recipe removida não deve mais existir na listagem