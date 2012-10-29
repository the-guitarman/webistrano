# encoding: utf-8

Quando /^o (usuário|administrador) clica no botão "([^']*)"$/ do |obj, botao|
  click_button botao
end

Quando /^o (usuário|administrador) clica em "([^']*)"$/ do |obj, link|
  click_link link
end

Dado /^que o usuário esteja logado$/ do
  login @usuario
end