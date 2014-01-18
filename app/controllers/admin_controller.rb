class AdminController < ApplicationController

	include AdminHelper
  include ApplicationHelper

  before_filter :require_user_is_admin
  before_filter :require_user_id, :only => :user_view
  
  def dashboard_main

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

        redirect_to admin_user_view_url(:id => params[:user_id])
    end

    def location_deactivate
        @loc = Location.find(params[:id])

        @loc.active = false
        @loc.save

        redirect_to admin_user_view_url(:id => params[:user_id])
    end

    def sign_in_as_user
      current_user_session.destroy
      @usersession = UserSession.new(User.find(params[:id]))
      @usersession.save
      redirect_to main_url
    end

end
