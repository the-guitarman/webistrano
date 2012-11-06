# encoding: utf-8

Então /^o seletor deve conter o usuário$/ do
  page.should have_select("project_user", options: [@usuario.name])
end

Então /^a página (não )?deve conter o link do usuário inserido na sessão de usuários do projeto$/ do |negacao|
  within("#project_users_list") do
    negacao ? (page.should_not have_link(@usuario.name)) : (page.should have_link(@usuario.name))
  end
end

Quando /^o administrador seleciona o usuário$/ do
  select @usuario.name, from: "project_user"
end

Então /^o seletor não deve conter o administrador$/ do
  page.should_not have_selector("project_user", options:[@outro_admin.name])
end

Então /^a página não deve conter o link do administrador inserido na sessão de usuários do projeto$/ do
  within("#project_users_list") do
    page.should_not have_link @outro_admin.name
  end
end