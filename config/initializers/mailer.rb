class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "sacketty@gmail.com"
  end
end
ActionMailer::Base.delivery_method = :smtp
#ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "abriva.net",
  :authentication => :plain,
  :user_name => "kash.service@abriva.net",
  :password => "_TY65zdTG=09hn"
}
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) #if Rails.env=="development"

