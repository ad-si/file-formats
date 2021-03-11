all: build/file-formats.json build/file-formats.yaml index.html


build/file-formats.json build/file-formats.yaml: source/file-formats.tsv | build
	-univert $< $@


main.js: source/browser.js
	./node_modules/.bin/browserify $< > $@


index.html: build/file-formats.json source/generateHtml.js
	node source/generateHtml.js


build:
	-mkdir build
