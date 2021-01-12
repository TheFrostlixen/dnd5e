import json
import requests
import codecs
from collections import OrderedDict
from lxml import etree
from io import StringIO
from shutil import copyfile
from bs4 import BeautifulSoup as Soup


with open('../js/spells.json') as f:
	data = json.load(f, object_pairs_hook=OrderedDict)

error_stack = []

for sp in data["spells"]:
	try:
		print(sp["Name"])
		filename = sp["url"][31:] + ".htm"
		copyfile("_template.htm", filename)
		
		html = requests.get( sp["url"] ).text
		soup = Soup(html, features="lxml")
		content = soup.find(id="page-content").decode()
		
		with open(filename, 'r') as f:
			page = f.read()
		
		page = page.replace("$SPELLNAME", sp["Name"])
		page = page.replace("$CONTENT", content)
		
		with codecs.open(filename, 'w', encoding='utf8') as f:
			f.write(page)
	except:
		error_stack.append(sp["Name"])
		print("!*!*! ERROR on " + sp["Name"])

print('Errors:')
print(error_stack)
