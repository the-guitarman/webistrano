#encoding: utf-8

Dado /^que o administrador esteja na página de listagem de recipes$/ do
  visit recipes_path
end

Então /^o administrador deve estar na página de listagem de recipes$/ do
  current_path.should == recipes_path
end

Então /^o nome da recipe removida não deve mais existir na listagem$/ do
  page.should_not have_content @recipe.name
end