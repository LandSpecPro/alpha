class LocationsController < ApplicationController

  include LocationHelper
  include CategoryHelper
  include AnalyticsHelper
  include ApplicationHelper
  include NewsFeedHelper
  
  before_filter :require_user, :except => [:view_public, :inventory_view]
  before_filter :require_user_email_validated, :except => [:view_public, :inventory_view]
  before_filter :require_user_details, :except => [:view_public, :inventory_view]
  
  before_filter :require_location_id, :only => [:edit, :update, :update_categories, :destroy, :confirm_destroy, :activate_location, :deactivate_location, :inventory_view]
  before_filter :require_business_location_matches, :only => [:edit, :update_status, :update, :destroy, :confirm_destroy]
  before_filter :require_business_featured_item_matches, :only => [:delete_featureditem, :confirm_delete_featureditem]
  before_filter :require_location_active_unless_owner, :only => [:view]

  before_filter :require_buyer_has_first_and_last_name, :except => [:view_public, :inventory_view]

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
    elsif not @location.public_url_active
      redirect_to oops_url(:err_code => 1)
      return
    end

    @locsettings = @location.location_public_setting

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
      @location.user_has_set_url
      if params[:redirect_to_admin]
        redirect_back_or_default('/')
        return
      else
        redirect_to locations_edit_url(:id => @location.id, :settings => true, :update_settings_url_success => true)
        return
      end
    else
      @product = Product.new
      @productimage = ProductImage.new
      @featureditem = FeaturedItem.new
      params[:settings] = true
      render :template => 'locations/edit'
    end

  end

  def public_url_deactivate

    @location = Location.find(params[:id])
    @location.public_url_active = false
    if @location.save
      redirect_to locations_edit_url(:id => @location.id, :settings => true, :update_settings_url_success => true)
      return
    else
      redirect_to oops_url
    end

  end

  def public_url_activate

    @location = Location.find(params[:id])
    @location.public_url_active = true
    if @location.save
      redirect_to locations_edit_url(:id => @location.id, :settings => true, :update_settings_url_success => true)
      return
    else
      redirect_to oops_url
    end

  end

  def update_public_settings

    @location = Location.find(params[:id])
    @publicsettings = LocationPublicSetting.where(:location_id => @location.id).first_or_create

    if @publicsettings.update_attributes(params[:location_public_setting])
      redirect_to locations_edit_url(:id => @location.id, :settings => true, :update_settings_success => true)
    else
      # DO SOME ERROR
      redirect_to oops_url
    end


  end

  def inventory_upload

    @location = Location.find(params[:location][:id])

    @inventory = @location.inventories.new(:location_id => @location.id, :file => params[:location][:file], :num_views => 0)

    if @inventory.save

      news_feed_uploaded_inventory(@location.id, @inventory.id)

      Inventory.where(:location_id => @location).each do |inv|
        unless inv.id == @inventory.id
          inv.current = false;
          inv.save;
        end
      end
      redirect_to locations_edit_url(:id => @location.id, :addons => true, :add_new_inventory_success => true)
    else
      redirect_to locations_edit_url(:id => @location.id, :addons => true, :add_new_inventory_failed => true)      
    end

  end

  def inventory_view

    @location = Location.find(params[:id])
    @invs = Inventory.where(:active => true, :location_id => params[:id])

    if params[:inv_id].blank? or @invs.where(:id => params[:inv_id]).count == 0
      redirect_to oops_url #todo - err_code for no inventory
    else
      @inventory = @invs.where(:id => params[:inv_id]).first
    end

    if current_user
      unless @location.is_owner(current_user)
        @inventory.num_views = @inventory.num_views + 1
        if @inventory.save
          redirect_to @inventory.file.url
        else
          redirect_to oops_url #todo - err_code for something?
        end
      else
        redirect_to @inventory.file.url
      end
    else
      redirect_to @inventory.file.url
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
    @location.user_detail_id = current_user.user_detail.id
    @location.busName = current_user.user_detail.company_name
    @location.format_all_urls

    if not current_user.verified
      @location.active = false
    else
      @location.active = true
    end

    if @location.save
      flash[:notice] = "New Location Added!"

      news_feed_new_location(@location.id)

      update_weight_rank(@location)

      if is_production_site
        Mailers.new_location_activation_email(current_user, @location).deliver
      end

      if current_user.user_detail.locations.count == 1
        redirect_to locations_manage_url
      else
        redirect_to locations_manage_url
      end

    else
      @user = current_user
      @view = 'new_location'
      render :action => :new
    end
  end

  def manage

    if current_user.user_detail.locations.count == 0
      redirect_to locations_new_url
    elsif current_user.user_detail.locations.count == 1
      redirect_to locations_view_url(:id => current_user.user_detail.locations.first.id)
    else
      @vlocations = current_user.user_detail.locations
    end

    store_location
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
          add_category_to_location(Category.where(:cat_name => c).first, @location)
        end
      else
        add_category_to_location(Category.where(:cat_name => params[:categories].first).first, @location)
      end

    end

    # So this does not catch an error because it is using that helper method to do it.
    redirect_to locations_edit_url(:id => params[:id], :update_categories_success => true)

  end

  def update_bio
    @location = Location.find(params[:id])
    @location.bio = params[:bio]
    if @location.save
      update_weight_rank(@location)
      redirect_to locations_edit_url(:id => params[:id], :update_about_success => true)
      return
    else
      redirect_to oops_url(:err_code => 7) #7 is data did not save.
    end
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
      redirect_to products_edit_url(:id => @featureditem.id, :update_featured_item_success => true)
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
      update_weight_rank(@location)
      @location.format_all_urls
      @location.save
      flash[:notice] = "Account updated!"
      redirect_to locations_edit_url(:id => params[:id], :update_location_info_success => true)
    else
      #@location = @location.reset_fields_keep_errors(params[:id])
      @publicsettings = LocationPublicSetting.where(:location_id => @location.id).first_or_create
      render :action => :edit
     
    end
  end

  def view

    store_location

    if Location.where(:id => params[:id]).count > 0
      @location = Location.find(params[:id])
    else
      if current_user.is_supplier
        if Location.where(:id => params[:id]).count > 0
          @location = Location.find(params[:id])
          if @location.user_detail_id == current_user.user_detail.id
            redirect_to locations_manage_url
          end
        else
          redirect_to locations_manage_url
        end
      elsif current_user.is_buyer
        redirect_to main_url
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

  def destroy
    
    @location = Location.find(params[:id])

  end

  def confirm_destroy

      Location.find(params[:id]).deactivate

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

    redirect_to locations_edit_url(:id => @locid, :products => true)

  end

  

end
