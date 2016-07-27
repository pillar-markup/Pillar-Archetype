OUTPUTDIRECTORY = ./book-result
HTMLTEMPLATE = support/templates/welcome.html.template

welcome: welcome.html

$(OUTPUTDIRECTORY)/%.html.json: %.pillar
	./pillar export --to=html --outputDirectory=$(OUTPUTDIRECTORY) $<

$(OUTPUTDIRECTORY)/%.html: $(OUTPUTDIRECTORY)/%.html.json
	./mustache --data=$< --template=${HTMLTEMPLATE} > $@
