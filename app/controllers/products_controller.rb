class ProductsController < ApplicationController
  
  # add in before filter to make sure user id matches for setting and removing favorites
  include ProductHelper

  before_filter :require_id_parameter, :only => [:view, :edit]
  before_filter :require_user, :only => [:edit, :new, :create, :set_as_favorite]
  before_filter :require_user_is_vendor, :only => [:edit, :new, :create]

  def new
    @product = Product.new
    @productimage = ProductImage.new
  end

  def create

    @location = Location.find(params[:product][:location_id])
    @featureditem = FeaturedItem.new
    @product = Product.new

    if validation_failed
      return
    end
    
    @locationid = @location.id
    @description = params[:product][:featured_item][:description]
    @image = params[:product][:image]
    @size = params[:product][:featured_item][:size]
    @price = params[:product][:featured_item][:price]

    @thing = params[:product][:productSelect]

    before_create
    
    @product = find_product(@location)

    if @product.save
      if save_product_relations(@product.id, @image, @description, @locationid, @size, @price)
        flash[:notice] = "Product Added!"
        redirect_to locations_edit_url(:id => @locationid, :products => true)
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

  end

  def view

    @featureditem = FeaturedItem.find(params[:id])
    @image = @featureditem.get_image
    @product = @featureditem.get_product

    if not @featureditem.active
      redirect_back_or_default('/')
    elsif not @featureditem.is_visible
      unless Location.find(@featureditem.location_id).bus_vendor_id == current_user.bus_vendor_id
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
    elsif not Location.where(:id => @featureditem.location_id, :bus_vendor_id => current_user.bus_vendor_id).count > 0
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
        return true
      else
        @productimage.destroy
        return false
      end
    else
      return false
    end
  end

  def search
    store_location

    @resultnum = 0

    if params[:distance_from].blank?
      params[:distance_from] = '0'
    end

    if params[:view].blank?
      params[:view] = 'grid'
    end

    if params[:search] == "All Products"
      params[:search] = ''
    end

    @setlocation = nil
    if params[:use_current_location]
      @setlocation = request.location.city + ", " + request.location.state
    else
      @setlocation = params[:custom_location]
    end

    @featureditems = nil
    if params[:commit] == 'Search'
      update_search_log
      if params[:distance_from] != '0' and params[:search] != ''
        @featureditems = search_for_featured_items_with_query_and_distance(@setlocation, params[:search], params[:distance_from])
      elsif params[:distance_from] != '0' and params[:search] == ''
        @featureditems = search_for_featured_items_with_distance_only(@setlocation, params[:distance_from])
      elsif params[:distance_from] == '0' and params[:search] != ''
        @featureditems = search_for_featured_items_with_query_only(params[:search])
      elsif params[:distance_from] == '0' and params[:search] == ''
        @featureditems = search_for_all
      end
    end

  end

  def set_as_favorite
    @featureditem = FeaturedItem.find(params[:id])

    if @featureditem.is_favorited(current_user)
      FavProduct.where(:user_id => current_user.id, :featured_item_id => params[:id]).first.deactivate
      redirect_back_or_default('/')
    else
      @featureditem.set_favorite(current_user.id, @featureditem.id, @featureditem.get_product.id)
      redirect_back_or_default('/')
    end
  end


  def browseall
  end

end
