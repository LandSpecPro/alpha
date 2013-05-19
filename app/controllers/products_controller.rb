class ProductsController < ApplicationController

  def new
    @product = Product.new
  end

  def create

    if validation_failed
      return
    end

    @location = Location.find(params[:product][:location_id])
    @locationid = @location.id
    @description = params[:product][:featured_items][:description]
    @image = params[:product][:image]
    @size = params[:product][:featured_items][:size]
    @price = params[:product][:featured_items][:price]

    @thing = params[:product][:productSelect]

    before_create
    
    @product = find_product(@location)

    if @product.save
      if save_product_relations(@product.id, @image, @description, @locationid, @size, @price)
        flash[:notice] = "Product Added!"
        redirect_to locations_edit_url(:id => @locationid)
        return
      else
        flash[:notice] = "Not successful!"
        render :template => 'locations/edit'
      end
    else
      flash[:notice] = "Not successful!"
      render :template => 'locations/edit'
    end

  end

  def find_product(location)

    @commonName = params[:product][:commonName]

    if Product.where(:commonName => @commonName).count > 0
      return Product.where(:commonName => @commonName).first
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

    # Redirect if name or image is missing
    if @img_missing or @name_missing
      redirect_to locations_edit_url(:id => params[:product][:location_id], :image_missing => @img_missing, :product_name_missing => @name_missing)
      return true
    end
  end

  def before_create
    params[:product].delete :featured_items
    params[:product].delete :image
    params[:product].delete :location_id
  end

  def save_product_relations(product_id, image, description, location_id, size, price)
    @productimage = ProductImage.new(:product_id => product_id, :image => image)
    if @productimage.save
      @featureditem = FeaturedItem.new(:description => description, :location_id => location_id, :product_id => product_id, :product_image_id => @productimage.id, :size => size, :price => price)
      @featureditem.save
      return true
    else
      return false
    end
  end

  def edit
  end

  def show
  end

  def update
  end

  def search
    @sidebar_search_active = true
    @sidebar_search_products_active = true

    @products = Product.search_all_products(params[:search])
  end

  def browseall
    @sidebar_search_active = true
    @sidebar_search_products_active = true
  end

  def favorite
  end

end
