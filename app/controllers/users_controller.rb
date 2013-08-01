class UsersController < ApplicationController

  include UsersHelper
  include ApplicationHelper
  include CustomerioHelper

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :password_reset, :claim_profile_success]
  
  def request_invite

    @invite = Invite.new

  end

  def create_invite

    @invite = Invite.new(params[:invite])

    if @invite.userType == STRING_VENDOR
      @invite.busType = params[:supplierBusType]
    elsif @invite.userType == STRING_BUYER
      @invite.busType = params[:buyerBusType]
    end

    if @invite.save
      redirect_to invite_success_url(:id => @invite.id)
    else
      render :action => :request_invite
    end

  end

  def invite_confirm
    if params[:id]
      @invite = Invite.find(params[:id])
      Mailers.invite_success_email(@invite.email, @invite.busName).deliver
      Mailers.admin_invite(@invite.email, @invite.busName, @invite.busType, @invite.userType, @invite.state).deliver
    else
      redirect_to invite_request_url
    end

  end

  def new
    @user = User.new
    @invitecode = ''
  end
  
  def create

    @user = User.new(params[:user])

    # Check invite code and agreement to terms and conditions
    @incorrectinvite = is_invite_wrong(params[:invitecode])
    @missingterms = is_missing_terms(params[:terms])
    @confirmemail = is_confirm_email_wrong(@user.email, params[:email_confirmation])

    if @incorrectinvite or @missingterms or @confirmemail
      render :action => :new
      return
    end

    # Set default city and state
    if not request.location.city.empty? and not request.location.state.empty?
      @user.currentCity = request.location.city
      @user.currentState = get_state_abbr(request.location.state)
    else
      @user.currentCity = 'Atlanta'
      @user.currentState = 'GA'
    end

    if @user.save

      update_invite(@user, params[:invitecode])

      # Add new user to Customer.IO
      cio_user_new(@user)

      if @user.userType == STRING_VENDOR
        redirect_to supplier_new_url
      elsif @user.userType == STRING_BUYER
        redirect_to buyer_new_url
      else
        redirect_to oops_url(:err_code => 185)
      end

    else
      flash[:notice] = "Not successful!"
      render :action => :new
      return
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
    
    if params[:user][:userType] == 'Supplier' || params[:user][:userType] == 'supplier'
      params[:user][:userType] = 'Vendor'   
    end

    if @user.update_attributes(params[:user])

      cio_user_new(@user)

      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      if current_user.is_vendor
        @user = current_user
        @bus_vendor = @user.bus_vendor
        @usertype = "Vendor"
        render :template => "bus_vendors/manage"
      elsif current_user.is_buyer
        @user = current_user
        @bus_buyer = @user.bus_buyer
        @usertype = "Buyer"
        render :template => "bus_buyers/manage"
      end
    end
  end

  def dashboard
    @user = current_user
    if @user.is_vendor
      redirect_to locations_manage_url
    elsif @user.is_buyer
      redirect_to locations_search_url
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

  def temp_claim_account
    @user = User.where(:perishable_token => params[:token]).first
    if @user
      @user_session = UserSession.new(@user)
      @user_session.save
      render :action => :password_reset_form
    else
      redirect_to oops_url(:err_code => 19)
    end
  end

  def claim_profile

    @user = User.new
    @location = Location.new
    @claimlocation = nil

    ClaimLocation.where(:claimed => false).each do |l|
      if params[:token] == l.claim_token
        @claimlocation = l
        @userlogin = @claimlocation.user_login
        @useremail = @claimlocation.user_email
      end
    end

    if @claimlocation.blank?
      redirect_to oops_url(:err_code => 20)
    end

  end

  def claim_buyer_profile

    @user = User.new
    @busbuyer = @user.build_bus_buyer

    ClaimBuyer.where(:claimed => false).each do |l|
      if params[:token] == l.claim_token
        @claimbuyer = l
        @userlogin = @claimbuyer.user_login
        @useremail = @claimbuyer.user_email
      end
    end

    if @claimbuyer.blank?
      redirect_to oops_url(:err_code => 20)
      return
    end

    if params[:phone]
      @phone = params[:phone]
    elsif not @claimbuyer.bus_phone.blank?
      @phone = @claimbuyer.bus_phone
    end

  end

  def create_claimed_profile

    # USER: login, email, userType, password
    # BUS_VENDOR: busName
    # LOCATION: primaryPhone, address1, address2, city, state, zip, website, ?latitude, ?longitude (automatic lat and long?)
    @claimlocation = ClaimLocation.find(params[:user][:claim_location_id])
    params[:user].delete :claim_location_id

    @user = User.new(params[:user])
    @location = Location.new

    @userlogin = params[:user][:login]
    @useremail = params[:user][:email]

    @confirmemail = is_confirm_email_wrong(@user.email, params[:email_confirmation])

    if @confirmemail
      render 'claim_profile'
      return
    end

    if claim_user(@claimlocation)

      @claimlocation.claimed = true
      if @claimlocation.save
          redirect_to profile_claim_success_url
          return
      else
        render :action => :claim_profile #CHANGE TO ERROR URL LATER
        return
      end

    else
      render 'claim_profile'
      return
    end

  end

  def create_claimed_buyer_profile

    @claimbuyer = ClaimBuyer.find(params[:user][:claim_profile_id])
    params[:user].delete :claim_profile_id

    @user = User.new(params[:user])
    @busbuyer = @user.build_bus_buyer

    @userlogin = params[:user][:login]
    @useremail = params[:user][:email]

    if params[:phone]
      @phone = params[:phone]
    elsif not @claimbuyer.bus_phone.blank?
      @phone = @claimbuyer.bus_phone
    end

    @confirmemail = is_confirm_email_wrong(@user.email, params[:email_confirmation])

    if @confirmemail
      render 'claim_buyer_profile'
      return
    end

    if claim_user(@claimbuyer)

      @claimbuyer.claimed = true
      if @claimbuyer.save
        redirect_to profile_buyer_claim_success_url
        return
      else
        render :action => :claim_buyer_profile
        return
      end

    else
      render 'claim_buyer_profile'
      return
    end

  end

  def claim_profile_success

    @location = current_user.get_business.locations.first

  end

  def claim_buyer_profile_success

    @user = current_user
    @business = current_user.get_business

  end

end