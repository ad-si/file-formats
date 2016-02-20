all: build/file-formats.json build/file-formats.yaml index.html

build/file-formats.json build/file-formats.yaml: source/file-formats.tsv | build
	univert --force $< $@

main.js: source/browser.js build/file-icon.js
	./node_modules/.bin/browserify $< > $@

index.html: build/file-icon.js build/file-formats.json source/generateHtml.js
	node source/generateHtml.js

build/file-icon.js: source/file-icon.coffee | build
	./node_modules/.bin/coffee --compile --output ./build ./source

build:
	-mkdir build
