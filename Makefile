.DEFAULT_GOAL := build
TARGET_BINARY := hannya.pdx
FONT_URL := "https://github.com/jdh8/source-han-serif/raw/refs/heads/master/SourceHanSerifJP-Medium.otf"
FONT_DIR := support/fonts

.PHONY: build
build:
	@echo "Building the project..."
	pdc source ${TARGET_BINARY}
	@echo "done."

.PHONY: update-font
update-font: 
	@echo "Retrieving font..."
	curl -L https://github.com/jdh8/source-han-serif/raw/refs/heads/master/SourceHanSerifJP-Medium.otf -o ${FONT_DIR}/SourceHanSerifJP-Medium.otf
	@echo "Building font..."
	cd ${FONT_DIR} && ruby create-fonts.rb
	@echo "Moving built png files to project directory..."
	mv ${FONT_DIR}/*.png ./source/images
	@echo "done."

.PHONY: update-font-and-build
update-font-and-build: update-font build

.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -f ${TARGET_BINARY}
	rm -f ${FONT_DIR}/*.png
	rm -f ${FONT_DIR}/*.otf
	@echo "done."




