# encoding: utf-8

Quando /^o usuário visita a página de listagem de usuários$/ do
  visit users_path
end

Então /^o usuário não deve ver o link de criação de novos usuários$/ do
  page.should_not have_content "New user"
end

Quando /^o usuário visita a página de listagem de hosts$/ do
  visit hosts_path
end

Então /^o usuário não deve ver o link de criação de novos hosts$/ do
  page.should_not have_content "New host"
end

Quando /^o usuário visita a página de listagem de projetos$/ do
  visit projects_path
end

Então /^o usuário não deve ver o link de criação de novos projetos$/ do
  page.should_not have_content "New project"
end

Quando /^o usuário visitar a página do projeto$/ do
  visit project_path(@projeto)
end

Então /^o usuário não deve ver o link de criação de novos stages$/ do
  page.should_not have_content "New stage"
end

Então /^o usuário (não )?deve visualizar a stage$/ do |negacao|
  negacao ? (page.should_not have_content @stage.name) : (page.should have_content @stage.name)
end

Quando /^o usuário visitar a página de listagem de recipes$/ do
  visit recipes_path
end

Então /^o usuário não deve ver o link de criação de novas recipes$/ do
  page.should_not have_content "New recipe"
end