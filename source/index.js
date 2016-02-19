const $ = require('jquery')
const htmlTablify = require('html-tablify')
const fileIcon = require('../build/file-icon')

$.ajax({
	dataType: 'json',
	url: '/build/file-formats.json',
	success: (fileFormats) => {

		fileFormats = fileFormats.map(formatObject => Object
			.assign({icon: fileIcon(formatObject)}, formatObject)
		)

		$('#tableContainer')
			.html(htmlTablify.tablify({
				data: fileFormats,
				border: '0',
				cellpadding: 'a', // Disable with invalid value
				cellspacing: 'a', // Disable with invalid value
			}))
	}
})
