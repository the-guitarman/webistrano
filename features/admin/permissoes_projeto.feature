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
    Então a página deve conter o usuário inserido na sessão de usuários do projeto

  @javascript
  Cenário: O administrador exclui um usuário do projeto
    E que o usuário esteja alocado ao projeto
    Quando o administrador atualiza a página
    E o administrador clica em Delete sessão de usuários
    E o administrador confirma
    Então a página não deve conter o usuário inserido na sessão de usuários do projeto

  Cenário: Os Administradores não podem ser alocados a um projeto
    Dado que exista outro administrador
    Quando o administrador atualiza a página
    Então o seletor não deve conter o administrador

  Cenário: Os Administradores não podem estar alocados a um projeto
    Dado que exista outro administrador
    Quando o administrador atualiza a página
    Então a página não deve conter o link do administrador inserido na sessão de usuários do projeto
