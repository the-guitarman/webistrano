ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "quantumtecnologia.com",
    :user_name             => "quantecnologia@gmail.com",
    :password             => "quantum123456",
    :authentication       => "plain",
    :enable_starttls_auto => true
}
