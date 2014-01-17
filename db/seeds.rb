# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.create(
#	id: 999,
#	login: 'guest_supplier',
#	email: 'tech@landspecpro.com',
#	userType: 'Supplier',
#	password: 'landspecpro',
#	active: true,
#	verified: true,
#	is_email_verified: true
#)

#UserDetail.create(
#	id: 999,
#	user_id: 999,
#	first_name: 'John',
#	last_name: 'Doe',
#	company_name: 'My Company Name',
#	phone_number: '(404) 919-5778',
#	user_type: 'Supplier',
#	user_category: 'Wholesale Grower',
#	city: 'Atlanta',
#	state: 'GA',
#	zip: '30309'
#)

#Location.create(
#	id: 999,
#	primaryPhone: '(404) 919-5778',
#	address1: '828 West Peachtree St. NW',
#	city: 'Atlanta',
#	state: 'GA',
#	zip: '30308',
#	primaryEmail: 'tech@landspecpro.com',
#	websiteLink: 'http://www.landspecpro.com',
#	facebookLink: 'http://www.facebook.com/landspecpro',
#	twitterLink: 'http://www.twitter.com/landspecpro',
#	active: false,
#	verified: true,
#	public_url: 'guest_supplier',
#	public_url_active: true,
#	url_is_custom: true,
#	busName: 'My Company Name',
#	user_detail_id: 999,
#	claimed: true,
#	bio: 'This is a guest account that you can use to preview LandSpec Pro. This is normally where your company bio/about information would go. We have disabled all updating of this account because it is shared by multiple users, but feel free to play around and explore the site. When you are ready to register just click the logout link from the dropdown menu at the top of the page and you should find the register button on the home page. We hope you enjoy LandSpec Pro and hope for you to become a real member soon.'
#)

Location.create(
	id: 1500,
	primaryPhone: '(100) 100-1000',
	address1: '100 North Avenue NW',
	city: 'Atlanta',
	state: 'GA',
	zip: '30308',
	primaryEmail: 'something@something.com',
	active: true,
	verified: true,
	claimed: false,
	public_url_active: true,
	public_url: 'guest_tester',
	busName: 'Something',
	user_detail_id: 0
)

#Category.create([

	#TOP LEVEL
#	{ id: 1, cat_name: 'Plants'},
#	{ id: 2, cat_name: 'Materials'},
#	{ id: 3, cat_name: 'Supplier Types'},

	#PLANTS
#	{ id: 100, parent_id: 1, hierarchy_level: 2, cat_name: 'Annuals Cool Season'},
#	{ id: 101, parent_id: 1, hierarchy_level: 2, cat_name: 'Annuals Warm Season'},
#	{ id: 102, parent_id: 1, hierarchy_level: 2, cat_name: 'Hardy Ferns'},
#	{ id: 103, parent_id: 1, hierarchy_level: 2, cat_name: 'Perennials Shade'},
#	{ id: 104, parent_id: 1, hierarchy_level: 2, cat_name: 'Perennials Sun'},
#	{ id: 105, parent_id: 1, hierarchy_level: 2, cat_name: 'Herbs'},
#	{ id: 106, parent_id: 1, hierarchy_level: 2, cat_name: 'Interior and Tropicals'},
#	{ id: 107, parent_id: 1, hierarchy_level: 2, cat_name: 'Ornamental and Landscape Grasses'},
#	{ id: 108, parent_id: 1, hierarchy_level: 2, cat_name: 'Palms'},
#	{ id: 109, parent_id: 1, hierarchy_level: 2, cat_name: 'Roses'},
#	{ id: 110, parent_id: 1, hierarchy_level: 2, cat_name: 'Shrubs Deciduous'},
#	{ id: 111, parent_id: 1, hierarchy_level: 2, cat_name: 'Shrubs Evergreen'},
#	{ id: 112, parent_id: 1, hierarchy_level: 2, cat_name: 'Sod'},
#	{ id: 113, parent_id: 1, hierarchy_level: 2, cat_name: 'Trees Deciduous'},
#	{ id: 114, parent_id: 1, hierarchy_level: 2, cat_name: 'Trees Evergreen'},
#	{ id: 115, parent_id: 1, hierarchy_level: 2, cat_name: 'Vines'},
#	{ id: 116, parent_id: 1, hierarchy_level: 2, cat_name: 'Natives'},
#	{ id: 117, parent_id: 1, hierarchy_level: 2, cat_name: 'Wetland Plans'},
#	{ id: 118, parent_id: 1, hierarchy_level: 2, cat_name: 'Vegetables'},
#	{ id: 119, parent_id: 1, hierarchy_level: 2, cat_name: 'Bulbs'},
#	{ id: 120, parent_id: 1, hierarchy_level: 2, cat_name: 'Cacti & Succulents'},
#	{ id: 121, parent_id: 1, hierarchy_level: 2, cat_name: 'Balled and Burlapped'},
#	{ id: 122, parent_id: 1, hierarchy_level: 2, cat_name: 'Plant Liners'},
#	{ id: 123, parent_id: 1, hierarchy_level: 2, cat_name: 'Container Stock'},
#   { id: 124, parent_id: 1, hierarchy_level: 2, cat_name: 'Groundcovers'},

