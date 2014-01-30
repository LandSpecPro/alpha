// Apply chosen style for text boxes
function applyChosenStyle(){
	$(".chzn-select").chosen({ width: '100%' !important; });
}

// Apply colorbox style for viewing images
function applyColorbox() {

	var colorbox_params = getColorboxParams();

	$('[data-rel="colorbox"]').colorbox(colorbox_params).show();
	$('.colorbox').colorbox(colorbox_params).show();

	$(window).on('resize.colorbox', function() {
		try {
			$.fn.colorbox.load();//to redraw the current frame
		} catch(e){}
	});
}

function getColorboxParams(){

	var colorbox_params = {
		reposition:true,
		scalePhotos:true,
		scrolling:false,
		previous:'<i class="icon-arrow-left"></i>',
		next:'<i class="icon-arrow-right"></i>',
		close:'&times;',
		current:'{current} of {total}',
		maxWidth:'100%',
		maxHeight:'100%',
		onOpen:function(){
			document.body.style.overflow = 'hidden';
		},
		onClosed:function(){
			document.body.style.overflow = 'auto';
		},
		onComplete:function(){
			$.colorbox.resize();
		}
	};

	return colorbox_params;
}

function applyPopovers(){

	$('[data-rel=tooltip]').tooltip();
	$('[data-rel=popover]').popover({html:true});

	$('.popover-phone').popover({
		content: "This is only for contact and verification purposes and will never be made public.",
		placement: "bottom",
		trigger: 'focus hover'
	});

	$('#infoboxInventoryViews').popover({
		content: "Here you can see how many people have viewed your inventory through LandSpec Pro.",
		placement: "top",
		trigger: 'hover',
		container: 'body'
	});

	$('.profile-social-links > a').tooltip();
	$('.tooltip-success').tooltip();
	$('.tooltip-info').tooltip();
	$('.tooltip-error').tooltip();
}

/*
	function fileInput(){
		$('#image').ace_file_input({
				no_file:'No File ...',
				btn_choose:'Choose',
				droppable:false,
				onchange:null,
				thumbnail:false
			}).on('change', function(){
				var files = $(this).data('ace_input_files');
				update_file_text(files);
			});
	}

	function update_file_text(files){
		$('#image').text = files.value;
	}
*/