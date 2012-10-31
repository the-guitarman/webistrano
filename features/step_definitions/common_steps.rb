# encoding: utf-8

Dado /^que um (usuário não administrador|administrador) esteja logado$/ do |agente|
  if agente == "usuário não administrador"
    agente = FactoryGirl.create :user
  else
    agente = FactoryGirl.create :admin
  end
  @agente = agente
  login agente
end

Quando /^o (?:usuário|administrador) clica no botão "([^']*)"$/ do |botao|
  click_button botao
end

Quando /^o (?:usuário|administrador) clica em "([^']*)"$/ do |link|
  click_link link
end

Quando /^o administrador confirma$/ do
  page.driver.browser.switch_to.alert.accept
end

Dado /^que exista (?:um|uma) ([^']*)$/ do |obj|
  if obj == "usuário"
    @usuario = FactoryGirl.create :user
  elsif obj == "projeto"
    @projeto = FactoryGirl.create :project
  elsif obj == "host"
    @host = FactoryGirl.create :host
  elsif obj == "recipe"
    @recipe = FactoryGirl.create :recipe
  else
    fail('Este objeto não existe!')
  end
end

Então /^deve ser registrada uma atividade recente de criação do objeto$/ do
  page.should have_content "Recent Activities"
  page.should have_content "Tag"
  page.should have_content "created"
end