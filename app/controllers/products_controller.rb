class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @location = Location.find(params[:product][:location_id])
    @locationid = @location.id
    @description = params[:product][:featured_items][:description]
    @image = params[:product][:product_images][:image] 

    before_create
    
    @product = @location.products.build(params[:product])

    if @product.save
      save_product_relations(@product, @image, @description)
      flash[:notice] = "Product Added!"
      redirect_back_or_default('/')
    else
      flash[:notice] = "Not successful!"
      render :action => :new
    end
  end

  def before_create
    params[:product].delete :featured_items
    params[:product].delete :product_images
    params[:product].delete :location_id
  end

  def save_product_relations(product, image, description)
    @productimage = ProductImage.new(:product_id => product.id, :image => image)
    @productimage.save
    @featureditem = FeaturedItem.new(:description => description, :location_id => params[:id], :product_id => product.id, :product_image_id => @productimage.id)
    @featureditem.save
  end

  def edit
  end

  def show
    @sidebar_search_active = true
    @sidebar_search_products_active = true
    search = Sunspot.search(Product) do |q|
      q.fulltext params[:search]
    end

    @products = search.results
  end

  def update
  end

  def search
    @sidebar_search_active = true
    @sidebar_search_products_active = true
  end

  def browseall
    @sidebar_search_active = true
    @sidebar_search_products_active = true
  end

  def favorite
  end

end
