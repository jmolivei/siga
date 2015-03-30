var jsfmenu = function () {
	$("div .rf-tb-itm").each(function(index, value) { 
	    console.log('div' + index + ':' + $(this).attr('id') +  $(this).find(".rf-ddm-lbl-dec").text());
	    console.log('--- ' + $(this).find("div .rf-ddm-itm"));
		var x = $('<li class="dropdown" id="menu-app"><a href="#" class="dropdown-toggle"> <i class="fa fa-sitemap"></i> <span class="hidden-xs">' + $(this).find(".rf-ddm-lbl-dec").text() + '</span></a></li>');
		x.appendTo(".main-menu");
		
	    var itms = $('<ul class="dropdown-menu"></ul>');
	    itms.appendTo(x);

		$(this).find("div .rf-ddm-itm").each(function(index, value) {
		    console.log('itm' + index + ':' + $(this).attr('id') +  $(this).text());
		    console.log('lbl' + $(this).find(".rf-ddm-itm-lbl").text());
		    
		    var itm = $('<li class="dropdown"><a class="dropdown-toggle" onclick="getElementById(&quot;' + $(this).attr('id') + '&quot;).click()"><i class="fa fa-cube"></i><span class="hidden-xs">' + $(this).find(".rf-ddm-itm-lbl").text() + '</span></a></li>');
		    itm.appendTo(itms);
		    
		    
			$("rf-ddm-itm-lbl").each(function(index, value){  
			    console.log('lbl' + index + ':' + $(this).attr('id') +  $(this).text());
		    	console.log($(this).text());
			});
		});
		
	});
}

jsfmenu();