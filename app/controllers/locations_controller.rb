class LocationsController < ApplicationController
  before_filter :require_user
  before_filter :require_business
  before_filter :require_user_is_vendor, :only => [:new, :create, :edit, :update]

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])
    @location.bus_vendor_id = current_user.bus_vendor_id
    if @location.save
      flash[:notice] = "New Location Added!"

      redirect_to locations_show_url(:location_id => @location.id)

    else
      flash[:notice] = "Not successful!"
      render :action => :new
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
end
