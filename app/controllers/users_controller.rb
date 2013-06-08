class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :password_reset]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if not request.location.city.empty? and not request.location.state.empty?
      @user.currentCity = request.location.city
      @user.currentState = request.location.state
    else
      @user.currentCity = 'Atlanta'
      @user.currentState = 'GA'
    end

    if @user.save
      flash[:notice] = "Account registered!"

      if @user.userType == STRING_VENDOR
        redirect_to business_vendor_new_url
      elsif @user.userType == STRING_BUYER
        redirect_to business_buyer_new_url
      else
        redirect_to home_url
      end

    else
      flash[:notice] = "Not successful!"
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end
  
  def update

    if params[:user][:company_name]
      update_company_info
    end

    @user = @current_user # makes our views "cleaner" and more consistent    
    params[:user].delete :company_name
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

  def update_company_info
    @business = current_user.get_business
    @business.update_attributes(:busName => params[:user][:company_name])

    if current_user.is_vendor
      @business.locations.each do |l|
        l.update_attributes(:busName => params[:user][:company_name])
      end
    end
  end

  def dashboard
    @user = current_user
    if @user.is_vendor
      redirect_to business_vendor_dashboard_url
    elsif @user.is_buyer
      redirect_to business_buyer_dashboard_url
    end
  end

  def password_reset
    unless params[:success]
      @user = current_user
      @user.reset_perishable_token!
      Mailers.password_reset_email(current_user).deliver
    else
      @user = current_user
    end
  end

  def password_reset_form
    @user = User.find_using_perishable_token(params[:token])
    @user_session = UserSession.new(@user)
    @user_session.save
    unless @user
      redirect_to home_url
    end
  end

  def update_password
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to user_password_reset_url(:success => true)
    else
      render :action => :password_reset_form
    end
  end


end