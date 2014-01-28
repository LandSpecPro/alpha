class Location < ActiveRecord::Base
	include ModelHelper
	include AnalyticsHelper

	geocoded_by :get_full_address
	after_validation :geocode
	after_initialize :initialize_public_url
	after_save :update_cache

	attr_accessible :locName, :public_url, :is_subscribed_to_inventory, :public_url_active, \
	:searchWeight, :busName, :bio, :primaryPhone, :secondaryPhone, :fax, :address1, :address2, \
	:city, :state, :zip, :primaryEmail, :secondaryEmail, :websiteLink, :facebookLink, :twitterLink, \
	:googleLink, :featured_items_attributes, :categories_attributes, :inventories_attributes, \
	:location_public_settings_attributes, :statuses_attributes, :id, :active, :verified, :claimed, \
	:url_is_custom, :user_detail_id
	
	has_many :featured_items
	has_many :products, :through => :featured_items
	accepts_nested_attributes_for :featured_items

	has_many :inventories
	accepts_nested_attributes_for :inventories

	has_many :statuses
	accepts_nested_attributes_for :statuses

	has_one :location_public_setting
	accepts_nested_attributes_for :location_public_setting

	has_many :category_to_locations
	has_many :categories, :through => :category_to_locations
	accepts_nested_attributes_for :categories

	validates :locName, :uniqueness => { :scope => :user_detail_id, :message => "You have already added a location with this name!"}, :if => :not_unclaimed_location?
	validates :public_url, :uniqueness => {:scope => :active, :message => "This URL is already in use!"}, :allow_nil => true

	validates_presence_of :address1, :message => "Must provide a valid address!"
	validates_presence_of :city, :message => "Must provide a valid city!"
	validates_presence_of :state, :message => "Must provide a valid state!"
	validates_presence_of :zip, :message => "Must provide a valid zip code!"
	validates_presence_of :primaryPhone, :message => "Must provide a valid phone number!"

	validates_format_of :primaryEmail, :with => /(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z)|^$/i, :message => "Primary Email address is not valid."
	validates_format_of :secondaryEmail, :with => /(\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z)|^$/i, :message => "Secondary Email address is not valid."
	validates_format_of :public_url, :with => /\A([a-zA-Z0-9_]){3,25}\z/, :message => "URL can only contain numbers, letters, and underscores. Must be between 3 and 25 characters long."

	validates_exclusion_of :public_url, :in => ['search', 'follower', 'user_detail', 'user', 'users', 'inventory', 'view', \
		'show', 'invite', 'account', 'create', 'email', 'verify', 'landscapers', 'buyers', 'suppliers', 'supplier', 'buyer', \
		'seller', 'plants', 'materials', 'plant', 'material', 'claim', 'success', 'forgot', 'password', 'feedback', 'product', \
		'products', 'favorites', 'set', 'submit_forgot', 'profile', 'profiles', 'location', 'locations', 'loc', 'locs', 'home', \
		'index', 'about', 'contact', 'contact_us', 'feedback', 'subscribe', 'register', 'main', 'login', 'logout', 'dashboard' \
		'account', 'back', 'terms', 'oops', 'help', 'admin', 'admins', 'registration', 'signup', 'more', 'info', 'about_us', 'links' \
		'ask', 'faq', 'donate', 'buy', 'purchase', 'question', 'questions', 'session', 'sessions', 'user_session', 'user_sessions', 'user_details'], \
		:message => "This URL is reserved."

	before_validation :strip_whitespace

	def strip_whitespace
		self.busName = self.busName.strip
		self.locName = self.locName.strip
	end
   
   	def not_unclaimed_location?
   		if user_detail_id > 0
   			return true
   		else
   			return false
   		end
   	end
   	
	def update_cache
		Rails.cache.write('active_locations', Location.where(:active => true))
	end

	def self.update_cache
		Rails.cache.write('active_locations', Location.where(:active => true))
	end

	def self.filter_by_categories(array_cat_strings)

		# get all category ids from strings
		@catids = []
		array_cat_strings.each do |cat_name|
			@catids << Category.where(:cat_name => cat_name).first.id
		end

		@locids = []
		@catids.each do |cat_id|
			CategoryToLocation.where(:category_id => cat_id).each do |catloc|
				@locids << catloc.location_id
			end
		end
		return self.where('id IN(?)', @locids.uniq)

	end

	def self.sort_by_criteria(criteria)
		# dist_asc, dist_desc, name_asc, name_desc
		if criteria.to_s == 'dist_asc'
			return self.order("claimed DESC, distance")
		elsif criteria.to_s == 'dist_desc'
			return self.order('claimed DESC, distance DESC')
		elsif criteria.to_s == 'name_asc'
			return self.order('claimed DESC, "busName" ASC')
		elsif criteria.to_s == 'name_desc'
			return self.order('claimed DESC, "busName" DESC')
		else
			return self.order('claimed DESC, distance ASC')
		end
	end

	def initialize_public_url
		if self.public_url.blank?
			self.public_url = eight_digit_random_number
		end
	end

	def set_public_url
		self.public_url = eight_digit_random_number
		self.save
	end

	def user_has_set_url
		self.url_is_custom = true
		self.save
	end
	
	def format_all_urls

		self.websiteLink = format_url(self.websiteLink)
		self.facebookLink = format_url(self.facebookLink)
	    self.twitterLink = format_url(self.twitterLink)
	    self.googleLink = format_url(self.googleLink)

	end

	def reset_fields_keep_errors(lid)

		@resetloc = Location.find(lid)

		self.errors.each do |field, msg|
			@resetloc.errors.add(field, msg)
		end

		return @resetloc

	end

	def format_url(urladdress)
		unless urladdress[/^http:\/\//] || urladdress[/^https:\/\//] || urladdress.blank?
	        urladdress = 'http://' + urladdress
	    end

	    return urladdress
	end

	def get_full_address
		@address1 = self.address1 + " "
		if not self.address2.blank?
			@address2 = self.address2 + " "
		else
			@address2 = " "
		end
		@city = self.city + ", "
		@state = self.state + " "
		@zip = self.zip

		return @address1 + @address2 + @city + @state + @zip
	end

	def get_featured_items

		return FeaturedItem.where(:location_id => self.id, :active => true)

	end

	def get_current_status_string(locid)

		currentstatus = Status.where(:active => true, :location_id => locid).first

	    unless currentstatus.blank?
	      currentstatusstring = currentstatus.status
	    else
	      currentstatusstring = ''
	    end

	    return currentstatusstring

	end

	def get_current_status(locid)

		return Status.where(:active => true, :location_id => locid).first

	end

	def is_owner(user)

		unless user.is_supplier
			return false
		end

		if user.user_detail.id == self.user_detail_id
			return true
		else
			return false
		end
		
	end

	def tagline

		if not self.user_detail_id == 0
			return UserDetail.find(self.user_detail_id).tagline
		else
			return nil
		end

	end

end
