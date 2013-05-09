class LocationsController < ApplicationController
  include LocationHelper
  before_filter :require_user
  before_filter :require_business
  before_filter :require_user_is_vendor, :only => [:new, :create, :edit, :update, :destroy, :confirm_destroy]

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])
    @location.bus_vendor_id = current_user.bus_vendor_id
    if @location.save
      flash[:notice] = "New Location Added!"

      #redirect_to locations_show_url(:location_id => @location.id)
      redirect_to locations_manage_url

    else
      @user = current_user
      @view = 'new_location'
      render :action => :new
    end
  end

  def manage
    @user = current_user
  end

  def edit
    if vendor_location_id_matches
      @location = Location.find(params[:id])
    else
      redirect_to locations_manage_url
    end
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

  def destroy
    if vendor_location_id_matches
      @location = Location.find(params[:id])
    else
      redirect_to locations_manage_url
    end
  end

  def confirm_destroy

      if vendor_location_id_matches
        Location.destroy(params[:id])
      end

      redirect_to locations_manage_url
    end

end
