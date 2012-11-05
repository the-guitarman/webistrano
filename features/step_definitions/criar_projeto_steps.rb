# encoding: utf-8

Dado /^que o administrador visite a página de criação de projetos$/ do
  visit new_project_path
end

Quando /^o administrador preenche os campos de criação de projeto corretamente$/ do
  fill_in "project_name", with: "Teste"
  select "Mod Rails", from: "project_template"
  fill_in "project_description", with: "Projeto para testes Cucumber"
end

Então /^o administrador deve estar na página de visualização daquele projeto$/ do
  page.should have_content "Project Teste"
  page.should have_content "Edit project"
  page.should have_content "Clone project"
  page.should have_content "Delete project"
end

Então /^o administrador deve ver uma mensagem de sucesso na criação do projeto$/ do
  page.should have_content "Project was successfully created."
end

Quando /^o administrador preenche os campos de criação de projeto sem preencher o nome$/ do
  select "Mod Rails", from: "project_template"
  fill_in "project_description", with: "Projeto para testes Cucumber"
end

Então /^o administrador deve estar na página de criação de projetos$/ do
  page.should have_content "New project"
end

Então /^o administrador deve ver uma mensagem de nome do projeto não preenchido$/ do
  page.should have_content "Name can't be blank"
end

Quando /^o administrador preenche os campos de criação de projeto com um nome já existente$/ do
  project = FactoryGirl.create :project
  fill_in "project_name", with: project.name
  select "Mod Rails", from: "project_template"
  fill_in "project_description", with: "Projeto para testes Cucumber"
end

Então /^o administrador deve ver uma mensagem de nome do projeto já existente$/ do
  page.should have_content "Name has already been taken"
end

Então /^o administrador deve estar na lista de visualização dos projetos$/ do
  current_path.should == projects_path
end