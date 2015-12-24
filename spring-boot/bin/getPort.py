import sys, json
#combine all args into 1 string
args = ''
for i in sys.argv:
	if i != 'getPort.py':
		args = args + i + ' '	

port = json.loads(args)[0]['HostConfig']['PortBindings']['6379/tcp'][0]['HostPort']

print port
