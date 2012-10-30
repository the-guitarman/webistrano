# encoding: utf-8

Dado /^que um (usuário|administrador) esteja logado$/ do |agente|
  if agente == "usuário"
    agente = FactoryGirl.create :user
  else
    agente = FactoryGirl.create :admin
  end
  login agente
end

Quando /^o (usuário|administrador) clica no botão "([^']*)"$/ do |obj, botao|
  click_button botao
end

Quando /^o (usuário|administrador) clica em "([^']*)"$/ do |obj, link|
  click_link link
end

Dado /^que o usuário esteja logado$/ do
  login @usuario
end

Dado /^que exista um usuário$/ do
  @usuario = FactoryGirl.create :user
end