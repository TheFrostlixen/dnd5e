import json, csv
from collections import OrderedDict
from lxml import html


with open('js/spells.json') as f:
	data = json.load(f, object_pairs_hook=OrderedDict)

error_stack = []

for sp in data["spells"]:
	try:
		#print(sp["Name"])
		with open('E:\\Projects\\dnd5e.rf.gd\\modal\\' + sp["id"] + '.htm', 'r') as h:
			tree = html.fromstring( h.read() )
		
		range_text = tree.xpath('/html/body/main/div/div/div/div/div[2]/p[2]/text()')[2]
		duration_text = tree.xpath('/html/body/main/div/div/div/div/div[2]/p[2]/text()')[6].replace('Concentration, ', '')
		descr_text = '\r\n\r\n'.join(tree.xpath('/html/body/main/div/div/div/div/div[2]/p[position()>=3 and position()<=last()-2]/text()'))
		higher_levels_text = tree.xpath('/html/body/main/div/div/div/div/div[2]/p[last()-1]/text()')[0]
		
		vsm = tree.xpath('/html/body/main/div/div/div/div/div[2]/p[2]/text()')[4]
		material_text = vsm[ vsm.find('(')+1 : vsm.find(')') ] if 'M' in vsm else ''
		
		# TODO append to ./sql/dml/s_spell.csv
		'''
		print('\tRange: ' + range_text.strip())
		print('\tDuration: ' + duration_text.strip())
		print('\tDescr: ' + descr_text.strip())
		print('\tHigher: ' + higher_levels_text.strip())
		print('\tMaterials: ' + material_text.strip())
		'''
		
	except Exception as e:
		error_stack.append(sp["Name"])
		print(e)
		#print("!*!*! ERROR on " + sp["Name"])

print('Errors:')
print(error_stack)