#	{ id: 125, parent_id: 1, hierarchy_level: 2, cat_name: 'Fruit Trees'},
#	{ id: 126, parent_id: 1, hierarchy_level: 2, cat_name: 'Fruit Shrubs'},
#	{ id: 127, parent_id: 1, hierarchy_level: 2, cat_name: 'Camellias'},
#	{ id: 128, parent_id: 1, hierarchy_level: 2, cat_name: 'Japanese Maples'},
#	{ id: 129, parent_id: 1, hierarchy_level: 2, cat_name: 'Bamboo'},


	#MATERIALS
#	{ id: 200, parent_id: 2, hierarchy_level: 2, cat_name: 'Block'},
#	{ id: 201, parent_id: 2, hierarchy_level: 2, cat_name: 'Brick'},
#	{ id: 202, parent_id: 2, hierarchy_level: 2, cat_name: 'Cast Stone'},
#	{ id: 203, parent_id: 2, hierarchy_level: 2, cat_name: 'Landscape Tembers'},
#	{ id: 204, parent_id: 2, hierarchy_level: 2, cat_name: 'Masonry Supplies'},
#	{ id: 205, parent_id: 2, hierarchy_level: 2, cat_name: 'Fertilizer'},
#	{ id: 206, parent_id: 2, hierarchy_level: 2, cat_name: 'Fungicides'},
#	{ id: 207, parent_id: 2, hierarchy_level: 2, cat_name: 'Herbicides'},
#	{ id: 208, parent_id: 2, hierarchy_level: 2, cat_name: 'Drainage Supplies'},
#	{ id: 209, parent_id: 2, hierarchy_level: 2, cat_name: 'Eletrical Supplies'},
#	{ id: 210, parent_id: 2, hierarchy_level: 2, cat_name: 'Erosion Control Supplies'},
#	{ id: 211, parent_id: 2, hierarchy_level: 2, cat_name: 'Bird Baths'},
#	{ id: 212, parent_id: 2, hierarchy_level: 2, cat_name: 'Finials'},
#	{ id: 213, parent_id: 2, hierarchy_level: 2, cat_name: 'Fountain Pieces'},
#	{ id: 214, parent_id: 2, hierarchy_level: 2, cat_name: 'Garden Benches'},
#	{ id: 215, parent_id: 2, hierarchy_level: 2, cat_name: 'Garden Statuary'},
#	{ id: 216, parent_id: 2, hierarchy_level: 2, cat_name: 'Gargoyles'},
#	{ id: 217, parent_id: 2, hierarchy_level: 2, cat_name: 'Statuary'},
#	{ id: 218, parent_id: 2, hierarchy_level: 2, cat_name: 'Overdoor Plaques'},
#	{ id: 219, parent_id: 2, hierarchy_level: 2, cat_name: 'Pedestals'},
#	{ id: 220, parent_id: 2, hierarchy_level: 2, cat_name: 'Planters'},
#	{ id: 221, parent_id: 2, hierarchy_level: 2, cat_name: 'Stepping Stones'},
#	{ id: 222, parent_id: 2, hierarchy_level: 2, cat_name: 'Urns'},
#	{ id: 223, parent_id: 2, hierarchy_level: 2, cat_name: 'Wall Plaques'},
#	{ id: 224, parent_id: 2, hierarchy_level: 2, cat_name: 'Irrigation Supplies'},
#	{ id: 225, parent_id: 2, hierarchy_level: 2, cat_name: 'Lighting'},
#	{ id: 226, parent_id: 2, hierarchy_level: 2, cat_name: 'Mulch'},
#	{ id: 227, parent_id: 2, hierarchy_level: 2, cat_name: 'Pinestraw'},
#	{ id: 228, parent_id: 2, hierarchy_level: 2, cat_name: 'Turfgrass Seed'},
#	{ id: 229, parent_id: 2, hierarchy_level: 2, cat_name: 'Soils'},
#	{ id: 230, parent_id: 2, hierarchy_level: 2, cat_name: 'Boulders'},
#	{ id: 231, parent_id: 2, hierarchy_level: 2, cat_name: 'Cobblestones'},
#	{ id: 232, parent_id: 2, hierarchy_level: 2, cat_name: 'Curbing'},
#	{ id: 233, parent_id: 2, hierarchy_level: 2, cat_name: 'Cut Pattern Stone'},
#	{ id: 234, parent_id: 2, hierarchy_level: 2, cat_name: 'Drystack Stone'},
#	{ id: 235, parent_id: 2, hierarchy_level: 2, cat_name: 'Flagstone'},
#	{ id: 236, parent_id: 2, hierarchy_level: 2, cat_name: 'Stone Flooring'},
#	{ id: 237, parent_id: 2, hierarchy_level: 2, cat_name: 'Granite Rubble'},
#	{ id: 238, parent_id: 2, hierarchy_level: 2, cat_name: 'Gravel'},
#	{ id: 239, parent_id: 2, hierarchy_level: 2, cat_name: 'Imported Stone'},
#	{ id: 240, parent_id: 2, hierarchy_level: 2, cat_name: 'Man Made Stone'},
#	{ id: 241, parent_id: 2, hierarchy_level: 2, cat_name: 'Pavers'},
#	{ id: 242, parent_id: 2, hierarchy_level: 2, cat_name: 'River Rock'},
#	{ id: 243, parent_id: 2, hierarchy_level: 2, cat_name: 'Squared Stone'},
#	{ id: 245, parent_id: 2, hierarchy_level: 2, cat_name: 'Stone Treads'},
#	{ id: 246, parent_id: 2, hierarchy_level: 2, cat_name: 'Veneer & Building Stone'},
#	{ id: 247, parent_id: 2, hierarchy_level: 2, cat_name: 'Supplies'},
#	{ id: 248, parent_id: 2, hierarchy_level: 2, cat_name: 'Millstones'},

#	{ id: 249, parent_id: 2, hierarchy_level: 2, cat_name: 'Outdoor Lighting and Supplies'},
#	{ id: 250, parent_id: 2, hierarchy_level: 2, cat_name: 'Chemicals'},
#	{ id: 251, parent_id: 2, hierarchy_level: 2, cat_name: 'Golf Course Irrigation Supplies'},

    #SUPPLIER TYPE
#	{ id: 500, parent_id: 3, hierarchy_level: 2, cat_name: 'Wholesale Grower'},
#	{ id: 501, parent_id: 3, hierarchy_level: 2, cat_name: 'Stone Center'},
#	{ id: 502, parent_id: 3, hierarchy_level: 2, cat_name: 'Wholesale Nursery'},
#	{ id: 503, parent_id: 3, hierarchy_level: 2, cat_name: 'Material Supplier'},
#	{ id: 504, parent_id: 3, hierarchy_level: 2, cat_name: 'Plant Liner Growers'}

#])