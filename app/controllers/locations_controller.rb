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

  def add_item
    store_location
    @user = current_user

    if vendor_location_id_matches
      @location = Location.find(params[:id])
      @location.products.build
    else
      redirect_to locations_manage_url
    end

  end

  def edit
    store_location
    @user = current_user

    if vendor_location_id_matches
      @location = Location.find(params[:id])
      @location.products.build
    else
      redirect_to locations_manage_url
    end

  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      flash[:notice] = "Account updated!"
      redirect_back_or_default('/') 
    else
      render :action => :edit
    end
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

  def delete_featureditem

    if vendor_can_delete_featured_item
      @featureditem = FeaturedItem.find(params[:featured_item_id])
      @location = Location.find(params[:location_id])
    else
      redirect_to locations_manage_url
    end

  end

  def confirm_delete_featureditem

    if vendor_can_delete_featured_item
      FeaturedItem.destroy(params[:featured_item_id])
      redirect_back_or_default('/')
    else
      redirect_to locations_manage_url
    end
  end

end
