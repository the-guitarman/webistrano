# encoding: utf-8

Dado /^que o administrador esteja na página de criação de um usuário$/ do
  visit new_user_path
end

Quando /^o administrador preenche todos os campos de (?:criação|edição) de usuário corretamente$/ do
  fill_in "user_login", with: "novo_usuario"
  fill_in "user_password", with: "123456"
  fill_in "user_password_confirmation", with: "123456"
  fill_in "user_email", with: "novo@usuario.com"
end

Então /^o administrador deve estar na página do perfil do usuário criado$/ do
  page.should have_content "User novo_usuario"
end

Então /^o administrador deve ver uma mensagem de sucesso na criação do usuário$/ do
  page.should have_content "Account created"
end

Quando /^o administrador preenche os campos de (?:criação|edição) de usuário com login vazio$/ do
  fill_in "user_login", with: ""
  fill_in "user_password", with: "123456"
  fill_in "user_password_confirmation", with: "123456"
  fill_in "user_email", with: "usuario@teste.com"
end

Então /^o administrador deve estar na página de criação de um usuário$/ do
  page.should have_content "New user"
  page.should have_button "Create User"
end

Então /^o administrador deve ver uma mensagem de login não preenchido$/ do
  page.should have_content "Login is too short (minimum is 3 characters)"
end

Quando /^o administrador preenche o campo de login com um login existente$/ do
  user = FactoryGirl.create :user
  fill_in "user_login", with: user.login
  fill_in "user_password", with: "123456"
  fill_in "user_password_confirmation", with: "123456"
  fill_in "user_email", with: "invalido@usuario.com"
end

Então /^o administrador deve ver uma mensagem de login já existente$/ do
  page.should have_content "Login has already been taken"
end

Quando /^o administrador preenche os campos de (?:criação|edição) de usuário com e-mail vazio$/ do
  fill_in "user_login", with: "novo_usuario"
  fill_in "user_password", with: "123456"
  fill_in "user_password_confirmation", with: "123456"
  fill_in "user_email", with: ""
end

Então /^o administrador deve ver uma mensagem de e-mail não preenchido$/ do
  page.should have_content "Email can't be blank"
end

Quando /^o administrador preenche o campo de e-mail com um e-mail já existente$/ do
  user = FactoryGirl.create :user
  fill_in "user_login", with: "usuario_invalido"
  fill_in "user_password", with: "123456"
  fill_in "user_password_confirmation", with: "123456"
  fill_in "user_email", with: user.email
end

Então /^o administrador deve ver uma mensagem de e-mail já existente$/ do
  page.should have_content "Email has already been taken"
end

Quando /^o administrador preenche o campo de e-mail com um e-mail inválido$/ do
  fill_in "user_login", with: "usuario_invalido"
  fill_in "user_password", with: "123456"
  fill_in "user_password_confirmation", with: "654321"
  fill_in "user_email", with: "invalido.usuario"
end

Então /^o administrador deve ver uma mensagem de e-mail inválido$/ do
  page.should have_content "Email is invalid"
end

Quando /^o administrador preenche os campos de (?:criação|edição) de usuário com senha vazia$/ do
  fill_in "user_login", with: "usuario_invalido"
  fill_in "user_password", with: ""
  fill_in "user_password_confirmation", with: "654321"
  fill_in "user_email", with: "invalido@usuario.com"
end

Então /^o administrador deve ver uma mensagem de senha não preenchida$/ do
  page.should have_content "Password can't be blank"
end

Quando /^o administrador preenche os campos de senha e confirmação de senha com valores diferentes$/ do
  fill_in "user_login", with: "usuario_invalido"
  fill_in "user_password", with: "123456"
  fill_in "user_password_confirmation", with: "654321"
  fill_in "user_email", with: "invalido@usuario.com"
end

Então /^o administrador deve ver uma mensagem de senha e confirmação diferentes$/ do
  page.should have_content "Password doesn't match confirmation"
end

Então /^o administrador deve estar na página de listagem de usuários$/ do
  page.should have_content "Users"
end