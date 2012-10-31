# language: pt
Funcionalidade:Privilégios de Visualização de hosts, recipes, stages e users

    Contexto:
    Dado que um usuário não administrador esteja logado

    Cenário: o usuário não pode ver link de criação de outro usuário
    Quando o usuário estiver na página de usuários
    Então não aparece o link de criação de novos usuários

    Cenário: o usuário não pode ver o link de criação de novos hosts
    Quando o usuário estiver na página de hosts
    Então não aparece o link de criação de novos hosts

    Cenário: o usuário não pode ver o link de criação de stages
    Dado que exista um projeto
    E que o usuário esteja alocado no projeto
    Quando o usuário estiver na página do projeto
    Então não aparece o link de criação de novos stages

    Cenário: o usuário não pode ver o link de criação de recipes
    Quando o usuário estiver na página de recipes
    Então não aparece o link de criação de novos recipes

    Cenário: o usuário não poder visualizar um projeto em que não está alocado
    Dado que exista um projeto
    Quando o usuário estiver na página de projetos
    Então não é possível visualizar o projeto

    Cenário: o usuário não pode adicionar outro usuário no projeto
    Dado que exista um projeto
    E que o usuário esteja alocado no projeto
    Quando o usuário estiver na página do projeto
    Então não aparece a opção de adicionar outro usuário

    Cenário: o usuário não pode adicionar outro usuário no stage
    Dado que exista um projeto
    E que exista um stage alocado ao projeto
    E que o usuário esteja alocado no projeto
    E que o usuário esteja alocado no stage
    Quando o usuário estiver na página do stage
    Então não aparece a opção de adicionar outro usuário