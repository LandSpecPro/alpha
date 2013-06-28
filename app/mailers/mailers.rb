class Mailers < ActionMailer::Base
  default from: "tech@landspecpro.com"
  default_url_options[:host] = "localhost:3000"

  def password_reset_email(user)
  	@user = user
  	mail(:to => user.email, :subject => "LandSpec Pro - Password Reset")
  end

  def invite_success_email(email, busName)
  	@url = "http://www.landspecpro.com"
  	@busName = busName
  	mail(:to => email, :subject => "LandSpec Pro - Invitation Confirmation")
  end
  
end