#encoding: utf-8

Dado /^que o administrador esteja na página de usuários$/ do
  visit users_path
end

Então /^o administrador deve estar na página de visualização dos detalhes do usuário desabilitado$/ do
  page.should have_content @usuario.login
  page.should have_content "Edit & change password"
end

Então /^o administrador deve ver uma mensagem de usuário desabilitado com sucesso$/ do
  page.should have_content "User was successfully disabled."
end