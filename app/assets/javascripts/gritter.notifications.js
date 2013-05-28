// Functions as a selector. Pass in the name of the gritter and it will look it up and call the correct function
// to display that gritter. This way each gritter is its own function that can be styled and updated independently.
function showGritter(gritter){
	if(gritter == 'new_user_add_location'){
		gritterNewUserAddLocation();
	}
	else if(gritter == 'search_product_hints'){
		gritterSearchProductHints();
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
		text: '1. Hover over a product name to see a description.',
		sticky: true,
		class_name: 'gritter-success gritter-dark'
	});
}