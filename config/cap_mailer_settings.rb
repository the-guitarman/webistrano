ActionMailer::Base.delivery_method = :smtp # or :sendmail, or whatever
ActionMailer::Base.smtp_settings = { # if using :smtp
    :address        => "mail.uff.br",
    :port           => 25,
    :domain         => 'uff.br',
    :perform_deliveries => true,
    :user_name      => "no-reply@uff.br",
    :enable_starttls_auto => false

}
ActionMailer::Base.default_charset = "utf-8"# or "latin1" or whatever you are using

CapMailer.configure do |config|
  config[:recipient_addresses]  = ["everton.moreth@gmail.com"]
  # NOTE: THERE IS A BUG IN RAILS 2.3.3 which forces us to NOT use anything but a simple email address string for the sender address.
  # https://rails.lighthouseapp.com/projects/8994/tickets/2340
  # Therefore %("Capistrano Deployment" <releases@example.com>) style addresses may not work in Rails 2.3.3
  config[:sender_address]       = "no-reply@uff.br"
  config[:subject_prepend]      = "[EMPTY-CAP-DEPLOY]"
  config[:site_name]            = "Sistema de Deploy"
end
