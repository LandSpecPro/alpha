class Mailers < ActionMailer::Base
  default from: "tech@landspecpro.com"
  default_url_options[:host] = ENV['HOST']

  def basic_feedback_email(name, email, feedback, username)
    @name = name
    @email = email
    @feedback = feedback
    unless username.blank?
      @username = username
    else
      @username = 'Not logged in'
    end
    mail(:to => 'tech@landspecpro.com', :subject => "LandSpec Pro - Feedback")
  end

  def password_reset_email(user)
  	@user = user
  	mail(:to => user.email, :subject => "LandSpec Pro - Password Reset")
  end

  def invite_success_email(email, busName)
  	@url = "http://www.landspecpro.com"
  	@busName = busName
  	mail(:to => email, :subject => "LandSpec Pro - Invitation Confirmation")
  end

  def forgot_email(user, token)
    @username = user.login
    @email = user.email
    @token = token
    mail(:to => @email, :subject => "LandSpec Pro - Forgotten Username/Password Request")
  end
  
  def feedback_email(reason, email, subject, message)
    @reason = reason
    @email = email
    @subject = subject
    @message = message
    mail(:to => 'tech@landspecpro.com', :subject => "Contact - " + @reason + " - " + @email)
  end

end