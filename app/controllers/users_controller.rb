class UsersController < ApplicationController
  include UsersHelper
  include ApplicationHelper
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

      if @user.userType == STRING_VENDOR
        redirect_to supplier_new_url
      elsif @user.userType == STRING_BUYER
        redirect_to buyer_new_url
      else
        redirect_to home_url
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

    if params[:user][:company_name]
      update_company_info
    end

    @user = @current_user # makes our views "cleaner" and more consistent 
    
    if params[:user][:userType] == 'Supplier' || params[:user][:userType] == 'supplier'
      params[:user][:userType] = 'Vendor'   
    end

    params[:user].delete :company_name
    params[:user].delete :tagline
    params[:user].delete :busPhone

    if @user.update_attributes(params[:user])
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

  def update_company_info
    @business = current_user.get_business
    @business.update_attributes(:busName => params[:user][:company_name], :tagline => params[:user][:tagline], :busPhone => params[:user][:busPhone])

    if current_user.is_vendor
      @business.locations.each do |l|
        l.update_attributes(:busName => params[:user][:company_name])
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

  def temp_claim_account
    @user = User.where(:perishable_token => params[:token]).first
    if @user
      @user_session = UserSession.new(@user)
      @user_session.save
      render :action => :password_reset_form
    else
      redirect_to home_url #ERROR URL
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
      redirect_to home_url #CHANGE TO ERROR URL LATER
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

  def claim_profile_success

    @location = current_user.get_business.locations.first

  end

end