import sys

filepath = sys.argv[1]
with open(filepath, 'r', encoding='utf-8') as file:
  content = file.read()

with open('.replace/buysellads', 'r', encoding='utf-8') as file:
  buysellads = file.read()
with open('.replace/docsearch', 'r', encoding='utf-8') as file:
  docsearch = file.read()

content = content.replace(buysellads, '')
content = content.replace(docsearch, '')

with open(filepath, 'w', encoding='utf-8') as file:
  file.write(content)