class FeaturedItem < ActiveRecord::Base
	include ModelHelper
	
	attr_accessible :description, :product_id, :location_id, :product_image_id, :size, :price
	belongs_to :product
	belongs_to :location

	geocoded_by :get_full_address
	after_validation :geocode

	has_one :product
	accepts_nested_attributes_for :product

	validates :price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }

	def is_visible
		loc = Location.find(self.location_id)
		if loc.active
			return true
		else
			return false
		end
	end

	def get_image
		return ProductImage.find(self.product_image_id).image
	end

	def get_product
		return Product.find(self.product_id)
	end

	def get_location
		return Location.find(self.location_id)
	end

	def get_full_address
		@location = Location.find(self.location_id)
		@address1 = @location.address1 + " "
		@address2 = @location.address2 + " "
		@city = @location.city + ", "
		@state = @location.state + " "
		@zip = @location.zip

		return @address1 + @address2 + @city + @state + @zip
	end

	def is_favorited(user)

		if FavProduct.where(:user_id => user.id, :featured_item_id => self.id).count > 0
			return true
		else
			return false
		end
	end

	def set_favorite(userid, fid, product_id)
		
		if FavProduct.where(:user_id => userid, :featured_item_id => self.id).count > 0
			FavProduct.where(:user_id => userid, :featured_item_id => self.id).first.activate
		else
			@favprod = FavProduct.create(:user_id => userid, :featured_item_id => self.id, :product_id => product_id)
			if @favprod.save
				return true
			else
				return false
			end
		end

	end

	def remove_favorite(userid, fid)

		if fid == self.id
			FavProduct.destroy(FavProduct.where(:user_id => userid, :featured_item_id => self.id).first.id)
			return
		else
			return false
		end
	end
end
