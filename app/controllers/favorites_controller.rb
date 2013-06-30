class FavoritesController < ApplicationController
  
  before_filter :require_user
  
  def products
  	store_location

    if params[:view].blank?
      params[:view] = 'grid'
    end

  	@user = current_user
  	@favproducts = FavProduct.where(:user_id => @user.id, :active => true)
  end

  def vendors
  	store_location

  	@user = current_user
  	@favlocations = FavLocation.where(:user_id => @user.id, :active => true)
  end

end
