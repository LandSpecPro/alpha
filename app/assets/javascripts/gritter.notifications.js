// Functions as a selector. Pass in the name of the gritter and it will look it up and call the correct function
// to display that gritter. This way each gritter is its own function that can be styled and updated independently.
function showGritter(gritter){
	if(gritter == 'new_user_add_location'){
		gritterNewUserAddLocation();
	}
	else if(gritter == 'multiple_location_names'){
		gritterMultipleLocationNames();
	}
	else if (gritter == 'update_helppage'){
		gritterUpdateHelpPage();
	}
	else if (gritter == 'update_publicprofiles'){
		gritterUpdatePublicProfiles();
	}
}

function gritterNewUserAddLocation(){
	$.gritter.add({
		title: 'Add a new location!',
		text: 'LandSpec Pro allows you to have one or multiple locations set up for your company. You\'ll need to add your first location so other landscape professionals can find you. You can add more locations at any time.',
		sticky: true,
		class_name: 'gritter-warning gritter-light'
	});
}

function gritterMultipleLocationNames(){
	$.gritter.add({
		title: 'Adding Multiple Locations',
		text: 'When adding additional locations each location must have a unique location name. This will show up when a user views this location, but will only be searchable by your company name. It is good practice to use a store or location number for multiple locations (e.g. "Store #5").',
		sticky: true,
		class_name: 'gritter-warning gritter-light'
	});
}

function gritterUpdateHelpPage(){
	$.gritter.add({
		title: 'New Updates!',
		text: "There is now a 'Help' page, accessible from the dropdown menu at the top of the page. This page will expand as we add new features and offer some help and insight on how to get the most out of LandSpec Pro.",
		sticky: true,
		class_name: 'gritter-success gritter-light gritter-center'
	});
}

function gritterUpdatePublicProfiles(){
	$.gritter.add({
		title: 'New Updates!',
		text: "We have a HUGE update for all Suppliers! We're happy to introduce our new public profiles. You now have the ability to display a public version of your profile and share it with anyone, even if they aren't on LandSpec Pro. You can customize all the information people see, and you even get your own URL (http://www.landspecpro.com/profiles/your_custom_url). We've set up a temporary URL for you, but all you need to do is go to your Edit Location page and click the new tab for Profile Settings. Here you can set a custom URL and update what information is visible on your public profile.",
		sticky: true,
		class_name: 'gritter-success gritter-light gritter-center'
	});
}

function showUpdateSuccessGritter(updated){
	$.gritter.add({
		title: 'Success!',
		text: updated,
		class_name: 'gritter-info gritter-dark', 
		time: 1200
	});
}