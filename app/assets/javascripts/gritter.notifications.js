// Functions as a selector. Pass in the name of the gritter and it will look it up and call the correct function
// to display that gritter. This way each gritter is its own function that can be styled and updated independently.
function showGritter(gritter){
	if(gritter == 'new_user_add_location'){
		gritterNewUserAddLocation();
	}
	else if(gritter == 'search_product_hints'){
		gritterSearchProductHints();
	}
	else if(gritter == 'multiple_location_names'){
		gritterMultipleLocationNames();
	}
	else if (gritter == 'update_help_supplier'){
		gritterUpdateHelpSupplier();
	}
	else if (gritter == 'update_help_buyer'){
		gritterUpdateHelpBuyer();
	}
	else if (gritter == 'public_profile_update_success'){
		gritterPublicProfileUpdateSuccess();
	}
}

function gritterNewUserAddLocation(){
	$.gritter.add({
		title: 'Add a new location!',
		text: 'LandSpec Pro allows you to have one or multiple locations set up for your company. You\'ll need to add your first location so other landscape professionals can find you. You can add more locations at any time.',
		sticky: true,
		class_name: 'gritter-warning gritter-dark'
	});
}

function gritterSearchProductHints(){
	$.gritter.add({
		title: 'Tips for Searching Products!',
		text: 'Hover over a product name to see a description (if there is one).',
		sticky: true,
		class_name: 'gritter-success gritter-dark'
	});
}

function gritterMultipleLocationNames(){
	$.gritter.add({
		title: 'Adding Multiple Locations',
		text: 'When adding additional locations each location must have a unique location name. This will show up when a user views this location, but will only be searchable by your company name. It is good practice to use a store or location number for multiple locations (e.g. "Store #5").',
		sticky: true,
		class_name: 'gritter-warning gritter-dark'
	});
}

function gritterUpdateHelpSupplier(){
	$.gritter.add({
		title: 'New Updates!',
		text: "We\'ve added and updated a variety of things across LandSpec Pro. The most important changes are the addition of Categories for your locations now, which you\'ll find on your location edit page, and a new Help page which you can access from the dropdown menu at the top of the page. This new addition should help you get acquainted with LandSpec Pro much easier. Please continue to send us your feedback as we improve your experience on LandSpec Pro!",
		sticky: true,
		class_name: 'gritter-success gritter-dark gritter-center'
	});
}

function gritterUpdateHelpBuyer(){
	$.gritter.add({
		title: 'New Updates!',
		text: "We\'ve added and updated a variety of things across LandSpec Pro. The most important change is the addition of a new Help page which you can access from the dropdown menu at the top of the page. This new addition should help you get acquainted with LandSpec Pro much easier. Please continue to send us your feedback as we improve your experience on LandSpec Pro!",
		sticky: true,
		class_name: 'gritter-success gritter-dark gritter-center'
	});
}

function gritterPublicProfileUpdateSuccess(){
	$.gritter.add({
		title: 'Success!',
		text: 'Your Public Profile Settings have been updated.',
		class_name: 'gritter-info gritter-dark'
	});
}