MAIN = book
CHAPTERS = \
	Chapters/Chapter1/chapter1 \
	Chapters/Chapter2/chapter2

OUTPUTDIRECTORY = build
LATEXTEMPLATE = support/templates/main.latex.mustache
LATEXCHAPTERTEMPLATE = support/templates/chapter.latex.mustache
HTMLTEMPLATE = support/templates/html.mustache
HTMLCHAPTERTEMPLATE = $(HTMLTEMPLATE)

.DEFAULT_GOAL = help

.phony: all pdf html book pdfbook htmlbook chapters pdfchapters htmlchapters clean fullclean

all: pdf html ## Build everything in all formats
book: pdfbook htmlbook ## Full book only, all formats
chapters: pdfchapters htmlchapters ## Separate chapters, all formats

pdf: pdfbook pdfchapters ## Everything PDF
pdfbook: $(OUTPUTDIRECTORY)/$(MAIN).pdf
pdfchapters: $(CHAPTERS:%=$(OUTPUTDIRECTORY)/%.pdf)

html: htmlbook htmlchapters ## Everything HTML
htmlbook: $(OUTPUTDIRECTORY)/$(MAIN).html
htmlchapters: $(CHAPTERS:%=$(OUTPUTDIRECTORY)/%.html)

clean: prepare-clean ## Cleanup intermediate build products
	for f in $(addprefix $(OUTPUTDIRECTORY)/,$(MAIN) $(CHAPTERS)); do \
		latexmk -cd -f -c "$$f" ; \
		rm -f "$$f.tex" "$$f.tex.json" "$$f.html.json" "$$(dirname $$f)/root" ; \
	done

fullclean: ## Cleanup everything including final build products
	rm -fr ${OUTPUTDIRECTORY}

include support/makefiles/prepare.mk
include support/makefiles/epub.mk
include support/makefiles/help.mk

$(OUTPUTDIRECTORY)/%.tex.json: %.pillar prepare
	./pillar export --to="LaTeX" --outputDirectory=$(OUTPUTDIRECTORY) --outputFile=$< $<

$(OUTPUTDIRECTORY)/$(MAIN).tex: TEMPLATE = $(LATEXTEMPLATE)
$(CHAPTERS:%=$(OUTPUTDIRECTORY)/%.tex): TEMPLATE = $(LATEXCHAPTERTEMPLATE)
$(OUTPUTDIRECTORY)/%.tex: $(OUTPUTDIRECTORY)/%.tex.json $(TEMPLATE)
	./mustache --data=$< --template=$(TEMPLATE) > $@

$(OUTPUTDIRECTORY)/%.pdf: $(OUTPUTDIRECTORY)/%.tex
	latexmk -cd -use-make $<

$(OUTPUTDIRECTORY)/%.html.json: %.pillar prepare
	./pillar export --to="HTML" --outputDirectory=$(OUTPUTDIRECTORY) --outputFile=$< $<

$(OUTPUTDIRECTORY)/$(MAIN).html: TEMPLATE = $(HTMLTEMPLATE)
$(CHAPTERS:%=$(OUTPUTDIRECTORY)/%.html): TEMPLATE = $(HTMLCHAPTERTEMPLATE)
$(OUTPUTDIRECTORY)/%.html: $(OUTPUTDIRECTORY)/%.html.json $(TEMPLATE)
	./mustache --data=$< --template=$(TEMPLATE) > $@
