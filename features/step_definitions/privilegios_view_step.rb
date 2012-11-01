# encoding: utf-8

Então /^o usuário não deve ver o projeto na lista$/ do
  page.should_not have_link @projeto.name
end

Então /^o usuário não deve ver a opção de adicionar outro usuário$/ do
  page.should_not have_content "Add user"
end

Quando /^o usuário visitar a página do stage$/ do
  visit project_stage_path(@projeto, @stage)
end