class ApplicationController < ActionController::Base
  protect_from_forgery

  require 'geoip'
  
  helper :all
  helper_method :current_user_session, :current_user

  def back
    redirect_back_or_default('/')
  end

  def help
    if current_user
      if current_user.is_supplier
        redirect_to supplier_help_url
      elsif current_user.is_buyer 
        redirect_to buyer_help_url
      end
    else
      redirect_to home_url
    end
  end

  def submit_feedback
    if current_user
      @username = current_user.login
    else
      @username = nil
    end
    @page_title = params[:page_title]
    Mailers.basic_feedback_email(params[:name], params[:email], params[:feedback], @username, @page_title).deliver
    redirect_to feedback_success_url
  end

  private
  def current_user_session
  	return @current_user_session if defined?(@current_user_session)
  	@current_user_session = UserSession.find
  end

  def current_user
  	return @current_user if defined?(@current_user)
  	@current_user = current_user_session && current_user_session.user
  end

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def require_user
  	unless current_user
  		store_location
  		flash[:notice] = "You must be logged in to access this page"
  		redirect_to login_url(:login_error => true)
  		return false
  	end
  end

  def require_no_user
  	if current_user
  		store_location
  		flash[:notice] = "You must be logged out to access this page"
      redirect_to main_url
  		return false
  	end
  end

  def require_user_email_validated
    if not current_user.is_email_verified
      store_location
      flash[:notice] = "You must validate your email to access this page."
      redirect_to user_validationfailed_url
      return false
    end
  end

  def require_buyer_has_first_and_last_name
    if current_user.is_buyer and (current_user.user_detail.first_name.blank? or current_user.user_detail.last_name.blank?)
      store_location
      flash[:notice] = "You have not entered a first and last name yet!"
      redirect_to user_details_edit_url
      return false
    end
  end

  def require_user_details
    if current_user.user_detail.blank?
      store_location
      flash[:notice] = "You must add user details before you can do anything else!"
      redirect_to user_details_new_url
      return false
    end
  end

  def require_business
    if current_user.bus_vendor_id.nil? and current_user.bus_buyer_id.nil?
      store_location
      flash[:notice] = "You must add a company before you can do anything else!"
      if current_user.userType == STRING_SUPPLIER
        redirect_to supplier_new_url(:no_company => true)
      elsif current_user.userType == STRING_BUYER
        redirect_to buyer_new_url(:no_company => true)
      else
        redirect_to home_url
      end
      return false
    end
  end

  def require_user_is_supplier
    if current_user.userType != STRING_SUPPLIER
      flash[:notice] = "You must be a vendor to access this page."
      redirect_back_or_default(main_url)
      return false
    end
  end

  def require_user_is_buyer
    if current_user.userType != STRING_BUYER
      flash[:notice] = "You must be a buyer to access this page."
      redirect_back_or_default(main_url)
      return false
    end
  end

  def require_user_is_admin
    if current_user.login != 'ohmatt' and current_user.login != 'timwolfedesign' and current_user.login != 'timwolfedesign1'
      flash[:notice] = "Only site administrators can access this page."
      redirect_back_or_default(main_url)
      return false
    end
  end

end
