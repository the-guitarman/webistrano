# encoding: utf-8

Dado /^que o administrador esteja na página de edição da recipe$/ do
  visit edit_recipe_path(@recipe)
end

Então /^o administrador deve estar na página de visualização da recipe$/ do
  page.should have_content "Recipe: nova_recipe"
end

Então /^o administrador deve ver uma mensagem de sucesso na edição da recipe$/ do
  page.should have_content "Recipe was successfully updated."
end

Então /^o administrador deve estar na página de edição da recipe$/ do
  page.should have_content "Edit recipe"
  page.should have_content "Back to recipe"
end