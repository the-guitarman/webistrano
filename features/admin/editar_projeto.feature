# language: pt
Funcionalidade: Administrador edita um projeto

  Contexto:
    Dado que um administrador esteja logado
    E que exista um projeto
    E que o administrador esteja na página de edição de projeto

  Cenário: Sucesso na edição de um projeto
    Quando o administrador preenche os campos de edição de projeto corretamente
    E o administrador clica no botão "Update Project"
    Então o administrador deve estar na página de visualização dos detalhes do projeto editado
    E o administrador deve ver uma mensagem de projeto editado com sucesso

  Cenário: Falha na edição de um projeto (nome não preenchido)
    Quando o administrador preenche os campos de edição de projeto com o nome em branco
    E o administrador clica no botão "Update Project"
    Então o administrador deve estar na página de edição de projeto
    E o administrador deve ver uma mensagem de nome do projeto não preenchido