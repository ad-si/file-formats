all: build/file-formats.json build/file-formats.yaml

build/file-formats.json build/file-formats.yaml: source/file-formats.tsv | build
	univert $< $@

build:
	-mkdir build
