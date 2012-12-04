require 'test_helper'

class ConfigurationParameterTest < ActiveSupport::TestCase

  def setup
    @project = FactoryGirl.create(:project)
    ConfigurationParameter.delete_all # clear default config from template
    @project.reload
    @stage = FactoryGirl.create(:stage, :project => @project)
  end

  test "creation" do
    old_count = ConfigurationParameter.count
    
    assert_nothing_raised{
      c = ProjectConfiguration.new(
        :name => 'scm_username', 
        :value => 'deploy'
      )
      c.project = @project
      c.save!
      
      assert_equal 1, @project.configuration_parameters.size
      
      c = StageConfiguration.new(
        :name => 'scm_username', 
        :value => 'deploy'
      )
      c.stage = @stage
      c.save!
      
      assert_equal 1, @stage.configuration_parameters.size
    }
    
    assert_equal old_count + 2, ConfigurationParameter.count
  end
  
  test "validation_on_unique_config_names" do
    # create a project config
    c = @project.configuration_parameters.build(
      :name => 'scm_username', 
      :value => 'deploy'
    )
    assert c.save
    
    # try to create the same again
    assert_raise(ActiveRecord::RecordInvalid){
      c = @project.configuration_parameters.build(
        :name => 'scm_username', 
        :value => 'deploy'
      )
      c.save!
    }
    
    # but creation of this value for another project is ok
    @second_project = FactoryGirl.create(:project)
    @second_project.configuration_parameters.delete_all
    assert_nothing_raised{
      c = @second_project.configuration_parameters.build(
        :name => 'scm_username', 
        :value => 'deploy'
      )
      c.save!
    }
    
    # but creation of this value for a stage of the project is also ok
    assert_nothing_raised{
      c = @stage.configuration_parameters.build(
        :name => 'scm_username', 
        :value => 'deploy2'
      )
      c.save!
    }
  end
  
  test "effective_configuration" do
    # create a config entry for the project
    c = @project.configuration_parameters.build(
      :name => 'scm_username', 
      :value => 'deploy'
    )
    c.save!
    
    # override it in the stage
    c = @stage.configuration_parameters.build(
      :name => 'scm_username', 
      :value => 'username'
    )
    c.save!
    
    # create a new stage, that should have the original value
    stage_2 = FactoryGirl.create(:stage, :project => @project)
    
    # now check the config values
    assert_equal 'deploy', @project.configuration_parameters.collect(&:value).first
    assert_equal 'username', @stage.configuration_parameters.collect(&:value).first
    assert_equal nil, stage_2.configuration_parameters.collect(&:value).first
    
    # now the effective values for the stages
    assert_equal 'username', @stage.effective_configuration(:scm_username).value
    assert_equal 'deploy', stage_2.effective_configuration(:scm_username).value
    
    assert_equal 1, @stage.effective_configuration.size
    assert_equal 1, stage_2.effective_configuration.size
  end
  
  test "effective_configuration_with_prompt" do
    # create a config entry for the project
    c = @project.configuration_parameters.build(
      :name => 'scm_username', 
      :value => 'deploy'
    )
    c.save!
    
    # override it in the stage with a promps
    c = @stage.configuration_parameters.build(
      :name => 'scm_username', 
      :value => '',
      :prompt_on_deploy => 1
    )
    c.save!
    
    # create a new stage, that should have the original value
    stage_2 = FactoryGirl.create(:stage, :project => @project)
    
    # now check the config values
    assert_equal 'deploy', @project.configuration_parameters.collect(&:value).first
    assert_equal nil, @stage.configuration_parameters.collect(&:value).first
    assert_equal nil, stage_2.configuration_parameters.collect(&:value).first
    
    # now the effective values for the stages
    assert_equal nil, @stage.effective_configuration(:scm_username).value
    assert @stage.effective_configuration(:scm_username).prompt?
    assert_equal 'deploy', stage_2.effective_configuration(:scm_username).value
    assert !stage_2.effective_configuration(:scm_username).prompt?
  end
  
  test "prompt" do
    
    # a param can not have a value and prompt
    assert_nothing_raised{
      c = @project.configuration_parameters.build(
        :name => 'password', 
        :value => 'value',
        :prompt_on_deploy => 1
      )
      c.save!
    }
    
    c = @project.configuration_parameters.build(
      :name => 'password22', 
      :value => '',
      :prompt_on_deploy => 1
    )
    c.save!
    
    assert c.prompt?
    
    c = @project.configuration_parameters.build(
      :name => 'password_2', 
      :value => 'abc',
      :prompt_on_deploy => 0
    )
    c.save!
    
    assert !c.prompt?
    
  end
  
  test "should_not_be_valid_when_name_starts_with_colon" do
    c = @project.configuration_parameters.build(
      :name => ':password_2', 
      :value => 'abc',
      :prompt_on_deploy => 0
    )
    c.valid?
    assert_include "can't contain a colon", c.errors[:name]
  end

  test "should_not_be_valid_when_name_starts_with_spaces_and_colon" do
    c = @project.configuration_parameters.build(
      :name => '   :password_2', 
      :value => 'abc',
      :prompt_on_deploy => 0
    )
    c.valid?
    assert_include "can't contain a colon", c.errors[:name]
  end
  
end
