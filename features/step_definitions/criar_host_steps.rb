#encoding: utf-8

Dado /^que o administrador esteja na página de criação de hosts$/ do
  visit new_host_path
end

Quando /^o administrador preenche os campos de criação de hosts corretamente$/ do
  fill_in "host_name", with: "novo_host"
end

Então /^o administrador deve estar na página de visualização do novo host$/ do
  page.should have_content "Host novo_host"
  page.should have_content "Edit Host"
  page.should have_content "Delete"
end

Então /^o administrador deve ver uma mensagem de sucesso na criação do host$/ do
  page.should have_content "Host was successfully created."
end

Quando /^o administrador deixa o campo de host vazio$/ do
  fill_in "host_name", with: ""
end

Então /^o administrador deve estar na página de criação de host/ do
  page.should have_content "New host"
  page.should have_button "Create Host"
end

Então /^o administrador deve ver uma mensagem de campo de nome do host obrigatório$/ do
  page.should have_content "Name can't be blank"
end

Quando /^o administrador preenche o campo de host com um nome já existente$/ do
  Host.create(name: "host_teste")
  fill_in "host_name", with: "host_teste"
end

Então /^o administrador deve ver uma mensagem de campo de nome do host já existente$/ do
  page.should have_content "Name has already been taken"
end