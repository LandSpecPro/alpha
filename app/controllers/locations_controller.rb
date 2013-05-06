class LocationsController < ApplicationController
  before_filter :require_user
  before_filter :require_business
  before_filter :require_user_is_vendor, :only => [:new, :create, :edit, :update]

  def create
    @location = Location.new(params[:location])
    @location.bus_vendor_id = current_user.bus_vendor_id
    if @location.save
      flash[:notice] = "New Location Added!"

      #redirect_to locations_show_url(:location_id => @location.id)
      redirect_to business_vendor_locations_manage_url

    else
      @user = current_user
      @view = 'new_location'
      render 'bus_vendors/manage'
      #render :controller => :bus_vendors, :action => :new_location
    end
  end

  def edit
  end

  def show
    @location = Location.find(params[:location_id])
  end

  def update
  end

  def search
  end

  def browse
  end

  def favorite
  end

  def view
  end
end
