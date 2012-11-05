# language: pt
Funcionalidade: Permissões de projeto

  Contexto:
    Dado que um administrador esteja logado
    E que exista um projeto
    E que exista um usuário
    E que o administrador está na página do projeto

  Cenário: Os usuários não administradores podem ser alocados a um projeto
    Então o seletor deve conter o usuário
    Então a página deve conter o link do usuário inserido na sessão de usuários do projeto
    Então a página não deve conter o link do usuário inserido na sessão de usuários do projeto

  Cenário: O administrador insere um usuário no projeto
    Quando o administrador insere o usuário no projeto
    Então a página deve conter o link do usuário inserido na sessão de usuários do projeto

  Cenário: O administrador exclui um usuário do projeto
    E que o usuário esteja alocado ao projeto
    Quando o administrador clica no link "remover" ao lado do usuário alocado no projeto
    Então a página não deve conter o link do usuário inserido na sessão de usuários do projeto