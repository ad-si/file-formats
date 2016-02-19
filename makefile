all: main.js build/file-formats.json build/file-formats.yaml

build/file-formats.json build/file-formats.yaml: source/file-formats.tsv | build
	univert --force $< $@

main.js: source/index.js
	./node_modules/.bin/browserify $< > $@

build:
	-mkdir build
