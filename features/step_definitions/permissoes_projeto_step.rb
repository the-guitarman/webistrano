# encoding: utf-8

Então /^o seletor deve conter o usuário$/ do
  page.should have_select("project_user", options: [@usuario.name])
end

Então /^a página (não )?deve conter o usuário inserido na sessão de usuários do projeto$/ do |negacao|
  save_and_open_page
  within("#project_users_list") do
    negacao ? (page.should_not have_link("Profile")) : (page.should have_link("Profile"))
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

Quando /^o administrador clica em Delete sessão de usuários$/ do
  within("#project_users_list") do
    click_link "Delete"
  end
end