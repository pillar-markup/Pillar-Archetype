OUTPUTDIRECTORY = ./book-result
HTMLTEMPLATE = support/templates/welcome.html.template

welcome: $(OUTPUTDIRECTORY)/welcome.html

$(OUTPUTDIRECTORY)/%.html.json: %.pillar
	./pillar export --to=html --path="${<}" --outputDirectory=$(OUTPUTDIRECTORY) $<

$(OUTPUTDIRECTORY)/%.html: $(OUTPUTDIRECTORY)/%.html.json
	./mustache --data=$< --template=${HTMLTEMPLATE} > $@
