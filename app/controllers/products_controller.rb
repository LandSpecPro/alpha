class ProductsController < ApplicationController
  
  include ProductHelper
  include AnalyticsHelper
  include NewsFeedHelper
  include LocationHelper

  before_filter :require_user, :only => [:edit, :new, :create]
  before_filter :require_user_email_validated, :only => [:edit, :new, :create]
  before_filter :require_user_details, :only => [:edit, :new, :create]

  before_filter :require_id_parameter, :only => [:view, :edit]
  before_filter :require_user_is_supplier, :only => [:edit, :new, :create]

  before_filter :require_buyer_has_first_and_last_name

  def new
    @product = Product.new
    @productimage = ProductImage.new
  end

  def create

    @location = Location.find(params[:product][:location_id])
    @featureditem = FeaturedItem.new
    @product = Product.new
    @publicsettings = LocationPublicSetting.where(:location_id => @location.id).first_or_create
    
    if validation_failed
      return
    end
    
    @locationid = @location.id
    @description = params[:product][:featured_item][:description]
    @image = params[:product][:image]
    @prodname = params[:product][:commonName]
    @size = params[:product][:featured_item][:size]
    @price = params[:product][:featured_item][:price]

    before_create
    
    @product = find_product(@location)

    if @location.featured_items.where(:active => true).count < 3
      if @product.save
        if save_product_relations(@product.id, @image, @description, @locationid, @size, @price)
          flash[:notice] = "Product Added!"
          redirect_to locations_edit_url(:id => @locationid, :products => true, :add_featured_item_success => true)
          return
        else
          flash[:notice] = "Not successful!"
          params[:products] = true
          render :template => 'locations/edit'
        end
      else
        flash[:notice] = "Not successful!"
        params[:products] = true
        render :template => 'locations/edit'
      end
    else
      redirect_to oops_url(:err_code => 3, :origin_url => locations_edit_url(:id => @locationid, :products => true))
    end

  end

  def view

    @featureditem = FeaturedItem.find(params[:id])
    @image = @featureditem.get_image
    @product = @featureditem.get_product

    if not @featureditem.active
      redirect_back_or_default('/')
    elsif not @featureditem.is_visible
      unless Location.find(@featureditem.location_id).user_detail_id == current_user.user_detail.id
        redirect_back_or_default('/')
      end
    end

    store_location
    
  end

  def edit

    @featureditem = FeaturedItem.find(params[:id])
    @image = @featureditem.get_image
    @product = @featureditem.get_product

    if not @featureditem.active
      redirect_back_or_default('/')
    elsif not Location.where(:id => @featureditem.location_id, :user_detail_id => current_user.user_detail.id).count > 0
      redirect_back_or_default('/')
    end

    store_location

  end

  def find_product(location)

    @commonName = params[:product][:commonName]

    if Product.where(:commonName => @commonName, :active => true).count > 0
      return Product.where(:commonName => @commonName, :active => true).first
    else
      return location.products.build(params[:product])
    end
  end

  def validation_failed
    # Cannot add new item if there is no image
    unless params[:product][:image]
      @img_missing = true
    else
      @img_missing = false
    end

    # Cannot add new product if there is no commonName
    if params[:product][:commonName] == ""
      @name_missing = true
    end

    # Invalid price format
    params[:product][:featured_item][:price][0] = ''
    unless /^\d+??(?:\.\d{0,2})?$/.match(params[:product][:featured_item][:price].to_s)
      @price_invalid = true
    end
    # Redirect if name or image is missing
    if @img_missing or @name_missing or @price_invalid
      params[:products] = true
      @commonName = params[:product][:commonName]
      @price = params[:product][:featured_item][:price]
      @size = params[:product][:featured_item][:size]
      @description = params[:product][:featured_item][:description]
      @productimage = ProductImage.new
      render 'locations/edit'
      return true
    end
  end

  def before_create
    params[:product].delete :featured_item
    params[:product].delete :image
    params[:product].delete :location_id
  end

  def save_product_relations(product_id, image, description, location_id, size, price)
    @productimage = ProductImage.new(:product_id => product_id, :image => image)
    if @productimage.save
      @featureditem = FeaturedItem.new(:description => description, :location_id => location_id, :product_id => product_id, :product_image_id => @productimage.id, :size => size, :price => price)
      if @featureditem.save

        # Add news feed item
        news_feed_new_featured_item(location_id, @featureditem.id)

        return true
      else
        @productimage.destroy
        return false
      end
    else
      return false
    end
  end

end
