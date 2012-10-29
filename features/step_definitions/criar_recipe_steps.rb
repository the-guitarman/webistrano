# encoding: utf-8

Dado /^que o administrador visite a página de criação de recipes$/ do
  visit new_recipe_path
end
Quando /^o administrador preenche os campos de criação de recipes com dados coerentes$/ do
  fill_in "recipe_name", with: "novo_recipe"
  fill_in "recipe_body",with: "abc"
end

Então /^o aplicação direciona para a página do novo recipe$/ do
  visit recipe_path(Recipe.last)
end

Quando /^o administrador deixa o campo nome recipe vazio$/ do
  fill_in "recipe_body",with: "abc"
end

Quando /^o administrador deixa o campo body de recipe vazio$/ do
  fill_in "recipe_name",with: "novo_recipe"
end

Então /^o aplicativo continua na página de criação de recipes/ do
  page.should have_button "Create recipe"
end

Então /^o aplicação mostra erro por campo de name do recipe vazio$/ do
  page.should have_content "Name can't be blank"
end

Então /^o aplicação mostra erro por campo de body do recipe vazio$/ do
  page.should have_content "Body can't be blank"
end

Quando /^o administrador preenche o campo de recipe com dado existente$/ do
  recipe = Recipe.create(name: "recipe_teste",body:"abc")
  fill_in "recipe_name", with: "recipe_teste"
  fill_in "recipe_body",with: "abc"
end

Então /^o aplicação mostra erro de recipe existente$/ do
  page.should have_content "Name has already been taken"
end