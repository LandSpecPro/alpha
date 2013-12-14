class FeaturedItem < ActiveRecord::Base
	include ModelHelper
	
	after_save :update_cache

	attr_accessible :description, :product_id, :location_id, :product_image_id, :size, :price
	belongs_to :product
	belongs_to :location

	geocoded_by :get_full_address
	after_validation :geocode
	before_save :initialize_common_name, :initialize_bus_name, :zero_out_price
	

	has_one :product
	accepts_nested_attributes_for :product

	validates :price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }

	
	def update_cache
		Rails.cache.write('active_featured_items', FeaturedItem.where(:active => true))
	end

	def self.update_cache
		Rails.cache.write('active_featured_items', FeaturedItem.where(:active => true))
	end
	
	def zero_out_price
		if self.price.to_d < 0.01
			self.price = nil
		end
	end

	def initialize_common_name
		self.commonName = Product.find(self.product_id).commonName
	end

	def initialize_bus_name
		self.busName = Location.find(self.location_id).busName
	end
	
	def set_common_name
		self.commonName = Product.find(self.product_id).commonName
		self.save
	end

	def set_bus_name
		self.busName = Location.find(self.location_id).busName
		self.save
	end

	def self.only_visible
		@ids = []

		self.all.each do |e|
			if e.is_visible
				@ids << e
			end
		end

		self.scoped(:conditions => { :id => @ids })
	end

	def self.sort_by_criteria(criteria)
		# dist_asc, dist_desc, name_asc, name_desc
		if criteria.to_s == 'dist_asc'
			return self.order('distance ASC')
		elsif criteria.to_s == 'dist_desc'
			return self.order('distance DESC')
		elsif criteria.to_s == 'name_asc'
			return self.order('"commonName" ASC')
		elsif criteria.to_s == 'name_desc'
			return self.order('"commonName" DESC')
		elsif criteria.to_s == 'busname_asc'
			return self.order('"busName" ASC')
		elsif criteria.to_s == 'busname_desc'
			return self.order('"busName" DESC')
		elsif criteria.to_s == 'price_asc'
			return self.order('price ASC')
		elsif criteria.to_s == 'price_desc'
			return self.order('price DESC')
		elsif criteria.to_s == 'size_asc'
			return self.order('size ASC')
		elsif criteria.to_s == 'size_desc'
			return self.order('size DESC')
		else
			return self.order('distance ASC')
		end
	end

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

	def get_user_owner
		@loc = self.get_location
		@vendor = @loc.bus_vendor
		return @vendor.user
	end

	def get_full_address
		@location = Location.find(self.location_id)
		@address1 = @location.address1 + " "
		if not @location.address2.blank?
			@address2 = @location.address2 + " "
		else
			@address2 = ''
		end
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
