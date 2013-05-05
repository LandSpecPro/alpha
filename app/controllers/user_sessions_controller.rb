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
        redirect_to business_vendor_dashboard_url
      elsif UserSession.find.user.is_buyer
        redirect_to business_buyer_dashboard_url
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
end