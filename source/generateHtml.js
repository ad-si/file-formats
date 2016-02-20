'use strict'

const fs = require('fs')
const path = require('path')

const htmlTablify = require('html-tablify')
const fileIcon = require('../build/file-icon')
let fileFormats = require('../build/file-formats.json')


fileFormats = fileFormats.map(formatObject => Object
	.assign(
		{
			icon: fileIcon(formatObject)
		},
		formatObject
	)
).slice(0,100)

const fileContent = fs.readFileSync(path.join(__dirname, 'index.html'), 'utf8')

const htmlTable = htmlTablify.tablify({
	data: fileFormats,
	border: '0',
	cellpadding: 'a', // Disable with invalid value
	cellspacing: 'a', // Disable with invalid value
})

const html = fileContent.replace(
	'<div id="tableContainer"></div>',
	htmlTable
)

fs.writeFileSync(path.resolve(__dirname, '../index.html'), html)
