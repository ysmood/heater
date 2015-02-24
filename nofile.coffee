kit = require 'nokit'

module.exports = (task) ->
	task 'dev', ->
		kit.monitorApp bin: 'coffee', args: ['src/main.coffee', 'h']

	task 'build', ->
		kit.require 'drives'

		kit.warp 'src/*.coffee'
		.load kit.drives.auto 'compile'
		.load (file) ->
			# Add shebang
			if file.dest.name == 'main'
				file.set '#!/usr/bin/env node\n' + file.contents
		.run 'dist'
