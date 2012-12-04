class Notification < ActionMailer::Base
  
  default :from => 'Webistrano'
  
  def self.webistrano_sender_address=(val)
    default :from => val
  end

  def deployment(deployment, email)
    @deployment = deployment
    
    mail(
      :to      => email,
      :subject => "Deployment of #{deployment.stage.project.name}/#{deployment.stage.name} finished: #{deployment.status}",
      :content_type => 'text/plain'
    )
  end
end
