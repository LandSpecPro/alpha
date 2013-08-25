# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create([
#
#	#TOPLEVEL
#	{ id: 1, cat_name: 'Plants'},
#	{ id: 2, cat_name: 'Materials'},
#
#	#PLANTS
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
	{ id: 116, parent_id: 1, hierarchy_level: 2, cat_name: 'Natives'},
	{ id: 117, parent_id: 1, hierarchy_level: 2, cat_name: 'Wetland Plans'},
	{ id: 118, parent_id: 1, hierarchy_level: 2, cat_name: 'Vegetables'},
	{ id: 119, parent_id: 1, hierarchy_level: 2, cat_name: 'Bulbs'},
	{ id: 120, parent_id: 1, hierarchy_level: 2, cat_name: 'Cacti & Succulents'}
#
#	#MATERIALS
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
#	{ id: 244, parent_id: 2, hierarchy_level: 2, cat_name: 'Stepping Stones'},
#	{ id: 245, parent_id: 2, hierarchy_level: 2, cat_name: 'Stone Treads'},
#	{ id: 246, parent_id: 2, hierarchy_level: 2, cat_name: 'Veneer & Building Stone'},
#	{ id: 247, parent_id: 2, hierarchy_level: 2, cat_name: 'Supplies'},
#	{ id: 248, parent_id: 2, hierarchy_level: 2, cat_name: 'Millstones'}
#
])

