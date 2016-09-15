MAIN = book
OUTPUTDIRECTORY = ./book-result
LATEXTEMPLATE = ./support/templates/latex.mustache.template
HTMLTEMPLATE = ./support/templates/html.mustache.template

.DEFAULT_GOAL = all

.phony: all book pdf html clean fullclean

all book: pdf html
pdf: $(OUTPUTDIRECTORY)/$(MAIN).pdf
html: $(OUTPUTDIRECTORY)/$(MAIN).html

clean:
	latexmk -cd -C $(OUTPUTDIRECTORY)/$(MAIN) || true

fullclean:
	rm -fr ${OUTPUTDIRECTORY}

include ./support/makefiles/prepare.mk
include ./support/makefiles/epub.mk

$(OUTPUTDIRECTORY)/%.tex.json: %.pillar prepare
	./pillar export --to="LaTeX" --outputDirectory=$(OUTPUTDIRECTORY) --outputFile=$< $<

$(OUTPUTDIRECTORY)/%.tex: $(OUTPUTDIRECTORY)/%.tex.json
	./mustache --data=$< --template=${LATEXTEMPLATE} > $@

$(OUTPUTDIRECTORY)/%.pdf: $(OUTPUTDIRECTORY)/%.tex
	latexmk -cd -use-make $<

$(OUTPUTDIRECTORY)/%.html.json: %.pillar prepare
	./pillar export --to="HTML" --outputDirectory=$(OUTPUTDIRECTORY) --outputFile=$< $<

$(OUTPUTDIRECTORY)/%.html: $(OUTPUTDIRECTORY)/%.html.json
	./mustache --data=$< --template=${HTMLTEMPLATE} > $@
