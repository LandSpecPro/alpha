class Mailers < ActionMailer::Base
  default from: "LandSpec Pro <tech@landspecpro.com>"
  default_url_options[:host] = ENV['HOST']

  def welcome_buyer_email(email, first_name, last_name, company_name)
    @email = email
    @first_name = first_name
    @last_name = last_name
    @company_name = company_name
    mail(:to => @email, :subject => "Welcome to the LandSpec Pro ecosystem!")
  end

  def welcome_supplier_email(email, first_name, last_name, company_name)
    @email = email
    @first_name = first_name
    @last_name = last_name
    @company_name = company_name
    mail(:to => @email, :subject => "Welcome to the LandSpec Pro ecosystem!")
  end

  def verify_email_address_email(email, token)
    @email = email
    @token = token
    mail(:to => @email, :subject => "LandSpec Pro - Complete Your Registration")
  end

  def new_user_activation_email(user)
    @userid = user.id
    @username = user.login
    @email = user.email
    @userType = user.userType
    @busName = user.user_detail.company_name
    @busPhone = user.user_detail.phone_number
    mail(:to => 'timwolfe@landspecpro.com', :subject => "LandSpec Pro - New User!")
  end

  def new_location_activation_email(user, location)
    @userid = user.id
    @username = user.login
    @email = user.email
    @userType = user.userType
    @verified = user.verified
    @busName = location.busName
    @busPhone = user.user_detail.phone_number
    @address = location.get_full_address
    mail(:to => 'timwolfe@landspecpro.com', :subject => "LandSpec Pro - New Location!")
  end

  def coverphoto_request_email(name, email, time)
    @name = name
    @email = email
    @when = time
    mail(:to => 'tech@landspecpro.com', :subject => 'New Cover Photo Information Request!')
  end

  def basic_feedback_email(name, email, feedback, username, page_title)
    @name = name
    @email = email
    @feedback = feedback
    @page_title = page_title
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

  def admin_invite(email, busName, busType, userType, state)
    @email = email
    @busName = busName
    @busType = busType
    @userType = userType
    @state = state
    mail(:to => 'timwolfe@landspecpro.com', :subject => "New Invite Request - " + @busName)
  end

  def mass_buyer_claim_profile(login, email, busName, busPhone, claimToken)

    @login = login
    @email = email
    @busName = busName
    @claimToken = claimToken
    mail(:to => @email, :subject => "Claim Your New Profile on LandSpec Pro!")

  end

end