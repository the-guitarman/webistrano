require 'test_helper'

class ProjectConfigurationTest < ActiveSupport::TestCase
  
  test "templates" do
    assert_not_nil ProjectConfiguration.templates
    assert_not_nil ProjectConfiguration.templates['rails']
    assert_not_nil ProjectConfiguration.templates['mongrel_rails']
    assert_not_nil ProjectConfiguration.templates['pure_file']
    assert_not_nil ProjectConfiguration.templates['mod_rails']
  end
  
  test "uniqiness_of_name" do
    p = Project.new(:name => 'First')
    p.template = 'rails'
    p.save!
    
    # check that we have a param named 'scm_user'
    assert_not_nil p.configuration_parameters.find_by_name('scm_username')
    
    # try to create such a param and fail
    config = p.configuration_parameters.build(:name => 'scm_username', :value => 'MAMA_MIA')
    assert !config.valid?
    assert_not_empty config.errors['name']
    
    # create a new parameter by hand
    config = p.configuration_parameters.build(:name => 'bla_bla', :value => 'blub_blub')
    config.save!
    
    # try to create 
    config = p.configuration_parameters.build(:name => 'bla_bla', :value => 'MAMA_MIA')
    assert !config.valid?
    assert_not_empty config.errors['name']
  end
end
