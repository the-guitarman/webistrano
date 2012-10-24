require 'test_helper'

class DeploymentTest < ActiveSupport::TestCase

  def setup
    @stage = FactoryGirl.create(:stage)
    @role_app = FactoryGirl.create(:role, :name => 'app', :stage => @stage)
    @role_web = FactoryGirl.create(:role, :name => 'app', :stage => @stage)
    
    @deployment = FactoryGirl.create(:deployment, :stage => @stage, :roles => [@role_app, @role_web], :description => 'update code to newest')
  end

  test "creation" do
    Deployment.delete_all
    assert_equal 0, Deployment.count
    
    d = nil
    assert_nothing_raised{
      d = Deployment.new(:task => 'deploy:setup') 
      d.stage = @stage
      d.description = "Update to newest version"
      d.user = FactoryGirl.create(:user)
      d.save!
    }
    
    assert_equal 1, Deployment.count
    assert_equal [d], Role.find(@role_web.id).deployments
    assert_equal [d], Role.find(@role_app.id).deployments
    assert_equal [d], Stage.find(@stage.id).deployments
    assert_equal [@role_app.id, @role_web.id].sort, Deployment.find(d.id).roles.collect(&:id).sort
    
    assert !d.completed?
    assert_equal 'running', d.status
  end
  
  test "validation" do
    # task and stage missing
    d = Deployment.new
    assert !d.valid?
    assert_not_empty d.errors['task']
    assert_not_empty d.errors['stage']
    assert_empty d.errors['description']
    assert_not_empty d.errors['user']
    
    # fix it
    d.stage = @stage
    assert !d.valid?
    assert_not_empty d.errors['user']
    assert_empty d.errors['description']
    assert_not_empty d.errors['task']
    assert_empty d.errors['stage']
    d.task = 'deploy:setup'
    assert !d.valid?
    assert_not_empty d.errors['user']
    assert_empty d.errors['description']
    assert_empty d.errors['task']
    assert_empty d.errors['stage']
    d.description = 'update to newest'
    assert !d.valid?
    assert_not_empty d.errors['user']
    assert_empty d.errors['description']
    assert_empty d.errors['task']
    assert_empty d.errors['stage']
    
    d.user = FactoryGirl.create(:user)
    assert d.valid?
    assert_empty d.errors['user']
    assert_empty d.errors['description']
    assert_empty d.errors['task']
    assert_empty d.errors['stage']
    
    # try status values
    d.status = 'bla'
    assert !d.valid?
    assert_not_empty d.errors['status']
    d.status = 'failed'
    assert d.valid?
    assert_empty d.errors['status']
  end
  
  test "completed_and_status_on_error" do
    assert !@deployment.completed?
    assert !@deployment.success?
    assert_equal 'running', @deployment.status
    
    @deployment.complete_with_error!
    
    assert @deployment.completed?
    assert !@deployment.success?
    assert_equal 'failed', @deployment.status
    
    # second completion is not possible
    assert_raise(RuntimeError){
      @deployment.complete_successfully! 
    }
  end
  
  test "completed_and_status_on_success" do
    assert !@deployment.completed?
    assert !@deployment.success?
    assert_equal 'running', @deployment.status
    
    @deployment.complete_successfully!
    
    assert @deployment.completed?
    assert @deployment.success?
    assert_equal 'success', @deployment.status
    
    # second completion is not possible
    assert_raise(RuntimeError){
      @deployment.complete_with_error! 
    }
  end
  
  test "validation_depends_on_stage_ready_to_deploy" do
    project = FactoryGirl.create(:project, :template => 'rails')
    stage = FactoryGirl.create(:stage, :project => project)
    role = FactoryGirl.create(:role, :stage => stage)
    
    assert stage.deployment_possible?
    
    deployment = Deployment.new(:task => 'shell')
    deployment.stage = stage
    deployment.description = 'description'
    deployment.user = FactoryGirl.create(:user)
    deployment.roles << role
    
    assert deployment.valid?
    
    # now make stage not possible to deploy
    stage.configuration_parameters.find_by_name('repository').destroy rescue nil
    project.configuration_parameters.find_by_name('repository').destroy rescue nil
    stage = Stage.find(stage.id) # stage.reload would not clear attr_accessor
    
    assert !stage.deployment_possible?
    
    deployment = Deployment.new(:task => 'shell')
    deployment.stage = stage
    deployment.roles << role
    
    assert !deployment.valid?
    assert_match /is not ready to deploy/, deployment.errors['stage'].first
  end
  
  test "check_of_stage_prompt_configuration_in_validation" do
    # add a config value that wants a promp
    @stage.configuration_parameters.build(:name => 'password', :prompt_on_deploy => 1).save!
    
    assert !@stage.prompt_configurations.empty?
    
    deployment = Deployment.new
    deployment.stage = @stage
    deployment.task = 'deploy'
    deployment.description = 'bugfix'
    deployment.user = FactoryGirl.create(:user)
    deployment.roles << @stage.roles
    
    assert !deployment.valid?
    assert_not_empty deployment.errors['base']
    assert_match /password/, deployment.errors['base'].inspect
    
    # now give empty pw
    deployment.prompt_config = {:password => ''}
    
    assert !deployment.valid?
    assert_not_empty deployment.errors['base']
    assert_match /password/, deployment.errors['base'].inspect
    
    # now give pw
    deployment.prompt_config = {:password => 'abc'}
    
    assert deployment.valid?, deployment.errors.inspect
    assert_empty deployment.errors['base']
  end
  
  test "prompt_config_init" do
    deployment = Deployment.new
    
    expected_prompt_config = {}
    assert_equal expected_prompt_config, deployment.prompt_config
    
    dep = FactoryGirl.create(:deployment, :stage => @stage)
    
    assert Deployment.count > 0
    
    assert_equal expected_prompt_config, Deployment.find(dep.id).prompt_config
  end
  
  test "completion_alerts_per_mail_when_no_alert_emails_set" do
    # prepare ActionMailer
    emails = prepare_email
    
    @deployment = FactoryGirl.create(:deployment, :stage => @stage)
    
    # no alert emails set
    assert_nil @stage.alert_emails
    @deployment.complete_with_error!
    
    # no alert was sent
    assert emails.empty?
  end
  
  test "completion_alerts_per_mail_when_alert_emails_set_on_error" do
    # prepare ActionMailer
    emails = prepare_email
    
    @deployment = FactoryGirl.create(:deployment, :stage => @stage)
    
    # alert emails set
    @stage.alert_emails = "michael@example.com you@example.com"
    @stage.save!
    
    assert_not_nil @stage.alert_emails
    @deployment.complete_with_error!
    
    # alert was sent to both
    assert_equal 2, emails.size
  end
  
  test "repeat" do
    original = FactoryGirl.create(:deployment, :stage => @stage, :description => 'this is foo', :task => 'foo:bar')
    
    repeater = original.repeat
    
    assert_equal original.task, repeater.task
    assert_equal "Repetition of deployment #{original.id}: \n#{original.description}", repeater.description
  end
  
  test "excluded_hosts_accessor" do
    host = FactoryGirl.create(:host)
    deployment = FactoryGirl.create(:deployment, :excluded_host_ids => [host.id], :stage => @stage)

    assert_equal [host.id], deployment.excluded_host_ids
    assert_equal [host], deployment.excluded_hosts
    
    deployment.excluded_host_ids = host.id.to_s
    assert_equal [host.id], deployment.excluded_host_ids
  end
  
  test "excluded_hosts" do
    host_1 = FactoryGirl.create(:host)
    host_2 = FactoryGirl.create(:host)
    stage = FactoryGirl.create(:stage)
    role_app = FactoryGirl.create(:role, :name => 'app', :stage => stage, :host => host_1)
    role_web = FactoryGirl.create(:role, :name => 'web', :stage => stage, :host => host_2)
    role_db = FactoryGirl.create(:role, :name => 'db', :stage => stage, :host => host_2)
    
    stage.reload
    assert_equal 3, stage.roles.count
    deployment = FactoryGirl.create(:deployment, 
                  :stage => stage, 
                  :excluded_host_ids => [host_1.id])
    
    assert_equal 3, deployment.roles.count
    assert_equal [host_1], deployment.excluded_hosts
                  
    assert_equal [host_2], deployment.deploy_to_hosts
    assert_equal [role_web, role_db].map(&:id).sort, deployment.deploy_to_roles.map(&:id).sort
  end
  
  test "cannot_exclude_all_hosts" do
    stage = FactoryGirl.create(:stage)
    host = FactoryGirl.create(:host)
    role_app = FactoryGirl.create(:role, :name => 'app', :stage => stage, :host => host)
    
    d = Deployment.new
    d.task = 'foo'
    d.stage = stage
    d.description = 'foo bar'
    d.excluded_host_ids = role_app.host.id
    d.user = FactoryGirl.create(:user)

    assert !d.valid?
    assert d.errors['base']
  end
  
  test "cancelling_possible" do
    deployment = FactoryGirl.create(:deployment, :pid => nil, :stage => FactoryGirl.create(:role, :name => 'app').stage, :completed_at => nil)
    assert !deployment.cancelling_possible?
    
    deployment.pid = 123
    assert deployment.cancelling_possible?
    
    deployment.complete_with_error!
    assert !deployment.cancelling_possible?
  end
  
  test "cancel" do
    deployment = FactoryGirl.create(:deployment, :pid => 5542, :stage => FactoryGirl.create(:role, :name => 'app').stage, :completed_at => nil)
    assert deployment.cancelling_possible?, deployment.inspect
    
    Process.expects(:kill).with("SIGINT", 5542)
    Process.expects(:kill).with("SIGKILL", 5542)
    #Kernel.expects(:sleep).with(2).returns(true)
    
    deployment.cancel!
    
    assert deployment.completed?
    assert_equal "canceled", deployment.status
  end
  
  test "cancel_handles_pid_gone" do
    deployment = FactoryGirl.create(:deployment, :pid => 5542, :stage => FactoryGirl.create(:role, :name => 'app').stage, :completed_at => nil)
    assert deployment.cancelling_possible?, deployment.inspect
    
    Process.expects(:kill).with("SIGINT", 5542)
    Process.expects(:kill).with("SIGKILL", 5542).raises("No such PID")

    assert_nothing_raised do
      deployment.cancel!
    end
    
    assert deployment.completed?
    assert_equal "canceled", deployment.status
  end
  
  test "validation_fails_if_stage_locked" do
    stage = FactoryGirl.create(:role, :name => 'app').stage
    stage.lock
    
    assert_raise(ActiveRecord::RecordInvalid) do
      deployment = FactoryGirl.create(:deployment, :stage => stage)
    end
  end
  
  test "validation_does_not_fails_if_stage_locked_but_we_override" do
    stage = FactoryGirl.create(:role, :name => 'app').stage
    stage.lock
    
    assert_nothing_raised do
      deployment = FactoryGirl.create(:deployment, :stage => stage, :override_locking => 1)
    end
    
    stage.reload
    assert stage.locked?
  end
  
  test "completing_with_error_clears_the_stage_lock" do
    stage = FactoryGirl.create(:role, :name => 'app').stage
    deployment = FactoryGirl.create(:deployment, :stage => stage, :completed_at => nil)
    assert deployment.running?

    stage.lock
    
    deployment.complete_with_error!
    
    stage.reload
    assert !stage.locked?
  end
  
  test "completing_success_clears_the_stage_lock" do
    stage = FactoryGirl.create(:role, :name => 'app').stage
    deployment = FactoryGirl.create(:deployment, :stage => stage, :completed_at => nil)
    assert deployment.running?

    stage.lock
    
    deployment.complete_successfully!
    
    stage.reload
    assert !stage.locked?
  end
  
  test "completing_cancelled_clears_the_stage_lock" do
    stage = FactoryGirl.create(:role, :name => 'app').stage
    deployment = FactoryGirl.create(:deployment, :stage => stage, :completed_at => nil, :pid => 919999)
    assert deployment.running?
    stage.lock
    
    Process.stubs(:kill)
    
    deployment.cancel!
    
    stage.reload
    assert !stage.locked?
  end
  
  test "effective_and_prompt_config" do
    stage = FactoryGirl.create(:role, :name => 'app').stage
    stage.configuration_parameters.create!(:name => 'foo123', :value => '123')
    stage.configuration_parameters.create!(:name => 'promptme', :prompt_on_deploy => 1)
    stage.project.configuration_parameters.create!(:name => 'bar-123', :value => '123')
    
    deployment = Deployment.new
    deployment.stage = stage
    deployment.task = 'deploy'
    deployment.description = 'bugfix'
    deployment.user = FactoryGirl.create(:user)
    deployment.roles << stage.roles
    deployment.prompt_config = {'promptme' => '098'}
    
    assert_not_nil deployment.effective_and_prompt_config
    assert deployment.effective_and_prompt_config.map(&:name).include?('foo123') rescue puts deployment.effective_and_prompt_config.inspect
    assert deployment.effective_and_prompt_config.map(&:name).include?('promptme')
    assert deployment.effective_and_prompt_config.map(&:name).include?('bar-123')
  end

end
