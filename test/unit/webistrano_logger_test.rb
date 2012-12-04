require 'test_helper'

class Webistrano::LoggerTest < ActiveSupport::TestCase

  def setup
    @project = FactoryGirl.create(:project, :template => 'rails')
    @stage = FactoryGirl.create(:stage, :project => @project)
    @host = FactoryGirl.create(:host)
    
    @stage_with_role = FactoryGirl.create(:stage, :project => @project)
    @role = FactoryGirl.create(:role, :stage => @stage_with_role, :name => 'web', :host => @host)

  end
  
  test "initialization" do
    
    # no deployment given
    assert_raise(ArgumentError){
      logger = Webistrano::Logger.new
    }
    
    assert_raise(NoMethodError){
      logger = Webistrano::Logger.new(nil)
    }
    
    # already completed deployment
    assert_raise(ArgumentError){
      deployment = FactoryGirl.create(:deployment, :stage => @stage_with_role, :task => 'deploy:setup')
      deployment.complete_with_error!
      logger = Webistrano::Logger.new( deployment )  
    }
    
    # not completed deployment
    assert_nothing_raised{
      deployment = FactoryGirl.create(:deployment, :stage => @stage_with_role, :task => 'deploy:setup')
      assert !deployment.completed?
      logger = Webistrano::Logger.new( deployment )  
    }
    
  end
  
  test "log" do
    deployment = FactoryGirl.create(:deployment, :stage => @stage_with_role, :task => 'deploy:setup')
    logger = Webistrano::Logger.new( deployment )
    
    logger.level = Webistrano::Logger::TRACE
    
    logger.debug "schu bi du"
    deployment.reload
    assert_equal "  * schu bi du\n", deployment.log
    
    logger.important "schu bi du"
    deployment.reload
    assert_equal "  * schu bi du\n*** schu bi du\n", deployment.log
    
    logger.info "schu bi du"
    deployment.reload
    assert_equal "  * schu bi du\n*** schu bi du\n ** schu bi du\n", deployment.log
    
    logger.trace "schu bi du"
    deployment.reload
    assert_equal "  * schu bi du\n*** schu bi du\n ** schu bi du\n    schu bi du\n", deployment.log
  end
  
  test "do_no_log_passwords" do
    pw_config = @stage_with_role.configuration_parameters.find_or_create_by_name('scm_password')
    pw_config.value = 'my_secret'
    pw_config.save!
    
    pw_prompt_config = @stage_with_role.configuration_parameters.find_or_create_by_name('password')
    pw_prompt_config.prompt_on_deploy = 1
    pw_prompt_config.save!
    
    @stage_with_role.reload
    
    deployment = FactoryGirl.create(:deployment, :stage => @stage_with_role, :task => 'deploy:setup', :prompt_config => {:password => '@$%deploy@$'})
    logger = Webistrano::Logger.new( deployment )
    logger.level = Webistrano::Logger::TRACE

    logger.info "this is my_secret password"
    deployment.reload
    assert_equal " ** this is XXXXXXXX password\n", deployment.log
    
    logger.info "this is @$%deploy@$ secret password"
    deployment.reload
    assert_equal " ** this is XXXXXXXX password\n ** this is XXXXXXXX secret password\n", deployment.log
  end
  
end
