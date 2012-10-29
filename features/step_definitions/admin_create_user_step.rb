# encoding: utf-8

Dado /^que um administrador esteja logado$/ do
  admin = FactoryGirl.build :admin
#  admin.admin = true
  admin.save
  login admin
end

Dado /^que o administrador visite a página de criação de usuários$/ do
  visit new_user_path
end

Quando /^o administrador preenche todos os campos com dados coerentes$/ do
  fill_in "user_login", with: "naoExiste"
  fill_in "user_password", with: "123456"
  fill_in "user_password_confirmation", with: "123456"
  fill_in "user_email", with: "nao@existe.com"
end

Quando /^o administrador clica no botão \"criar usuário\"$/ do
  click_button "Create User"
end

Então /^a aplicação direciona para a plágina do perfil do usuário criado$/ do
  current_path.should == user_path(User.last)
end

Quando /^o administrador clica em \"voltar\"$/ do
  click_link "Back to users"
end

Então /^a aplicação direciona para a página dos usuários$/ do
  current_path.should == users_path
end