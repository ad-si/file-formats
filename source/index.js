const $ = require('jquery')
const htmlTablify = require('html-tablify')

$.ajax({
	dataType: 'json',
	url: '/build/file-formats.json',
	success: (fileFormats) => {
		$('#tableContainer')
			.html(htmlTablify.tablify({data: fileFormats}))
	}
})