#Location.create!([ # CHANGE BUS_VENDOR_ID BACK TO 1, or whatever FISOUTDOOR is in production
#
#	{
#		bus_vendor_id: 1,  
#		locName: 'Orlando #101',
#		
#		primaryPhone: '(407) 425-6669',
#		address1: '2400 Paseo Ave.',
#		city: 'Orlando',
#		state: 'FL',
#		zip: '32805',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{
#		bus_vendor_id: 1,
#		locName: 'Ft. Myres #102',
#		
#		primaryPhone: '(239) 936-6556',
#		address1: '6300 Arc Way',
#		city: 'Ft. Myres',
#		state: 'FL',
#		zip: '33966',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{
#		bus_vendor_id: 1,  
#		locName: 'Gainesville #103',
#		
#		primaryPhone: '(352) 375-2225',
#		address1: '1250 NW 53rd Ave.',
#		city: 'Gainesville',
#		state: 'FL',
#		zip: '32653',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{
#		bus_vendor_id: 1,  
#		locName: 'Jacksonville #104',
#		
#		primaryPhone: '(904) 363-8899',
#		address1: '8863-2 Phillips Hwy.',
#		city: 'Jacksonville',
#		state: 'FL',
#		zip: '32256',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Tampa #105',
#		
#		primaryPhone: '(813) 978-1181',
#		address1: '14751 N. Nebraska Ave.',
#		
#		city: 'Tampa',
#		state: 'FL',
#		zip: '33613',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Lakeland #106',
#		
#		primaryPhone: '(863) 683-1323',
#		address1: '930 E. Oak St.',
#		
#		city: 'Lakeland',
#		state: 'FL',
#		zip: '33801',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Ormond Beach #107',
#		
#		primaryPhone: '(386) 673-8899',
#		address1: '1136 N. U.S. Hwy 1',
#		
#		city: 'Ormond Beach',
#		state: 'FL',
#		zip: '32174',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Clearwater #108',
#		
#		primaryPhone: '(727) 446-3534',
#		address1: '1740 Calumet St.',
#		
#		city: 'Clearwater',
#		state: 'FL',
#		zip: '33765',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Minneola #110',
#		
#		primaryPhone: '(352) 242-9050',
#		address1: '514 Disston Ave.',
#		
#		city: 'Minneola',
#		state: 'FL',
#		zip: '34755',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Oviedo #111',
#		
#		primaryPhone: '(407) 365-2225',
#		address1: '290 Mitchell Hammock Rd. W.',
#		
#		city: 'Oviedo',
#		state: 'FL',
#		zip: '32765',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Kissimmee #112',
#		
#		primaryPhone: '(407) 518-1555',
#		address1: '2792 Michigan Ave.',
#		address2: '#400',
#		city: 'Kissimmee',
#		state: 'FL',
#		zip: '34744',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Ocala #113',
#		
#		primaryPhone: '(352) 368-5600',
#		address1: '1490-A NW 38th Ave.',
#		
#		city: 'Ocala',
#		state: 'FL',
#		zip: '34482',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Jacksonville Beach #114',
#		
#		primaryPhone: '(904) 247-8899',
#		address1: '740 10th ST South',
#		
#		city: 'Jacksonville Beach',
#		state: 'FL',
#		zip: '32250',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Pooler #115',
#		
#		primaryPhone: '(912) 964-2363',
#		address1: '62 Columbia Drive',
#		
#		city: 'Pooler',
#		state: 'GA',
#		zip: '31322',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Sebring #116',
#		
#		primaryPhone: '(863) 471-1110',
#		address1: '6771 US Hwy 27 S',
#		
#		city: 'Sebring',
#		state: 'FL',
#		zip: '33876',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Tallahassee #117',
#		
#		primaryPhone: '(850) 580-5251',
#		address1: '3481 Gerber Dr.',
#		
#		city: 'Tallahassee',
#		state: 'FL',
#		zip: '32303',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'West Palm Beach #118',
#		
#		primaryPhone: '(561) 688-1477',
#		address1: '7153 C-2 Southern Blvd.',
#		
#		city: 'West Palm Beach',
#		state: 'FL',
#		zip: '33413',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Palm Coast #119',
#		
#		primaryPhone: '(386) 586-0137',
#		address1: '304 N State Street',
#		
#		city: 'Bunnell',
#		state: 'FL',
#		zip: '32110',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Sanford #121',
#		
#		primaryPhone: '(407) 323-4222',
#		address1: '300 Central Park Drive',
#		
#		city: 'Sanford',
#		state: 'FL',
#		zip: '32771',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Santa Rosa Beach #123',
#		
#		primaryPhone: '(850) 622-2797',
#		address1: '76 Shannon Lane',
#		
#		city: 'Santa Rosa Beach',
#		state: 'FL',
#		zip: '32459',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Brunswick #124',
#		
#		primaryPhone: '(912) 554-2270',
#		address1: '128 Shell Drive',
#		
#		city: 'Brunswick',
#		state: 'GA',
#		zip: '31520',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Greenville #125',
#		
#		primaryPhone: '(864) 299-5424',
#		address1: '1 North Kings Road',
#		
#		city: 'Greenville',
#		state: 'SC',
#		zip: '29605',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Summerfield #127',
#		
#		primaryPhone: '(352) 245-4428',
#		address1: '15430 S Hwy 441',
#		
#		city: 'Summerfield',
#		state: 'FL',
#		zip: '34491',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Ft. Lauderdale #128',
#		
#		primaryPhone: '(954) 689-6406',
#		address1: '5320 NW 10th Terrace',
#		
#		city: 'Ft. Lauderdale',
#		state: 'FL',
#		zip: '33309',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Orange Park #129',
#		
#		primaryPhone: '(904) 541-1255',
#		address1: '170-A Industrial Loop South',
#		
#		city: 'Orange Park',
#		state: 'FL',
#		zip: '32073',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Port St. Lucie #130',
#		
#		primaryPhone: '(772) 464-9288',
#		address1: '857 SW South Macedo Blvd',
#		
#		city: 'Port St. Lucie',
#		state: 'FL',
#		zip: '34983',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Miami #134',
#		
#		primaryPhone: '(305) 392-3202',
#		address1: '7811-21 NW 62nd St.',
#		
#		city: 'Miami',
#		state: 'FL',
#		zip: '33166',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Naples #135',
#		
#		primaryPhone: '(239) 594-0904',
#		address1: '5565 Shirley St.',
#		
#		city: 'Naples',
#		state: 'FL',
#		zip: '34109',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Pelham #136',
#		
#		primaryPhone: '(205) 621-2116',
#		address1: '1840 McCain Parkway',
#		
#		city: 'Pelham',
#		state: 'AL',
#		zip: '35124',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Mathews #137',
#		
#		primaryPhone: '(704) 893-0707',
#		address1: '13011 E Independence Blvd.',
#		
#		city: 'Mathews',
#		state: 'NC',
#		zip: '28105',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Pensacola #140',
#		
#		primaryPhone: '(850) 262-0430',
#		address1: '2810 Copter Rd.',
#		
#		city: 'Pensacola',
#		state: 'FL',
#		zip: '32514',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	},
#	{bus_vendor_id: 1,  
#		locName: 'Mooresville #141',
#		
#		primaryPhone: '(704) 664-1805',
#		address1: '1086 River Highway',
#		address2: 'Unit D',
#		city: 'Mooresville',
#		state: 'NC',
#		zip: '28117',
#		primaryEmail: 'jeff.fischer@fisoutdoor.com',
#		websiteLink: 'http://www.fisoutdoor.com',
#		facebookLink: 'https://www.facebook.com/pages/FIS-Outdoor/305688348364'
#	}
#])



### WHEN PUSHING TO PRODUCTION --
	# rake db:migrate
	# rake db:seed
	# geocode:all CLASS=Locations
	# what did I need to do to update searchWeight, do that too