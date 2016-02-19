all: build/file-formats.json build/file-formats.yaml main.js

build/file-formats.json build/file-formats.yaml: source/file-formats.tsv | build
	univert --force $< $@

main.js: source/index.js build/file-icon.js
	./node_modules/.bin/browserify $< > $@

build/file-icon.js: source/file-icon.coffee | build
	./node_modules/.bin/coffee --compile --output ./build ./source

build:
	-mkdir build
