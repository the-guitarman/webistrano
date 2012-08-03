class AddLogicalDeletionColumns < ActiveRecord::Migration
  DELETABLES = %w(
    configuration_parameters
    deployments
    hosts
    project_configurations
    projects
    recipes
    roles
    stage_configurations
    stages
    users
  )

  def self.up
    DELETABLES.each do |t|
      add_column t.to_sym, :deleted_at, :datetime
    end
  end

  def self.down
    DELETABLES.each do |t|
      remove_column t.to_sym, :deleted_at
    end
  end
end
