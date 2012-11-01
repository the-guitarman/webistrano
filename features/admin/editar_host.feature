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
    E o administrador deve ver uma mensagem de usuário editado com sucesso