child_process = require 'child_process'
{ cpus } = require 'os'

maxCoreNum = cpus().length

rate = Math.min +process.argv[2], maxCoreNum

[bin, ext] = if process.env.NODE_ENV == 'development'
	['node_modules/.bin/coffee', '.coffee']
else
	['node', '.js']

fork = ->
	child_process.spawn bin, [__dirname + '/fuel' + ext]

fire = ->
	[0...rate].forEach fork
	console.log "Rate: #{rate}\nCtrl-C to stop"

help = ->
	console.log """

	Usage: heater [coreNumber]\n
	  This machine's max core number: #{maxCoreNum}

	Example:\n
	  heater 3
	"""

main = ->
	if rate > 0
		fire()
	else
		help()

main()
