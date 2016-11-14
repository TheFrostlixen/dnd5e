function create_links() {
	var rows = $('tr.row');
	Array.prototype.forEach.call( rows, function(el) {
		var name = el.children[0].innerHTML.trim();
		var spell = name.replace('\'','').replace('/','').replace(/ /g,'-') + el.children[3].innerHTML.trim().replace("Yes", "-Ritual");
		
		el.children[0].innerHTML = "<a href=\'https://www.dnd-spells.com/spell/" + spell + "\' target=\'_blank\'>" + name + "</a>";
	});
	
	fix_striping();
}

function update_list() {
	var searchSchool = $('#school').val();
	var searchLevel  = $('#level').val();
	var searchClass  = $('#class_select').val();
	var searchRitual = $('#ritual').is(':checked') ? "Yes" : "";
	var searchConc   = $('#concentration').is(':checked') ? "Yes" : "";
	var searchName   = $('#spell').val();
	
	var spellList = $('#spelltable').children();
	for (i = 0; i < spellList.length; i++) {
		$(spellList[i]).show();
		// filter schools
		(!~$($(spellList[i]).children()[1]).text().indexOf( searchSchool )) ? $(spellList[i]).hide() : null;
		// filter levels
		(!~$($(spellList[i]).children()[2]).text().indexOf( searchLevel )) ? $(spellList[i]).hide() : null;
		// filter class
		(!~$($(spellList[i]).children()[5]).text().indexOf( searchClass )) ? $(spellList[i]).hide() : null;
		// filter rituals
		(!~$($(spellList[i]).children()[3]).text().indexOf( searchRitual )) ? $(spellList[i]).hide() : null;
		// filter concentration
		(!~$($(spellList[i]).children()[4]).text().indexOf( searchConc )) ? $(spellList[i]).hide() : null;
		// filter by spell name
		(!~$($(spellList[i]).children()[0]).text().toLowerCase().indexOf( searchName.toLowerCase() )) ? $(spellList[i]).hide() : null;
	}
	
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

function reset_list() {
	$('#school').val("");
	$('#level').val("");
	$('#class_select').val("");
	$('#ritual').attr('checked', false);
	$('#concentration').attr('checked', false);
	$('#spell').val("");
	
	update_list();
}
