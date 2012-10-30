#encoding: utf-8

Dado /^que o administrador esteja na página de listagem de projetos$/ do
  visit projects_path
end

Então /^o administrador deve estar na página de listagem de projetos$/ do
  current_path.should == projects_path
end

Então /^o nome do projeto removido não deve mais existir na listagem$/ do
  page.should_not have_content @projeto.name
end