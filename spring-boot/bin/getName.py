import sys, json
#combine all args into 1 string
args = ''
for i in sys.argv:
	if i != 'getName.py':
		args = args + i + ' '	

container = json.loads(args)[0]['Name']
name = container[1:]

print name
