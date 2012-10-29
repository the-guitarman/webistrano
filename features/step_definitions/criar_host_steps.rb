# encoding: utf-8

Dado /^que o administrador visite a página de criação de hosts$/ do
  visit new_host_path
end

Quando /^o administrador preenche os campos de criação de hosts com dados coerentes$/ do
  fill_in "host_name", with: "novo_host"
end

Então /^a aplicação direciona para a página do novo host$/ do
  visit host_path(Host.last)
end