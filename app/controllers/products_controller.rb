class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @description = params[:product][:description]
    params[:product].delete :featured_items

    @location = Location.find(params[:id])
    @product = @location.products.build(params[:product])
    if @product.save
      @featureditem = FeaturedItem.new(:description => @description, :location_id => params[:id], :product_id => @product.id)
      @featureditem.save
      flash[:notice] = "Product Added!"
      redirect_to home_url

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
