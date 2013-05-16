class PasswordReset < ActionMailer::Base
  default from: "mattjohnson@landspecpro.com"

  def password_reset_email(user)
  	@user = user
  	@url = "http://lsp-alpha.herokuapp.com"
  	mail(:to => user.email, :subject => "This is a blank Password Reset Email!")
  end
  
end
