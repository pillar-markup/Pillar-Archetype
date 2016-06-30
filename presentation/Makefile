OUTPUTDIRECTORY = ./book-result
LATEXTEMPLATE = support/templates/presentation.beamer.template
HTMLTEMPLATE = support/templates/presentation.deckjs.template

presentation: $(OUTPUTDIRECTORY)/presentation.pdf $(OUTPUTDIRECTORY)/presentation.html

$(OUTPUTDIRECTORY)/%.tex.json: %.pillar
	./pillar export --to="Beamer" $<

$(OUTPUTDIRECTORY)/%.tex: $(OUTPUTDIRECTORY)/%.tex.json
	./mustache --data=$< --template=${LATEXTEMPLATE} > $@

$(OUTPUTDIRECTORY)/%.pdf: $(OUTPUTDIRECTORY)/%.tex
	latexmk -silent -outdir=${OUTPUTDIRECTORY} -use-make -pdf $<

$(OUTPUTDIRECTORY)/%.html.json: %.pillar
	./pillar export --to="DeckJS" $<

$(OUTPUTDIRECTORY)/%.html: $(OUTPUTDIRECTORY)/%.html.json
	./mustache --data=$< --template=${HTMLTEMPLATE} > $@
