# encoding: utf-8

Dado /^que exista um usuário no sistema$/ do
  @usuario = FactoryGirl.create :user
end

Dado /^que o usuário esteja na página de login$/ do
  visit new_user_session_path
end

Quando /^o usuário preenche os campos de login e senha corretamente$/ do
  fill_in "user_login", with: @usuario.login
  fill_in "user_password", with: @usuario.password
end

Então /^o usuário deve estar na página home do sistema$/ do
  page.should have_content "Welcome to Webistrano, #{@usuario.login}"
end

Quando /^o usuário preenche o campo de senha com uma senha incorreta$/ do
  fill_in "user_login", with: @usuario.login
  fill_in "user_password", with: "654321"
end

Então /^o usuário deve estar na página de login$/ do
  page.should have_content "Webistrano login"
end

Então /^o usuário deverá ver uma mensagem de login ou senha inválidos$/ do
  page.should have_content "Invalid email or password."
end