child_process = require 'child_process'
{ cpus } = require 'os'

maxCoreNum = cpus().length

rate = Math.min +process.argv[2], maxCoreNum

[bin, ext] = if process.env.NODE_ENV == 'development'
	['node_modules/.bin/coffee', '.coffee']
else
	['node', '.js']

fork = (id) ->
	child_process.spawn bin,
		[__dirname + '/fuel' + ext, '--', id]

fire = ->
	[0...rate].forEach fork
	console.log "fuel: #{rate}"

main = ->
	if ['help', '-h', 'h', '--help'].reduce (res, el) ->
		process.argv.indexOf(el) > 0 | res
	, false
		console.log "
		\nUsage: heater [coreNumber]\n\n
		  This machine's max core number: #{maxCoreNum}\n
		"
	else
		fire()

main()
