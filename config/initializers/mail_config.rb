# Email settings
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "mail.example.org",
  :port => 25,
  :domain => 'example.org',
  :user_name => 'example@example.org',
  :password => "",
  :authentication => :login
}