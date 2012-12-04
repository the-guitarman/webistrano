# language: pt
Funcionalidade: Administrador edita um host

  Contexto:
    Dado que um administrador esteja logado
    E que exista um host
    E que o administrador esteja na página de edição de host

  Cenário: Sucesso na edição de um host
    Quando o administrador preenche o campo corretamente
    E o administrador clica no botão "Update Host"
    Então o administrador deve estar na página de visualização dos detalhes do host editado
    E o administrador deve ver uma mensagem de host editado com sucesso

  Cenário: Falha na edição de um host (nome não preenchido)
    Quando o administrador preenche os campos de edição da recipe com o nome em branco
    E o administrador clica no botão "Update Host"
    Então o administrador deve estar na página de edição de host
    E o administrador deve ver uma mensagem de nome do host não preenchido