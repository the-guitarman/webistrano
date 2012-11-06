# language: pt
Funcionalidade: Permissões de Stages

  Contexto:
    Dado que um administrador esteja logado
    E que exista um projeto
    E que exista um stage alocado ao projeto
    E que exista um usuário
    E que o usuário esteja alocado ao projeto

  Cenário: Os usuários não administradores podem ser alocados a um stage
    Quando o administrador visitar a página do stage
    Então o seletor de usuários da página de stage deve conter o usuário

  Cenário: Os usuários administradores não podem ser alocados a uma stage
    Dado que exista outro administrador
    Quando o administrador visitar a página do stage
    Então o seletor de usuários da página de stage não deve conter o outro administrador

  Cenário: O administrador insere um usuário no stage
    Quando o administrador visitar a página do stage
    E o administrador seleciona o usuário na sessão de usuários da página do stage
    E o administrador clica no botão "Add"
    Então a página deve conter um link do usuário (full access) na sessão de usuários

  Cenário: O administrador insere um usuário com restrição no stage
    Quando o administrador visitar a página do stage
    E o administrador seleciona o usuário na sessão de usuários da página do stage
    E o administrador seleciona o campo Read Only
    E o administrador clica no botão "Add"
    Então a página deve conter um link do usuário (read only) na sessão de usuários

  @javascript
  Cenário: O administrador remove um usuário de uma stage
    Dado que o usuário esteja alocado ao stage
    Quando o usuário visitar a página do stage
    E o administrador clica em "Remove"
    E o administrador confirma
    E o administrador atualiza a página
    Então a página não deve conter um link do usuário (read only) na sessão de usuários
    E a página não deve conter um link do usuário (full access) na sessão de usuários
    E o seletor de usuários da página de stage deve conter o usuário