#encoding: utf-8

Dado /^que o usuário esteja desabilitado$/ do
  @usuario.disable!
end

Dado /^que o administrador esteja na página do usuário desabilitado$/ do
  visit user_path(@usuario)
end

Então /^o administrador deve estar na página de usuários$/ do
  page.should have_content "Users"
end

Então /^o administrador deve ver uma mensagem de usuário habilitado com sucesso$/ do
  page.should have_content "The user was enabled"
end

Então /^deve existir a opção de desabilitação daquele usuário$/ do
  page.should have_content "Delete"
end