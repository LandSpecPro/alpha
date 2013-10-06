class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  helper_method :current_user_session, :current_user

  def back
    redirect_back_or_default('/')
  end

  def help
    if current_user
      if current_user.is_vendor
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

  def require_business
    if current_user.bus_vendor_id.nil? and current_user.bus_buyer_id.nil?
      store_location
      flash[:notice] = "You must add a company before you can do anything else!"
      if current_user.userType == STRING_VENDOR
        redirect_to supplier_new_url(:no_company => true)
      elsif current_user.userType == STRING_BUYER
        redirect_to buyer_new_url(:no_company => true)
      else
        redirect_to home_url
      end
      return false
    end
  end

  #Should redirect to the edit account/edit profile page, depending on userType
  def require_no_business
    if current_user.userType == STRING_VENDOR
      unless current_user.bus_vendor_id.nil?
        store_location
        flash[:notice] = "Redirecting to account page."
        redirect_to account_url
        return false
      end
    elsif current_user.userType == STRING_BUYER
      unless current_user.bus_buyer_id.nil?
        store_location
        flash[:notice] = "Redirecting to account page."
        redirect_to account_url
        return false
      end
    end
  end

  def require_user_is_vendor
    if current_user.userType != STRING_VENDOR and current_user.userType != 'Vendor'
      flash[:notice] = "You must be a vendor to access this page."
      redirect_back_or_default(main_url)
      return false
    end
  end

  def require_user_is_buyer
    if current_user.userType != STRING_BUYER and current_user.userType != 'Buyer'
      flash[:notice] = "You must be a buyer to access this page."
      redirect_back_or_default(main_url)
      return false
    end
  end

  def should_show_sidebar
    if !current_user
      return false
    else
      return true
    end
  end

  def store_location
  	session[:return_to] = request.url
  end

  def redirect_back_or_default(default)
  	redirect_to(session[:return_to] || default)
  	session[:return_to] = nil
  end

end
