class AdminController < ApplicationController

	include AdminHelper
  include ApplicationHelper
  include LocationHelper
  include UsersHelper

  before_filter :require_user_is_admin
  before_filter :require_user_id, :only => :user_view
  
  def dashboard_main

  end

  def dashboard_locations
    store_location

    @c_locs = Location.where(:claimed => true)
    @uc_locs = Location.where(:claimed => false)
  end

  def delete_unclaimed_location
    if not params[:id]
      redirect_to admin_locations_url(:delete_error => true)
    else
      if Location.find(params[:id]).user_detail_id > 0
        # Show error if it is not an unclaimed location
        redirect_to admin_locations_url(:delete_error => true)
      else
        Location.find(params[:id]).destroy
        redirect_to admin_locations_url(:delete_success => true)
      end
    end
  end

  def dashboard_weekly

  	@startdate = DateTime.new(2013, 7, 1)
  	@countdate = DateTime.new(2013, 7, 1)

  	@endofdaytoday = DateTime.now.end_of_day

  end

  def dashboard_email

  	 @newsletters = NewsletterEmail.order("created_at DESC").all
     @buyers = User.order("created_at DESC").where(:userType => STRING_BUYER)
     @suppliers = User.order("created_at DESC").where(:userType => STRING_SUPPLIER)

  end

  def dashboard_users
    store_location
  end

  def dashboard_add_users
    @user = User.new
  end

  def add_new_user
    @user = User.new(params[:user])
    @user.is_email_verified = true
    @user.verified = true

    if @user.save_without_session_maintenance
      redirect_to admin_users_url
    else
      flash[:notice] = "Not successful!"
      render :action => :dashboard_add_users
      return
    end
  end

  def dashboard_add_locations
    @location = Location.new
  end

  def add_new_location
    @location = Location.new(params[:location])

    @location.format_all_urls
    @location.active = true
    @location.verified = true
    @location.claimed = false
    @location.url_is_custom = true
    @location.user_detail_id = 0

    if @location.save
      flash[:notice] = "New Location Added!"

      #TODO: Do we want this in the news feed?
      #news_feed_new_location(@location.id)

      redirect_to admin_locations_url

    else
      render :action => :dashboard_add_locations
    end

  end

  def user_view
    store_location
  	@user = User.find(params[:id])

  end

  def user_verify
        @id = params[:id]
        @newvalue = params[:newvalue]

        @user = User.find(@id)

        @user.verified = @newvalue
        if @user.is_supplier
          if not @user.user_detail.blank?
            if @user.user_detail.locations.count > 0
              @user.user_detail.locations.each do |l|
                l.active = @newvalue
              end
            end
          end
        end
        @user.save

        redirect_to params[:redirect_url]
    end

    def user_activate
        @user = User.find(params[:id])

        @user.active = true
        if @user.is_supplier
          if not @user.user_detail.blank?
            if @user.user_detail.locations.count > 0
              @user.user_detail.locations.each do |l|
                l.active = true
              end
            end
          end
        end
        @user.save

        redirect_to params[:redirect_url]
    end

    def user_deactivate
        @user = User.find(params[:id])

        @user.active = false
        if @user.is_supplier
          if not @user.user_detail.blank?
            if @user.user_detail.locations.count > 0
              @user.user_detail.locations.each do |l|
                l.active = false
              end
            end
          end
        end
        @user.save

        redirect_to params[:redirect_url]
    end

    def location_activate
        @loc = Location.find(params[:id])

        @loc.active = true
        @loc.save

        if params[:redirect_url]
          redirect_to params[:redirect_url]
          return
        else
          redirect_to admin_user_view_url(:id => params[:user_id])
          return
        end
    end

    def location_deactivate
        @loc = Location.find(params[:id])

        @loc.active = false
        @loc.save

        if params[:redirect_url]
          redirect_to params[:redirect_url]
          return
        else
          redirect_to admin_user_view_url(:id => params[:user_id])
          return
        end
    end

    def sign_in_as_user
      current_user_session.destroy
      @usersession = UserSession.new(User.find(params[:id]))
      @usersession.save
      redirect_to main_url
    end

end
