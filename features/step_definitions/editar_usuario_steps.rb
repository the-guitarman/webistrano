# encoding: utf-8

Dado /^que o administrador esteja na página de edição do usuário$/ do
  visit edit_user_path(@usuario)
end

Quando /^o administrador edita todos os campos de usuário corretamente$/ do
  fill_in "user_login", with: "usuario_editado"
  fill_in "user_password", with: "123456"
  fill_in "user_password_confirmation", with: "123456"
  fill_in "user_email", with: "editado@usuario.com"
end

Então /^o administrador deve estar na página do perfil do usuário editado$/ do
  page.should have_content "User usuario_editado"
end

Então /^o administrador deve ver uma mensagem de sucesso na edição do usuário$/ do
  page.should have_content "User was successfully updated."
end

Então /^o administrador deve estar na página de edição do usuário$/ do
  page.should have_content "Edit user"
  page.should have_button "Update User"
end