# encoding: utf-8

Dado /^que um administrador esteja logado$/ do
  admin = FactoryGirl.create :admin
  login admin
end

Dado /^que o administrador visite a página de criação de usuários$/ do
  visit new_user_path
end

Quando /^o administrador clica no botão "voltar"$/ do
  click_link "Back to users"
end

Quando /^o administrador preenche todos os campos com dados coerentes$/ do
  fill_in "user_login", with: "naoExiste"
  fill_in "user_password", with: "naoExiste"
  fill_in "user_password_confirmation", with: "naoExiste"
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

Quando /^o administrador preenche o campo de login vazio$/ do
  admin = User.new(login: "admin",
                      password: "123456",
                      password_confirmation: "123456",
                      email: "admin@teste.com")
# fill_in "user_login, with: admin.login
  fill_in "user_password", with: admin.password
  fill_in "user_password_confirmation", with: admin.password
  fill_in "user_email", with: admin.email
end

Então /^a aplicação continua na página de criação de usuários$/ do
  page.should have_button "Create User"
end

Então /^a aplicação mostra erro por campo de login vazio$/ do
  page.should have_content "Login can't be blank"
end

Quando /^o administrador preenche o campo de login com um login existente$/ do
  user = User.create(login: "usuario",
                     password: "123456",
                     password_confirmation: "123456",
                     email: "usuario@teste.com")
  fill_in "user_login", with: user.login
  fill_in "user_password", with: user.password
  fill_in "user_password_confirmation", with: user.password
  fill_in "user_email", with: user.email
end

Então /^a aplicação mostra erro de login existente$/ do
  page.should have_content "Login has already been taken"
end

Quando /^o administrador preenche o campo de e-mail vazio$/ do
  user = FactoryGirl.build :user
  fill_in "user_login", with: user.login
  fill_in "user_password", with: user.password
  fill_in "user_password_confirmation", with: user.password
end

Então /^a aplicação mostra erro por campo de e-mail vazio$/ do
  page.should have_content "Email can't be blank"
end

Quando /^o administrador preenche o campo de e-mail com um e-mail existente$/ do
# User.create para salvar no banco
  user_criado = user = User.create(login: "usuario_antigo",
                password: "123456",
                password_confirmation: "123456",
                email: "usuarioantigo@teste.com")
# User.new para não salvar no banco
  user = user = User.new(login: "usuario_novo",
                password: "123456",
                password_confirmation: "123456",
                email: "usuario@teste.com")
  fill_in "user_login", with: user.login
  fill_in "user_password", with: user.password
  fill_in "user_password_confirmation", with: user.password
  fill_in "user_email", with: user_criado.email
end

Então /^a aplicação mostra erro de e-mail existente$/ do
  page.should have_content "Email has already been taken"
end

Quando /^o administrador preenche o campo de senha e confirmação de senha diferentes$/ do
  user = user = User.new(login: "usuario_antigo",
                password: "123456",
                password_confirmation: "123456",
                email: "usuarioantigo@teste.com")
  fill_in "user_login", with: user.login
  fill_in "user_password", with: user.password
  fill_in "user_password_confirmation", with: user.password<<'1'
  fill_in "user_email", with: user.email
end

Então /^a aplicação mostra erro de senha e confirmação de senha diferentes$/ do
  page.should have_content "Password doesn't match confirmation"
end