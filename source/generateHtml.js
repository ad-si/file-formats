import fs from 'fs'
import url from 'url'
import path from 'path'
import { fileURLToPath } from 'url'

import htmlTablify from 'html-tablify'

import fileIcon from './file-icon.js'

const dirname = path.dirname(fileURLToPath(import.meta.url))
let fileFormats =  JSON.parse(
  fs.readFileSync(
    path.join(dirname, '../build/file-formats.json'),
    'utf8',
  ),
)


fileFormats = fileFormats
  .map(formatObject => Object
    .assign(
      {icon: fileIcon(formatObject)},
      formatObject,
    ),
  )
  .map(formatObject => {
    if (!formatObject.links) {
      return formatObject
    }

    formatObject.links = formatObject.links
      .split(',')
      .map(link => `<a href="${link}">${url.parse(link).hostname}</a>`)
      .join('')

    return formatObject
  })
  // .slice(0,100)


const fileContent = fs.readFileSync(path.join(dirname, 'index.html'), 'utf8')

const htmlTable = htmlTablify.tablify({
  data: fileFormats,
  border: '0',
  cellpadding: 'a', // Disable with invalid value
  cellspacing: 'a', // Disable with invalid value
})

const html = fileContent.replace(
  '<div id="tableContainer"></div>',
  htmlTable,
)

fs.writeFileSync(path.resolve(dirname, '../index.html'), html)
