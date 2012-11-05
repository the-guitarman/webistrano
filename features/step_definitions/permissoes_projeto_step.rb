# encoding: utf-8

Então /o seletor deve conter o usuário$/ do
  page.should have_select("project_user", options: [@usuario.name])
end

Então /^a página não deve conter o link do usuário inserido na sessão de usuários do projeto$/ do
#  page.find(:css, "#id")
#  page.find(:xpath, "//table[@id='id']")
#  puts "oi"
  within("//table[@id='project_users_table']") do
    page.should_not have_content @usuario.name
  end
end

Então /^a página deve conter o link do usuário inserido na sessão de usuários do projeto$/ do
#    debugger
#  puts "oi"
  within_table("#project_users_table") do
    page.should have_content @usuario.name
  end

end