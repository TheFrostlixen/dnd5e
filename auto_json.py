import json, re
from collections import OrderedDict
from lxml import etree
from io import StringIO
import requests

with open('js/spells.json') as f:
	data = json.load(f, object_pairs_hook=OrderedDict)

error_stack = []
base_url = ''

for sp in data["spells"]:
	if sp["url"] == '':
		try:
			print(sp["Name"])
			spell_name = re.sub(r'[ /]', r'-', sp["Name"].lower())
			spell_name = re.sub(r'\'', r'', spell_name)
			test_url = base_url + spell_name
			sp["url"] = test_url

			html = requests.get(test_url).text
			tree = etree.parse(StringIO(html), parser=etree.HTMLParser())
			tags = tree.xpath('/html/body/div[1]/div[3]/div[1]/main/div/div/div/div/div[3]/p[last()]')
			
			a_tags = iter( tags[0].getchildren() )
			next(a_tags)
			sp["Class"] = ', '.join([a.text for a in a_tags])
		except:
			error_stack.append(sp["Name"])
			print("!*!*! ERROR on " + sp["Name"])

with open('js/spells-test.json', 'w') as f:
	json.dump(data, f, indent=4, sort_keys=False)

print('Errors:')
print(error_stack)
