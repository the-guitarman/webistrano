# language: pt
Funcionalidade: Privilégios de Visualização de hosts, recipes, stages e users

  Contexto:
    Dado que um usuário não administrador esteja logado

  Cenário: o usuário não pode ver link de criação de outro usuário
    Quando o usuário visita a página de listagem de usuários
    Então o usuário não deve ver o link de criação de novos usuários

  Cenário: o usuário não pode ver o link de criação de novos hosts
    Quando o usuário visita a página de listagem de hosts
    Então o usuário não deve ver o link de criação de novos hosts

  Cenário: o usuário não pode ver o link de criação de novos projetos
    Quando o usuário visita a página de listagem de projetos
    Então o usuário não deve ver o link de criação de novos projetos

  Cenário: o usuário não pode ver o link de criação de stages
    Dado que exista um projeto
    E que o usuário logado esteja alocado ao projeto
    Quando o usuário visitar a página do projeto
    Então o usuário não deve ver o link de criação de novos stages

  Cenário: o usuário não pode ver o link de criação de recipes
    Quando o usuário visitar a página de listagem de recipes
    Então o usuário não deve ver o link de criação de novas recipes

  Cenário: o usuário não poder visualizar um projeto em que não está alocado
    Dado que exista um projeto
    Quando o usuário visita a página de listagem de projetos
    Então o usuário não deve ver o projeto na lista

  Cenário: o usuário não pode adicionar outro usuário no projeto
    Dado que exista um projeto
    E que o usuário logado esteja alocado ao projeto
    Quando o usuário visitar a página do projeto
    Então o usuário não deve ver a opção de adicionar outro usuário

  Cenário: o usuário não pode adicionar outro usuário no stage
    Dado que exista um projeto
    E que exista um stage alocado ao projeto
    E que o usuário logado esteja alocado ao projeto
    E que o usuário logado esteja alocado ao stage
    Quando o usuário visitar a página do stage
    Então o usuário não deve ver a opção de adicionar outro usuário
