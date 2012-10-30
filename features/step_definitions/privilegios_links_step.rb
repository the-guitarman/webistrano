# encoding: utf-8

Quando /^o usuário estiver na página de usuários$/ do
  visit users_path
end

Então /^não aparece o link de criação de novos usuários$/ do
  page.should_not have_content "New user"
end

Quando /^o usuário estiver na página de hosts$/ do
  visit hosts_path
end

Então /^não aparece o link de criação de novos hosts$/ do
  page.should_not have_content "New host"
end

Dado /^que o usuário esteja alocado no projeto$/ do
  @projeto.users << @agente
end

Quando /^o usuário estiver na página um projeto$/ do
  visit project_path(@projeto)
end

Então /^não aparece o link de criação de novos stages?/ do
  page.should_not have_content "New stage"
end

Quando /^o usuário estiver na página de recipes$/ do
  visit recipes_path
end

Então /^não aparece o link de criação de novos recipes$/ do
  page.should_not have_content "New recipe"
end