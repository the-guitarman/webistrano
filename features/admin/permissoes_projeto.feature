# language: pt
Funcionalidade: Permissões de projeto

  Contexto:
    Dado que um administrador esteja logado
    E que exista um projeto
    E que exista um usuário
    E que o administrador está na página do projeto

  Cenário: Os usuários não administradores podem ser alocados a um projeto
    Então o seletor deve conter o usuário

  Cenário: O administrador insere um usuário no projeto
    Quando o administrador seleciona o usuário
    E o administrador clica no botão "Add"
    Então a página deve conter o link do usuário inserido na sessão de usuários do projeto

@javascript
  Cenário: O administrador exclui um usuário do projeto
    E que o usuário esteja alocado ao projeto
    Quando o administrador atualiza a página
    E o administrador clica em "Remove"
    E o administrador confirma
    Então a página não deve conter o link do usuário inserido na sessão de usuários do projeto