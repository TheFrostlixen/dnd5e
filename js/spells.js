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
		
		for (j = 0; j < search_criteria.length; j++) {
			(!~$($(spell_list[i]).children()[j]).text().toLowerCase().indexOf( search_criteria[j].toLowerCase() )) ? $(spell_list[i]).hide() : null;
		}
	}
	
	fix_striping();
}

function show_modal(spell_name) {
	$('#details_modal')[0].style.display = "block";
	$("#spell_details").load("modal/" + spell_name + ".htm");
}

function fix_striping() {
	$('tr:not([style="display: none;"])').each(function (index) {
		$(this).removeClass("stripe");
		if ( index % 2 == 0) {
			$(this).addClass("stripe");
		}
	});
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

$(document).ready(function() {
	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
		if (event.target == document.getElementById("details_modal")) {
			$('#details_modal')[0].style.display = "none";
		}
	}
});
