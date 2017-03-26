shaven = require('shaven').default
ColorHash = require 'color-hash'
colorHash = new ColorHash({lightness: 0.7})
fileFormats = require '../build/file-formats.json'

module.exports = (config) ->
  defaults =
    width: 16
    height: 16
    standalone: false
    type: if config.encoding and not config.type \
      then config.encoding
      else 'binary'

  config = Object.assign(
    {},
    defaults,
    config
  )

  {width, height} = config
  mainExtension = switch
    when config.extension then config.extension
    when typeof config.extensions is 'string' \
      then config.extensions.split(',')[0]
    when Array.isArray(config.extensions) then config.extensions[0]
    else ''

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
        'font-weight': 900
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


  icon.photo = icon.image = ['g'
    [
      'rect'
      x: 3.5
      y: 2.5
      width: 9
      height: 5
      style:
        fill: 'none'
        stroke: 'black'
        'stroke-width': 1
    ]
    [
      'circle'
      cx: 6
      cy: 4.5
      r: 1
    ]
    [
      'path'
      d: 'M6,8 l2,-2 l1,0.5 l1,-2 l2,3 z'
    ]
  ]

  icon.video = ['g'
    {
      transform: 'translate(1,3)'
      style:
        fill: 'none'
        stroke: 'black'
        'stroke-width': 1
    }
    ['path' # Left frame
      d: 'M0.5,0.5 h2 v4 h-2'
    ]
    ['rect' # Center frame
      x: 4.5
      y: 0.5
      width: 5
      height: 4
    ]
    ['circle' # Sun
      cx: 6.5
      cy: 2
      r: 0.8
      style:
        fill: 'black'
        stroke: 'none'
    ]
    ['path' # Mountain
      d: 'M6,5 l2,-2.5 l1.5,2.5 z'
      style:
        fill: 'black'
        stroke: 'none'
    ]
    ['path' # Right frame
      d: 'M13.5,0.5 h-2 v4 h2'
    ]
  ]

  icon.audio = ['g'
    [
      'path'
      d: 'M2.5,5 q0.75,2 1.5,0
        t1.5,1 t1.5,-1 t1.5,0
        t1.5,1 t1.5,-1 t1.5,0'
      style:
        fill: 'none'
        stroke: 'black'
        'stroke-width': 1
        'stroke-linecap': 'round'
    ]
  ]


  config.tags
    ?.split ','
    .map (tag) ->
      tag.trim()
    .some (tag) ->
      if icon[tag]
        config.type = tag
        return true
      else
        return false


  printedExtension = if mainExtension and mainExtension.length > 5 \
    then '...' + mainExtension.slice(-3)
    else mainExtension

  shavenArray = [
    'svg'
    width: config.standalone ? (width * 1.25) + 'px' : null
    height: config.standalone ? (height * 1.25) + 'px' : null
    viewBox: [
      0
      0
      width
      height
    ],
    ['rect'
      width: width
      height: height
      style:
        fill: colorHash.hex(mainExtension + config.format)
    ]
    ['g'
      icon[config.type]
      ['text'
        printedExtension
        x: 8
        y: 13.5
        'text-anchor': 'middle'
        style:
          'font-size': ((width + height) / 5.5) + 'px'
          'font-family': 'Arial, sans-serif'
          'letter-spacing': '-0.2px'
      ]
    ]
  ]

  return shaven(shavenArray)[0]
