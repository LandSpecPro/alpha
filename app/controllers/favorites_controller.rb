class FavoritesController < ApplicationController
  
  def products
  	@user = current_user
  	@favproducts = FavProduct.where(:user_id => @user.id)
  end

  def vendors
  	@user = current_user
  	@favlocations = FavLocation.where(:user_id => @user.id)
  end

end
