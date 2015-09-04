################################################################################
# Notes makefile                                                               #
################################################################################

# Root directory is the one this makefile resides in
ROOT_DIR	:= $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
MD_DIR		:= $(ROOT_DIR)/md
HTML_DIR	:= $(ROOT_DIR)/html

INDEX_HEADING	:= WRTG 3030 Notes
INDEX		:= $(ROOT_DIR)/index.html

MD_FILES	:= $(wildcard $(MD_DIR)/*.md)
HTML_FILES	:= $(addprefix $(HTML_DIR)/,$(notdir $(MD_FILES:.md=.html)))

all: $(HTML_FILES) $(INDEX)

$(HTML_FILES): $(HTML_DIR)/%.html: $(MD_DIR)/%.md | $(HTML_DIR)
	@echo "Converting $(notdir $<)"
	@pandoc -f markdown -t html $< -o $@

$(HTML_DIR):
	@mkdir -p $(HTML_DIR)

$(INDEX): $(HTML_FILES)
	@echo "Creating $(notdir $@)"
	@echo "<h1 id=\"course\">$(INDEX_HEADING)</h1>"			> $(INDEX)
	@for FILE in $(HTML_FILES) ; do \
		echo -n "<p>"						>> $(INDEX) ; \
		echo -n "<a href=file://$$FILE>"			>> $(INDEX) ; \
		echo -n $$(head -n 1 $$FILE) | sed -e 's/<[^>]*>//g'	>> $(INDEX) ; \
		echo -n "</a>"						>> $(INDEX) ; \
		echo "</p>"						>> $(INDEX) ; \
	done

.PHONY: clean
clean:
	rm -rf $(HTML_DIR) $(INDEX)
