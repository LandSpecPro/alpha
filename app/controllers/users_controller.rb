class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
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
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
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
end