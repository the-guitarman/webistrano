#encoding: utf-8

Dado /^que o administrador esteja na página de edição de projeto$/ do
  visit edit_project_path(@projeto)
end

Quando /^o administrador preenche os campos de edição de projeto corretamente$/ do
  fill_in "project_name", with: "projeto_editado"
  select "Mod Rails", from: "project_template"
  fill_in "project_description", with: "Projeto editado"
end

Então /^o administrador deve estar na página de visualização dos detalhes do projeto editado$/ do
  page.should have_content "Project projeto_editado"
end

Então /^o administrador deve ver uma mensagem de projeto editado com sucesso$/ do
  page.should have_content "Project was successfully updated."
end

Quando /^o administrador preenche os campos de edição de projeto com o nome em branco$/ do
  fill_in "project_name", with: ""
  fill_in "project_description", with: "Projeto editado"
end

Então /^o administrador deve estar na página de edição de projeto$/ do
  page.should have_content "Edit"
  page.should have_button "Update Project"
end