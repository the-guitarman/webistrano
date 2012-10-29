# encoding: utf-8

Dado /^que o administrador visite a página de criação de hosts$/ do
  visit new_host_path
end

Quando /^o administrador preenche os campos de criação de hosts com dados coerentes$/ do
  fill_in "host_name", with: "novo_host"
end

Então /^o aplicação direciona para a página do novo host$/ do
  visit host_path(Host.last)
end

Quando /^o administrador deixa o campo de host vazio$/ do

end

Então /^o aplicativo continua na página de criação de hosts/ do
  page.should have_button "Create Host"
end

Então /^o aplicação mostra erro por campo de name vazio$/ do
  page.should have_content "Name can't be blank"
end

Quando /^o administrador preenche o campo de host com dado existente$/ do
  host = Host.create(name: "host_teste")
  fill_in "host_name", with: "host_teste"
end

Então /^o aplicação mostra erro de host existente$/ do
  page.should have_content "Name has already been taken"
end