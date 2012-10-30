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

Quando /^o (usuário|administrador) clica no botão "([^']*)"$/ do |obj, botao|
  click_button botao
end

Quando /^o (usuário|administrador) clica em "([^']*)"$/ do |obj, link|
  click_link link
end

Quando /^o administrador confirma$/ do
  page.driver.browser.switch_to.alert.accept
end

Dado /^que exista um usuário$/ do
  @usuario = FactoryGirl.create :user
end

Dado /^que exista um projeto$/ do
  @projeto = FactoryGirl.create :project
end