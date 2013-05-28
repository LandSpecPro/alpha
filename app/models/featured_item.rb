class FeaturedItem < ActiveRecord::Base
	include ModelHelper
	
	attr_accessible :description, :product_id, :location_id, :product_image_id, :size, :price
	belongs_to :product
	belongs_to :location

	geocoded_by :get_full_address
	after_validation :geocode

	has_one :product
	accepts_nested_attributes_for :product

	def get_image
		return ProductImage.find(self.product_image_id).image
	end

	def get_product
		return Product.find(self.product_id)
	end

	def get_category_ids
		@categoryids = []
		@categories = ProductHasCategory.where(:featured_item_id => self.id, :active => true) 

		if not @categories.nil?

			if @categories.count > 1
				@categories.each do |c|
					@categoryids << c.category_id.to_s
				end
			elsif @categories.count == 1
				@categoryids << @categories.first.category_id.to_s
			end
			
		end

		return @categoryids
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

		if FavProduct.where(:user_id => user.id, :featured_item_id => self.id, :active => true).count > 0
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
