class LocationsController < ApplicationController
autocomplete :product, :commonName
  include LocationHelper
  # add in before filter to make sure user id matches for setting and removing favorites
  before_filter :require_location_id_active, :only => :set_as_favorite
  before_filter :require_location_id, :only => [:edit, :update, :destroy, :confirm_destroy]
  before_filter :require_business_location_matches, :only => [:edit, :update_categories, :update_status, :update, :destroy, :confirm_destroy]
  before_filter :require_business_featured_item_matches, :only => [:delete_featureditem, :confirm_delete_featureditem]
  before_filter :require_user
  before_filter :require_business
  before_filter :require_user_is_vendor, :only => [:new, :create, :edit, :update, :destroy, :confirm_destroy, :update_status, :update_categories, :update_featured_item]

  

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params[:location])
    @location.bus_vendor_id = current_user.bus_vendor_id
    @location.busName = current_user.get_business.busName
    @location.format_all_urls

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
        redirect_to '/locations/edit/' + @vlocations.first.id.to_s
    elsif @vlocations.count == 0
      redirect_to locations_new_url(:new_user_message => true)
    end
  end

  def edit
    store_location
    @user = current_user
    @product = Product.new
    @featureditem = FeaturedItem.new

    @location = Location.where(:id => params[:id]).first
    @location.products.build

    @location.format_all_urls

  end

  def update_bio
    @location = Location.find(params[:id])
    @location.bio = params[:bio]
    @location.save
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
      @product = @featureditem.get_product
      @image = @featureditem.get_image

      @fid = 'featured_item_categories' + @featureditem.id.to_s

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
        redirect_back_or_default('/')
      else
        render template: "products/edit"
      end

      #ProductHasCategory.destroy_all(:featured_item_id => @featureditem.id)

      #if not params[@fid].nil?

       # if params[@fid].count > 1
       #   params[@fid].each do |c|
       #     @prodcategory = ProductHasCategory.new(:featured_item_id => @featureditem.id, :category_id => c)
       #     @prodcategory.save
       #   end
       # else
       #   @prodcategory = ProductHasCategory.new(:featured_item_id => @featureditem.id, :category_id => params[@fid].first)
       #   @prodcategory.save
       # end
      #end

  end

  def update
    @product = Product.new
    @featureditem = FeaturedItem.new
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      flash[:notice] = "Account updated!"
      redirect_back_or_default('/') 
    else
      #@location = @location.reset_fields_keep_errors(params[:id])
      render :action => :edit
    end
  end

  def search
    store_location
    
    @locations = nil
    if params[:commit] == 'Search'
      if params[:distance_from] != '0' and params[:search] != ''
        @locations = Location.search_with_distance_and_query(params[:distance_from], params[:search], current_user)
      elsif params[:distance_from] != '0' and params[:search] == ''
        @locations = Location.search_with_distance_only(params[:distance_from], current_user)
      elsif params[:distance_from] == '0' and params[:search] != ''
        @locations = Location.search_with_query_only(params[:search])
      elsif params[:distance_from] == '0' and params[:search] == ''
        @locations = Location.where(:active => true)
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

      @catrelation = LocationHasCategory.where(:location_id => params[:id])
      @catrelation.each do |cr|
        cr.deactivate
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

    @catrelation = ProductHasCategory.where(:featured_item_id => params[:featured_item_id])
    @catrelation.each do |cr|
      cr.deactivate
    end

    redirect_to locations_edit_url(:id => @locid, :products => true)

  end

end
