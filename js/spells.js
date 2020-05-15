function load_table(selector) {
	$.ajaxSetup( { beforeSend: function(xhr) {
		if (xhr.overrideMimeType) {
			xhr.overrideMimeType("application/json");
		}
	}});
	
	$.getJSON("js/spells.json",{}, function( data ){
		spells_list = data.spells;
		build_html_table(selector, spells_list);
	});
}

function build_html_table(selector, spells_list) {
	var columns = ["Name", "Level", "School", "Casting Time", "Ritual", "Concentration", "Components", "Class", "Book"];

	for (var i = 0; i < spells_list.length; i++) {
		var row = $('<tr/>');
		var chk_spellbook_element = $('<td/>').html('<input class="save" id="save_' + spells_list[i]["id"] + '" type="checkbox"/>')
		row.append(chk_spellbook_element);
		
		for (var j = 0; j < columns.length; j++) {
			var value = spells_list[i][columns[j]];
			if (value == null) value = "";
			
			if (j == 0) { // add span to Name cell to open modal
				value = '<span onclick="show_modal(\'' + spells_list[i]["id"] + '\')">' + value + '</span>';
			}
			
			row.append($('<td/>').html(value));
		}
		$(selector).append(row);
	}
	
	load_spellbook();
	register_events();
	fix_striping();
}

function update_list() {
	var search_criteria = [ $('#name').val(),
							$('#level').val(),
							$('#school').val(),
							$('#cast_time').val(),
							$('#ritual').is(':checked') ? "Yes" : "",
							$('#concentration').is(':checked') ? "Yes" : "",
							$('#components').val(),
							$('#class_select').val(),
							$('#book').val()
						  ];
	
	var spell_list = $('#spelltable').children();
	for (i = 0; i < spell_list.length; i++) {
		$(spell_list[i]).show();
		if ($('#spellbook_button').text() == "Hide Spellbook") { // Spellbook is active, filter through only spellbook
			$('#spelltable td input:not(:checked)').closest('tr').hide();
		}
		
		
		for (j = 0; j < search_criteria.length; j++) {
			(!~$($(spell_list[i]).children()[j+1]).text().toLowerCase().indexOf( search_criteria[j].toLowerCase() )) ? $(spell_list[i]).hide() : null;
		}
	}
	
	fix_striping();
}

function reset_list() {
	$('#name').val("");
	$('#level').val("");
	$('#school').val("");
	$('#cast_time').val("");
	$('#components').val("");
	$('#class_select').val("");
	$('#book').val("");
	$('#class_select').val("");
	$('#ritual').attr('checked', false);
	$('#concentration').attr('checked', false);
	
	$('#spelltable').children(':hidden').show();
	fix_striping();
}

function fix_striping() {
	$('tr:not([style="display: none;"])').each(function (index) {
		$(this).removeClass("stripe");
		if ( index % 2 == 0) {
			$(this).addClass("stripe");
		}
	});
}

function show_modal(spell_name) {
	$("#spell_details").load("modal/" + spell_name + ".htm");
	$('#details_modal')[0].style.display = "block";
}

function hide_modal() {
	$("#spell_details").html("Loading...");
	$('#details_modal')[0].style.display = 'none';
}

function save_spellbook() {
	document.cookie = "spellbook=;expires=Thu, 01 Jan 1970"; // delete current cookie
	
	var cookie = "spellbook=" +
				 $('td input:checked').map( function() { return $(this).attr('id'); } ).get().join(',');
	
	cookie += "; expires=Tue, 19 Jan 2038 03:14:07 UTC;path=/;";
	
	console.log(cookie);
	document.cookie = cookie;
}

function load_spellbook() {
	var spellbook;
	
	var name = "spellbook=";
	var ca = document.cookie.split(';');
	for (var i = 0; i < ca.length; i++) {
		var c = $.trim( ca[i] );
		if (c.indexOf(name) == 0) {
			// parse saved spells
			spellbook = c.substring(name.length, c.length).split(',');
			
			// check off saved spells
			for (var i = 0; i < spellbook.length; i++) {
				$('#' + spellbook[i]).attr('checked', 'true');
			}
			
			break;
		}
	}
}

function toggle_spellbook() {
	if ($('#spellbook_button').text() == "Show Spellbook") {
		$('#spelltable td input:not(:checked)').closest('tr').hide();
		fix_striping();
		
		$('#spellbook_button').text("Hide Spellbook");
	}
	else if ($('#spellbook_button').text() == "Hide Spellbook") {
		$('#spelltable td input:not(:checked)').closest('tr').show();
		fix_striping();
		
		$('#spellbook_button').text("Show Spellbook");
	}
}

function register_events() {
	// When the user clicks anywhere outside of the modal, close it
	$(window).click(function(event) {
		if (event.target == document.getElementById("details_modal")) {
			hide_modal();
		}
	});
	
	// When the user checks a checkbox, save it to the spellbook cookie
	$('.save').click(function() {
		save_spellbook();
	});
}
