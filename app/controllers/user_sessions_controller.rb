class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
    @login_error = params[:login_error]
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      if UserSession.find.user.is_vendor
        redirect_to locations_manage_url
      elsif UserSession.find.user.is_buyer
        redirect_to buyer_dashboard_url
      else
        redirect_to home_url
      end        
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to home_url
  end

  def submit_forgot

    @email = params[:email]

    @user = User.where(:email => @email, :active => true).first
    if @user
      @user.reset_perishable_token!
      Mailers.forgot_email(@user, @user.perishable_token).deliver
      redirect_to forgot_success_url
    else
      redirect_to forgot_url(:invalidemail => true)
    end

  end

end