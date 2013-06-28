class PasswordReset < ActionMailer::Base
  default from: "LandSpec Pro"
  default_url_options[:host] = "localhost:3000"

  def password_reset_email(user)
  	@user = user
  	mail(:to => user.email, :subject => "LandSpec Pro - Password Reset")
  end
  
end
