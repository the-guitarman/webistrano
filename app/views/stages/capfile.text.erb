load 'deploy'

# ================================================================
# ROLES
# ================================================================

<% @stage.roles.each do |role| %>
  <% if role.role_attribute_hash.blank? -%>
  role :<%= role.name %>, <%= raw capfile_cast(role.hostname_and_port) %>
  <% else -%>
  role :<%= role.name %>, <%=  raw capfile_cast(role.hostname_and_port) %>, <%= raw role.role_attribute_hash.inspect %>
  <% end -%>
<% end %>

# ================================================================
# VARIABLES
# ================================================================

# Webistrano defaults
  set :webistrano_project, <%= raw capfile_cast(@stage.project.webistrano_project_name) %>
  set :webistrano_stage, <%= raw capfile_cast(@stage.webistrano_stage_name) %>

<% @stage.non_prompt_configurations.each do |effective_conf| %>
  set :<%= effective_conf.name.to_sym %>, <%= raw capfile_cast(effective_conf.value) %>
<% end %>

<% @stage.prompt_configurations.each do |conf| %>
  set(:<%= conf.name %>) do
    Capistrano::CLI.ui.ask "Please enter '<%= conf.name.to_sym %>': "
  end
<% end %>

# ================================================================
# TEMPLATE TASKS
# ================================================================

<%= raw @stage.project.tasks %>

# ================================================================
# CUSTOM RECIPES
# ================================================================

<% @stage.recipes.each do |recipe| %>
  <%= raw recipe.body %>
<% end %>

