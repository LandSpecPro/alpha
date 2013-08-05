class LocationsController < ApplicationController
  
  include LocationHelper
  include CategoryHelper
  include CustomerioHelper
  include AnalyticsHelper
  # add in before filter to make sure user id matches for setting and removing favorites
  before_filter :require_location_id_active, :only => :set_as_favorite
  before_filter :require_location_id, :only => [:edit, :update, :update_categories, :destroy, :confirm_destroy, :activate_location, :deactivate_location]
  before_filter :require_business_location_matches, :only => [:edit, :update_status, :update, :destroy, :confirm_destroy]
  before_filter :require_business_featured_item_matches, :only => [:delete_featureditem, :confirm_delete_featureditem]
  before_filter :require_user, :except => :view_public
  before_filter :require_business, :except => :view_public
  before_filter :require_user_is_vendor, :only => [:new, :create, :edit, :update, :destroy, :confirm_destroy, :update_categories, :update_status, :update_featured_item]

  def view_public

    @url = params[:public_url]

    if @url.blank?
      redirect_to oops_url(:err_code => 1) #Maybe redirect later to the profile default page that lets users browse public profiles
      return
    end

    @location = Location.where(:public_url => @url, :active => true).first

    if @location.blank?
      redirect_to oops_url(:err_code => 1)
      return
    end

    #add_location_viewed(-1, params[:id])

  end

  def set_public_url

    @location = Location.find(params[:id])
    @publicsettings = LocationPublicSetting.where(:location_id => @location.id).first_or_create

    if @location.blank?
      redirect_to oops_url
    end

    if params[:location][:public_url].blank?
      redirect_to locations_edit_url(:id => @location.id, :settings => true, :url_blank => true)
      return
    else
      params[:location][:public_url] = params[:location][:public_url].gsub(/\s+/, "")
    end

    if @location.update_attributes(params[:location])
      cio_user_public_profile(current_user, @location)
      redirect_to locations_edit_url(:id => @location.id, :settings => true, :update_settings_success => true)
      return
    else
      @product = Product.new
      @productimage = ProductImage.new
      @featureditem = FeaturedItem.new
      params[:settings] = true
      render :template => 'locations/edit'
    end

  end

  def update_public_settings

    @location = Location.find(params[:id])
    @publicsettings = LocationPublicSetting.where(:location_id => @location.id).first_or_create

    if @publicsettings.update_attributes(params[:location_public_setting])
      cio_user_public_profile(current_user, @location)
      redirect_to locations_edit_url(:id => @location.id, :settings => true, :update_settings_success => true)
    else
      # DO SOME ERROR
      redirect_to oops_url
    end


  end


  def new
    @location = Location.new
  end

  def deactivate_location

    Location.find(params[:id]).deactivate

    redirect_back_or_default('/')

  end

  def activate_location

    Location.find(params[:id]).activate
    
    redirect_back_or_default('/')

  end

  def create
    @location = Location.new(params[:location])
    @location.bus_vendor_id = current_user.bus_vendor_id
    @location.busName = current_user.get_business.busName
    @location.format_all_urls

    if @location.save
      flash[:notice] = "New Location Added!"

      cio_user_location(current_user, @location)
      update_weight_rank(@location)
      redirect_to locations_manage_url

    else
      @user = current_user
      @view = 'new_location'
      render :action => :new
    end
  end

  def manage
    @user = current_user
    if Location.where(:bus_vendor_id => @user.bus_vendor_id).count == 0
      redirect_to locations_new_url
    elsif @user.bus_vendor.locations.count == 1
      redirect_to locations_view_url(:id => @user.bus_vendor.locations.first.id)
    else
      @vlocations = @user.bus_vendor.locations
    end
  end

  def edit
    store_location
    @user = current_user
    @product = Product.new
    @productimage = ProductImage.new
    @featureditem = FeaturedItem.new

    @location = Location.where(:id => params[:id]).first
    @location.products.build

    @loccatids = []
    @location.categories.each do |lc|
      @loccatids << lc.id
    end

    @publicsettings = LocationPublicSetting.where(:location_id => @location.id).first_or_create

  end

  def update_categories
    @location = Location.find(params[:id])
    @location.categories.destroy_all #make this only delete ones that weren't included later

    if not params[:categories].nil?
      if params[:categories].count > 1
        params[:categories].each do |c|
          add_category_to_location(Category.find(c), @location)
        end
      else
        add_category_to_location(Category.find(params[:categories].first), @location)
      end

    end

    cio_user_location(current_user, @location)

    redirect_back_or_default('/')

  end

  def update_bio
    @location = Location.find(params[:id])
    @location.bio = params[:bio]
    @location.save
    cio_user_location(current_user, @location)
    update_weight_rank(@location)
    redirect_back_or_default('/')
  end

  def update_status
    @location = Location.find(params[:id])
    @currentStatus = Status.where(:active => true, :location_id => params[:id]).first

    unless @currentStatus.blank?
      @currentStatus.active = false
      @currentStatus.save
    end

    Status.create(:location_id => params[:id], :status => params[:status])

    redirect_back_or_default('/')

  end

  def update_featured_item

    @featureditem = FeaturedItem.find(params[:id])
    @product = @featureditem.get_product
    @image = @featureditem.get_image

    if not params[:featured_item][:image].nil?
      @product_image = ProductImage.new(:product_id => @featureditem.get_product.id, :image => params[:featured_items][:image])
      if @product_image.save
        params[:featured_items][:product_image_id] = @product_image.id
      else
        render template: "products/edit"
      end
    end
    params[:featured_item].delete :image

    params[:featured_item][:price][0] = ''
    if @featureditem.update_attributes(params[:featured_item]) 
      cio_user_location(current_user, Location.find(@featureditem.location_id))
      redirect_back_or_default('/')
    else
      render template: "products/edit"
    end

  end

  def update
    @product = Product.new
    @productimage = ProductImage.new
    @featureditem = FeaturedItem.new
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      cio_user_location(current_user, @location)
      update_weight_rank(@location)
      @location.format_all_urls
      @location.save
      flash[:notice] = "Account updated!"
      redirect_back_or_default('/') 
    else
      #@location = @location.reset_fields_keep_errors(params[:id])
      render :action => :edit
    end
  end

  def search
    store_location

    if params[:distance_from].blank?
      params[:distance_from] = '0'
    end

    if params[:search] == "All Suppliers"
      params[:search] = ''
    end

    @setlocation = nil
    if params[:use_current_location]
      @setlocation = request.location.city + ", " + request.location.state
    else
      @setlocation = params[:custom_location]
    end
    
    @locations = nil
    @otherlocations = nil
    if params[:commit] == 'Search'
      if params[:distance_from] != '0' and params[:search] != ''
        @locations = Location.search_with_distance_and_query(@setlocation, params[:distance_from], params[:search], current_user)
        @otherlocations = ClaimLocation.search_with_distance_and_query(@setlocation, params[:distance_from], params[:search], current_user)
      elsif params[:distance_from] != '0' and params[:search] == ''
        @locations = Location.search_with_distance_only(@setlocation, params[:distance_from], current_user)
        @otherlocations = ClaimLocation.search_with_distance_only(@setlocation, params[:distance_from], current_user)
      elsif params[:distance_from] == '0' and params[:search] != ''
        @locations = Location.search_with_query_only(params[:search])
        @otherlocations = ClaimLocation.search_with_query_only(params[:search])
      elsif params[:distance_from] == '0' and params[:search] == ''
        @locations = Location.where(:active => true).geocoded
        @otherlocations = ClaimLocation.where(:claimed => false).geocoded
      end

      update_search_log
    end

  end

  def view

    store_location

    if Location.where(:id => params[:id], :active => true).count > 0
      @location = Location.find(params[:id])
    else
      if current_user.is_vendor
        if Location.where(:id => params[:id]).count > 0
          @location = Location.find(params[:id])
          if @location.bus_vendor_id != current_user.bus_vendor_id
            redirect_to locations_manage_url
          end
        else
          redirect_to locations_manage_url
        end
      elsif current_user.is_buyer
        redirect_to dashboard_url
      end
    end

    if @location.is_owner(current_user)
      @missingproducts = 3 - @location.featured_items.where(:active => true).count
    else
      @missingproducts = 0
      add_location_viewed(current_user.id, params[:id])
    end

    #@currentstatus = @location.get_current_status(params[:id])

  end

  def set_as_favorite

    @location = Location.find(params[:id])

    if @location.is_favorited(current_user)
      FavLocation.where(:user_id => current_user.id, :location_id => params[:id]).first.deactivate
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

      Location.find(params[:id]).deactivate

      @favlocations = FavLocation.where(:location_id => params[:id])
      @favlocations.each do |fl|
        fl.deactivate
      end

      @featureditems = FeaturedItem.where(:location_id => params[:id])
      @featureditems.each do |fi|
        fi.deactivate
      end

      redirect_back_or_default('/')

  end

  def delete_featureditem

      @featureditem = FeaturedItem.find(params[:featured_item_id])
      @product = @featureditem.get_product
      @image = @featureditem.get_image
      @location = Location.find(params[:location_id])

      if not @featureditem.active
        redirect_back_or_default('/')
      end

  end

  def confirm_delete_featureditem

    @featureditem = FeaturedItem.find(params[:featured_item_id])
    @featureditem.deactivate

    @locid = @featureditem.location_id

    @favproducts = FavProduct.where(:featured_item_id => params[:featured_item_id])
    @favproducts.each do |fp|
      fp.deactivate
    end    

    cio_user_location(current_user, Location.find(@locid))
    redirect_to locations_edit_url(:id => @locid, :products => true)

  end

end
