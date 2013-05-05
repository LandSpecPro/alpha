class LocationController < ApplicationController
  before_filter :require_user
  before_filter :require_business
  before_filter :require_user_is_vendor, :only => [:new, :create, :edit, :update]

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])
    if @location.save
      flash[:notice] = "New Location Added!"

      redirect_to home_url
      #redirect_to location_show_url(:location_id => @location.id)

    else
      flash[:notice] = "Not successful!"
      render :action => :new
    end
  end

  def edit
  end

  def show
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
