# encoding: utf-8

Então /^não é possível visualizar o projeto$/ do
  page.should_not have_link @projeto.name
end

Então /^não é possível visualizar o stage$/ do
  page.should_not have_link @stage.name
end

Então /^não aparece a opção de adicionar outro usuário$/ do
  page.should_not have_content "Add user"
end

Quando /^o usuário estiver na página do stage$/ do
  visit project_stage_path(@projeto,@stage)
end

Quando /^o usuário estiver na página de projetos$/ do
  visit projects_path
end