#encoding: utf-8

Dado /^que o administrador esteja na página de listagem de hosts$/ do
  visit hosts_path
end

Então /^o administrador deve estar na página de listagem de hosts$/ do
  current_path.should == hosts_path
end

Então /^o nome do host removido não deve mais existir na listagem$/ do
  page.should_not have_content @host.name
end