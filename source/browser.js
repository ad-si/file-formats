const htmlTablify = require('html-tablify')
const fileIcon = require('../build/file-icon')
let fileFormats = require('../build/file-formats.json')

fileFormats = fileFormats.map(formatObject => Object.assign(
  {icon: fileIcon(formatObject)},
  formatObject
))

document
  .getElementById('tableContainer')
  .innerHTML = htmlTablify.tablify({
    data: fileFormats,
    border: '0',
    cellpadding: 'a', // Disable with invalid value
    cellspacing: 'a', // Disable with invalid value
  })
