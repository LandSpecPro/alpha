class UsersController < ApplicationController

  include UsersHelper
  include ApplicationHelper

  before_filter :require_no_user, :only => [:new, :create]
  
  before_filter :require_user, :only => [:show, :edit, :update, :password_reset, :claim_profile_success, :help, :account, :validation_request]
  before_filter :require_user_email_validated, :only => [:account, :help]
  before_filter :require_user_email_not_validated, :only => [:validation_request]
  before_filter :require_user_details, :only => [:account, :help]

  def new
    @user = User.new
    @invitecode = ''
  end
  
  def create

    @user = User.new(params[:user])

    # Check invite code and agreement to terms and conditions
    @missingterms = is_missing_terms(params[:terms])
    @confirmemail = is_confirm_email_wrong(@user.email, params[:email_confirmation])

    if @missingterms or @confirmemail
      render :action => :new
      return
    end

    if @user.save_without_session_maintenance
      @user.reset_perishable_token!
      Mailers.verify_email_address_email(@user.email, @user.perishable_token).deliver
      redirect_to user_create_validate_url
    else
      flash[:notice] = "Not successful!"
      render :action => :new
      return
    end

  end
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end
  
  def update

    @user = current_user
    
    if current_user.update_attributes(params[:user])
      redirect_to account_url(:update_account_info_success => true)
    else
      render :action => :account
    end

  end

  def send_validation_request
    @user = current_user
    @user.email = params[:user][:email]
    if @user.save
      current_user.reset_perishable_token!
      Mailers.verify_email_address_email(params[:user][:email], current_user.perishable_token).deliver
      current_user_session.destroy
      redirect_to user_create_validate_url
    else
      render :action => :validation_request
    end
  end

  def verify_email
    if current_user and current_user.is_email_verified and current_user.user_detail.blank?
      redirect_to user_details_new_url
    elsif current_user and current_user.is_email_verified and not current_user.user_detail.blank?
      redirect_to main_url
    else
      if params[:token]
        @user = User.find_using_perishable_token(params[:token])
        if not @user
          redirect_to oops_url(:err_code => 19)
          return
        else
          @user.is_email_verified = true
          if not @user.save
            redirect_to oops_url
            return
          else
            UserSession.create(@user)
          end
        end
      else
        @user = current_user
      end
    end
  end

  def validation_request
    @user = current_user
  end

  def validation_sent

  end

  def help

  end

  def account
    @user = current_user
  end

  def dashboard
    @user = current_user
    if @user.is_supplier
      redirect_to locations_manage_url
    elsif @user.is_buyer
      redirect_to search_supplier_url
    end
  end

  def password_reset_form
    if params[:token]
      @user = User.find_using_perishable_token(params[:token])
      unless @user
        redirect_to oops_url(:err_code => 19)
      end
    else
      @user = current_user
    end
  end

  def password_reset_update
    @user = current_user

    if not @user.valid_password?(params[:user][:old_password])
      @wrongoldpass = true
      render :action => :password_reset_form
      return
    end

    params[:user].delete :old_password
    if @user.update_attributes(params[:user])
      redirect_to account_url(:password_update_success => true)
    else
      render :action => :password_reset_form
    end

  end

  def password_forgot_form
    @user = User.find_using_perishable_token(params[:token])
    @user_session = UserSession.new(@user)
    @user_session.save
    unless @user
      redirect_to oops_url(:err_code => 19)
    end
  end

  def password_forgot_update
    @user = current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url(:password_update_success => true)
    else
      render :action => :password_reset_form
    end
  end

end