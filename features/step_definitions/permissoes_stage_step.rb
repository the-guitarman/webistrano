# encoding: utf-8

Quando /^o administrador visitar a página do stage$/ do
  visit project_stage_path(@projeto,@stage)
end

Então /^a página (não )?deve conter um link do usuário( \(read only\)| \(full access\)) na sessão de usuários$/ do |negacao, acess|
  negacao ? (page.should_not  have_link @usuario.name+acess):(page.should  have_link @usuario.name+acess)
end

Então /^o seletor de usuários da página de stage deve conter o usuário$/ do
  page.should have_select("stage_user_id", options:[@usuario.name])
end

Quando /^o administrador seleciona o usuário na sessão de usuários da página do stage$/ do
  page.select @usuario.name, from: "stage_user_id"
end

Quando /^o administrador seleciona o campo Read Only$/ do
  page.check "stage_user_read_only"
end

Então /^o seletor de usuários da página de stage não deve conter o outro administrador$/ do
  page.should_not have_select("stage_user_id",options: [@outro_admin.name])
end