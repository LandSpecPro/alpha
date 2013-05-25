class LocationsController < ApplicationController

  include LocationHelper
  before_filter :require_location_id, :only => [:edit, :update, :destroy, :confirm_destroy, :set_as_favorite]
  before_filter :require_business_location_matches => [:edit, :update_categories, :update, :destroy, :confirm_destroy]
  before_filter :require_business_featured_item_matches => [:delete_featureditem, :confirm_delete_featureditem]
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
    @vlocations = @user.bus_vendor.locations
    if @vlocations.count == 1
      @vlocations.each do |l|
        redirect_to '/locations/edit/' + l.id.to_s
      end
    elsif @vlocations.count == 0
      redirect_to locations_new_url(:new_user_message => true)
    end
  end

  def edit
    store_location
    @user = current_user
    @product = Product.new

    @location = Location.find(params[:id])
    @location.products.build

    @locationcategories = LocationHasCategory.where(:location_id => @location.id)
    @loccatsselected = ['']

    @locationcategories.each do |lc|

      @loccatsselected << Category.find(lc.category_id).id

    end

  end

  def update_categories

    @location = Location.find(params[:id])
    LocationHasCategory.destroy_all(:location_id => params[:id])

    if not params[:categories].nil?
      if params[:categories].count > 1
        params[:categories].each do |c|
          @loccategory = LocationHasCategory.new(:location_id => params[:id], :category_id => c)
          @loccategory.save
        end
      else
        @loccategory = LocationHasCategory.new(:location_id => params[:id], :category_id => params[:categories].first)
        @loccategory.save
      end
    end

    redirect_back_or_default('/')

  end

  def update_featured_item

      @featureditem = FeaturedItem.find(params[:id])
      @fid = 'featured_item_categories' + @featureditem.id.to_s

      if not params[:featured_items][:image].nil?
        @product_image = ProductImage.new(:product_id => @featureditem.get_product.id, :image => params[:featured_items][:image])
        if @product_image.save
          params[:featured_items][:product_image_id] = @product_image.id
        end
      end
      params[:featured_items].delete :image
      @featureditem.update_attributes(params[:featured_items]) 

      ProductHasCategory.destroy_all(:featured_item_id => @featureditem.id)

      if not params[@fid].nil?

        if params[@fid].count > 1
          params[@fid].each do |c|
            @prodcategory = ProductHasCategory.new(:featured_item_id => @featureditem.id, :category_id => c)
            @prodcategory.save
          end
        else
          @prodcategory = ProductHasCategory.new(:featured_item_id => @featureditem.id, :category_id => params[@fid].first)
          @prodcategory.save
        end
      end
      redirect_back_or_default('/')

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
    @sidebar_search_active = true
    @sidebar_search_locations_active = true
    @locations = nil
    if params[:commit] == 'Search'
      if params[:distance_from] != '0' and params[:search] != ''
        @locations = search_with_distance_and_query
      elsif params[:distance_from] != '0' and params[:search] == ''
        @locations = search_with_distance_only
      elsif params[:distance_from] == '0' and params[:search] != ''
        @locations = search_with_query_only
      elsif params[:distance_from] == '0' and params[:search] == ''
        @locations = Location.all
      end
    end
  end

  def search_with_distance_and_query

    if current_user.currentCity.nil?
      @city = 'Atlanta, '
    else
      @city = current_user.currentCity
    end

    if current_user.currentState.nil?
      @state = 'GA, '
    else
      @state = current_user.currentState
    end

    @locsnear = Location.near('' + @city + @state + 'US', params[:distance_from])
    return @locsnear.search_all_locations(params[:search])
  end

  def search_with_distance_only
    if current_user.currentCity.nil?
      @city = 'Atlanta, '
    else
      @city = current_user.currentCity
    end

    if current_user.currentState.nil?
      @state = 'GA, '
    else
      @state = current_user.currentState
    end
    return Location.near('' + @city + @state + 'US', params[:distance_from])
  end

  def search_with_query_only
    return Location.search_all_locations(params[:search])
  end

  def view

    store_location

    @location = Location.find(params[:id])
    # Add in (if vendor owns this location put in an edit button at the top)
  end

  def set_as_favorite

    @location = Location.find(params[:id])

    if @location.is_favorited(current_user)
      @location.remove_favorite(current_user.id, @location.id)
      redirect_back_or_default('/')
    else
      @location.set_favorite(current_user.id, @location.id)
      redirect_back_or_default('/')
    end

  end

  def destroy
    
    @location = Location.find(params[:id])

  end

  def confirm_destroy

      Location.destroy(params[:id])
      FavLocation.destroy_all(:location_id => params[:id])
      FeaturedItems.destroy_all(:location_id => params[:id])
      LoactionHasCategory.destroy_all(:location_id => params[:id])

  end

  def delete_featureditem

      @featureditem = FeaturedItem.find(params[:featured_item_id])
      @location = Location.find(params[:location_id])

  end

  def confirm_delete_featureditem

      FeaturedItem.destroy(params[:featured_item_id])
      ProductHasCategory.destroy_all(:featured_item_id => [:featured_item_id])
      redirect_back_or_default('/')

  end

end
