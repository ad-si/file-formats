shaven = require 'shaven'

module.exports = (config) ->

	defaults =
		width: 16
		height: 16
		type: if config.encoding and not config.type \
			then config.encoding
			else 'binary'

	config = Object.assign(
		{},
		defaults,
		config
	)

	{width, height} = config


	icon = {}
	icon.text = ['g'
		transform: 'translate(3,3)'
		[
			'rect'
			width: 5
			height: 1
		]
		[
			'rect'
			y: 2
			width: 10
			height: 1
		]
		[
			'rect'
			y: 4
			width: 10
			height: 1
		]
	]

	icon.code = ['g'
		[
			'text'
			'</>'
			x: 8
			y: 7
			'text-anchor': 'middle'
			style:
				'font-family': 'Courier, monospace'
				'font-size': (width + height) / 5
		]
	]

	icon.binary = ['g'
		{
			transform: 'translate(4,3)'
		}
		['rect'
			width: 1
			height: 4
		]
		['ellipse'
			cx: 3
			cy: 2
			rx: 1
			ry: 1.5
			style:
				stroke: 'black'
				'stroke-width': 1
				fill: 'none'
		]
		['rect'
			x: 5
			width: 1
			height: 4
		]
		['rect'
			x: 7
			width: 1
			height: 4
		]
	]

	icon.photo = ['g'
		[
			'circle'
			r: 5
			cx: 8
			cy: 4
		]
	]

	icon.video = ['g'
		{
			transform: 'translate(2,3)'
		}
		['rect'
			width: 3
			height: 4
		]
		['rect'
			y: 0.5
			x: 4.5
			width: 3
			height: 3
			style:
				stroke: 'black'
				'stroke-width': 1
		]
		['rect'
			x: 9
			width: 3
			height: 4
		]
	]

	icon.audio = ['g'
		[
			'path'
			d: 'M3.5,5 q0.75,2 1.5,0 t1.5,0 t1.5,0 t1.5,0 t1.5,0 t1.5,0'
			style:
				fill: 'none'
				stroke: 'black'
				'stroke-width': 1
		]
	]


	shavenArray = [
		'svg'
		width: (width * 1.25) + 'px'
		height: (height * 1.25) + 'px'
		viewBox: [
			0
			0
			width
			height
		]
		['style',
			"""
			* {
				color: black;
			}
			"""
		]
		['rect'
			width: width
			height: height
			style:
				fill: 'white'
		]
		['g'
			icon[config.type]
			['text'
				config.extensions.split(',')[0].slice(-4)
				x: 8
				y: 13.5
				'text-anchor': 'middle'
				style:
					'font-size': ((width + height) / 5.5) + 'px'
					'font-family': 'Arial, sans-serif'
			]
		]
	]

	return shaven(shavenArray)[0]
