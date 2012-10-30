# language: pt
Funcionalidade:Privilégios de Visualização de links e butões de criação de hosts, recipes, stages e users

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
    Quando o usuário estiver na página um projeto
    Então não aparece o link de criação de novos stages

    Cenário: o usuário não pode ver o link de criação de recipes
    Quando o usuário estiver na página de recipes
    Então não aparece o link de criação de novos recipes

