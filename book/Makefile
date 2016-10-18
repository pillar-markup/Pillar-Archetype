MAIN = book
CHAPTERS = \
	Chapters/Chapter1/chapter1 \
	Chapters/Chapter2/chapter2

OUTPUTDIRECTORY = ./build
LATEXTEMPLATE = ./support/templates/main.latex.mustache
LATEXCHAPTERTEMPLATE = ./support/templates/chapter.latex.mustache
HTMLTEMPLATE = ./support/templates/html.mustache
HTMLCHAPTERTEMPLATE = $(HTMLTEMPLATE)

.DEFAULT_GOAL = help

.phony: all book pdf pdfchapters html htmlchapters clean fullclean

all: book chapters ## Build the book in all formats
book: pdf html
chapters: pdfchapters htmlchapters

pdf: $(OUTPUTDIRECTORY)/$(MAIN).pdf ## Build the PDF book
pdfchapters: $(CHAPTERS:%=$(OUTPUTDIRECTORY)/%.pdf) ## Build the PDF chapters

html: $(OUTPUTDIRECTORY)/$(MAIN).html ## Build the HTML book
htmlchapters: $(CHAPTERS:%=$(OUTPUTDIRECTORY)/%.html) ## Build the HTML chapters

clean: ## Cleanup intermediate build products
	for f in $(addprefix $(OUTPUTDIRECTORY)/,$(MAIN) $(CHAPTERS)); do \
		latexmk -cd -c "$$f" ; \
		rm -f "$$f.tex" "$$f.tex.json" "$$f.html.json" ; \
	done

fullclean: ## Cleanup everything including final build products
	rm -fr ${OUTPUTDIRECTORY}

include ./support/makefiles/prepare.mk
include ./support/makefiles/epub.mk
include ./support/makefiles/help.mk

$(OUTPUTDIRECTORY)/%.tex.json: %.pillar prepare
	./pillar export --to="LaTeX" --outputDirectory=$(OUTPUTDIRECTORY) --outputFile=$< $<

$(OUTPUTDIRECTORY)/$(MAIN).tex: $(OUTPUTDIRECTORY)/%.tex: $(OUTPUTDIRECTORY)/%.tex.json $(LATEXTEMPLATE)
	./mustache --data=$< --template=$(LATEXTEMPLATE) > $@
$(CHAPTERS:%=$(OUTPUTDIRECTORY)/%.tex): $(OUTPUTDIRECTORY)/%.tex: $(OUTPUTDIRECTORY)/%.tex.json $(LATEXCHAPTERTEMPLATE)
	./mustache --data=$< --template=$(LATEXCHAPTERTEMPLATE) > $@

$(OUTPUTDIRECTORY)/%.pdf: $(OUTPUTDIRECTORY)/%.tex
	latexmk -cd -use-make $<

$(OUTPUTDIRECTORY)/%.html.json: %.pillar prepare
	./pillar export --to="HTML" --outputDirectory=$(OUTPUTDIRECTORY) --outputFile=$< $<

$(OUTPUTDIRECTORY)/$(MAIN).html: $(OUTPUTDIRECTORY)/%.html: $(OUTPUTDIRECTORY)/%.html.json $(HTMLTEMPLATE)
	./mustache --data=$< --template=$(HTMLTEMPLATE) > $@
$(CHAPTERS:%=$(OUTPUTDIRECTORY)/%.html): $(OUTPUTDIRECTORY)/%.html: $(OUTPUTDIRECTORY)/%.html.json $(HTMLCHAPTERTEMPLATE)
	./mustache --data=$< --template=$(HTMLCHAPTERTEMPLATE) > $@
