# encoding: utf-8

Dado /^que o administrador esteja na página de criação de recipes$/ do
  visit new_recipe_path
end
Quando /^o administrador preenche os campos de (?:criação|edição) de recipe corretamente$/ do
  fill_in "recipe_name", with: "nova_recipe"
  fill_in "recipe_body", with: "abc"
end

Então /^o administrador deve estar na página de visualização da nova recipe$/ do
  page.should have_content "Recipe: nova_recipe"
end

Então /^o administrador deve ver uma mensagem de sucesso na criação da recipe$/ do
  page.should have_content "Recipe was successfully created."
end

Quando /^o administrador deixa o campo de nome da recipe vazio$/ do
  fill_in "recipe_name", with: ""
  fill_in "recipe_body", with: "abc"
end

Quando /^o administrador deixa o campo de body da recipe vazio$/ do
  fill_in "recipe_name", with: "nova_recipe"
  fill_in "recipe_body", with: ""
end

Então /^o administrador deve estar na página de criação de recipes/ do
  page.should have_content "New recipe"
  page.should have_button "Create recipe"
end

Então /^o administrador deve ver uma mensagem de nome da recipe não preenchido$/ do
  page.should have_content "Name can't be blank"
end

Então /^o administrador deve ver uma mensagem de body da recipe não preenchido$/ do
  page.should have_content "Body can't be blank"
end

Quando /^o administrador preenche o campo de nome da recipe com um nome já existente$/ do
  recipe = FactoryGirl.create :recipe
  fill_in "recipe_name", with: recipe.name
  fill_in "recipe_body", with: "abc"
end

Então /^o administrador deve ver uma mensagem de nome já existente$/ do
  page.should have_content "Name has already been taken"
end