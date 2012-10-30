#language: pt
Funcionalidade: Apagar um projeto

  Contexto:
    Dado que um administrador esteja logado
    E que exista um projeto
    E que o administrador esteja na página de listagem de projetos

  @javascript
  Cenário: Sucesso na remoção de um projeto
    Quando o administrador clica em "Delete"
    E o administrador confirma
    Então o administrador deve estar na página de listagem de projetos
    E o nome do projeto removido não deve mais existir na listagem