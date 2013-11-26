class AdminController < ApplicationController

	include AdminHelper
  include ApplicationHelper

  before_filter :require_user_is_admin
  before_filter :require_user_id, :only => :user_view
  
  def main

  end

  def dashboard_weekly

  	@startdate = DateTime.new(2013, 7, 1)
  	@countdate = DateTime.new(2013, 7, 1)

  	@endofdaytoday = DateTime.now.end_of_day

  end

  def dashboard_email

  	 @newsletters = NewsletterEmail.order("created_at DESC").all
     @buyers = User.order("created_at DESC").where('"userType" = ? or "userType" = ?', 'buyer', 'Buyer')
     @suppliers = User.order("created_at DESC").where('"userType" = ? or "userType" = ? or "userType" = ? or "userType" = ?', 'Supplier', 'supplier', 'vendor', 'Vendor')

  end

  def dashboard_users

  end

  def user_view

  	@user = User.find(params[:id])

  end

  def user_verify
        @id = params[:id]
        @newvalue = params[:newvalue]

        @user = User.find(@id)

        @user.verified = @newvalue
        @user.save

        redirect_to params[:redirect_url]
    end

    def user_activate
        @user = User.find(params[:id])

        @user.active = true
        @user.save

        redirect_to params[:redirect_url]
    end

    def user_deactivate
        @user = User.find(params[:id])

        @user.active = false
        @user.save

        redirect_to params[:redirect_url]
    end

    def location_activate
        @loc = Location.find(params[:id])

        @loc.active = true
        @loc.save

        redirect_to user_view_url(:id => params[:user_id])
    end

    def location_deactivate
        @loc = Location.find(params[:id])

        @loc.active = false
        @loc.save

        redirect_to user_view_url(:id => params[:user_id])
    end

end
