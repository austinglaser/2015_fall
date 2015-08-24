################################################################################
# Notes makefile                                                               #
################################################################################

# Root directory is the one this makefile resides in
ROOT_DIR	:= $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
MD_DIR		:= $(ROOT_DIR)/md
HTML_DIR	:= $(ROOT_DIR)/html

MD_FILES	:= $(wildcard $(MD_DIR)/*.md)
HTML_FILES	:= $(addprefix $(HTML_DIR)/,$(notdir $(MD_FILES:.md=.html)))

all: $(HTML_FILES)

$(HTML_FILES): $(HTML_DIR)/%.html: $(MD_DIR)/%.md | $(HTML_DIR)
	pandoc -f markdown -t html $< -o $@

$(HTML_DIR):
	mkdir -p $(HTML_DIR)

.PHONY: clean
clean:
	rm -rf $(HTML_DIR)
