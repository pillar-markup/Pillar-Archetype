#!/bin/bash

OUTPUTDIRECTORY = ./book-result

XHTMLTEMPLATE = ./support/templates/template.xhtml.mustache
NAVMENUTEMPLATE = ./support/templates/template.nav.mustache
TOCMENUTEMPLATE = ./support/templates/template.toc.mustache
CONTENTOPFTEMPLATE = ./support/templates/template.contentopf.mustache
TITLEPAGETEMPLATE = ./support/templates/template.title_page.mustache
CONTAINERTEMPLATE = ./support/templates/template.container.mustache

.SECONDARY:

init:
	mkdir -p ${OUTPUTDIRECTORY}

#EPUB
$(OUTPUTDIRECTORY)/%.epub: $(OUTPUTDIRECTORY)/%.content.opf
	mkdir -p $(OUTPUTDIRECTORY)/Ibook
	cp ./support/ePub_support/Mimetype $(OUTPUTDIRECTORY)/Ibook/
	cp -r ./support/ePub_support/META-INF $(OUTPUTDIRECTORY)/Ibook/
	cp ./support/style/stylesheet.css $(OUTPUTDIRECTORY)/Ibook/
	mv $(OUTPUTDIRECTORY)/$*.xhtml $(OUTPUTDIRECTORY)/Ibook/chapter.xhtml
	#Move all the file begining by the outputFile name
	echo $*
	bash ./support/scripts/moveFilesToIbook.sh $* $(OUTPUTDIRECTORY)/
	cd $(OUTPUTDIRECTORY)/Ibook/; zip -r ../tmp.zip *
	mv $(OUTPUTDIRECTORY)/tmp.zip $@
	rm -r $(OUTPUTDIRECTORY)/Ibook

#Navigation Menus
$(OUTPUTDIRECTORY)/%.nav.xhtml.json: %.pillar
	./pillar export --to="navmenu" --path="${<}" $<

$(OUTPUTDIRECTORY)/%.nav.xhtml: $(OUTPUTDIRECTORY)/%.nav.xhtml.json
	./mustache --data=$< --template=$(NAVMENUTEMPLATE) > $@

$(OUTPUTDIRECTORY)/%.toc.ncx.json: %.pillar
	./pillar export --to="tocmenu" --path="${<}" $<

$(OUTPUTDIRECTORY)/%.toc.ncx: $(OUTPUTDIRECTORY)/%.toc.ncx.json
	./mustache --data=$< --template=$(TOCMENUTEMPLATE) > $@

#Content.opf & title_page.xhtml
$(OUTPUTDIRECTORY)/%.content.opf: $(OUTPUTDIRECTORY)/%.xhtml $(OUTPUTDIRECTORY)/%.toc.ncx $(OUTPUTDIRECTORY)/%.nav.xhtml $(OUTPUTDIRECTORY)/%.title_page.xhtml
	./mustache --data=$<.json --template=$(CONTENTOPFTEMPLATE) > $@

$(OUTPUTDIRECTORY)/%.title_page.xhtml: $(OUTPUTDIRECTORY)/%.xhtml
	./mustache --data=$<.json --template=$(TITLEPAGETEMPLATE) > $@

#Chapter compilation
$(OUTPUTDIRECTORY)/%.xhtml.json: %.pillar
	./pillar export --to="xhtml" --path="${<}" $<

$(OUTPUTDIRECTORY)/%.xhtml: $(OUTPUTDIRECTORY)/%.xhtml.json
	./mustache --data=$< --template=$(XHTMLTEMPLATE) > $@

#Cleaning
cleanWorkspace: clean
	rm -r ${OUTPUTDIRECTORY} || true
	rm -f *.pdf

clean:
	rm -f *.aux *.log *.fls *.fdb_latexmk *.lof EnterprisePharo.out *.toc *.listing

cleanBookResult:
	rm ${OUTPUTDIRECTORY}/*.aux ${OUTPUTDIRECTORY}/*.fls ${OUTPUTDIRECTORY}/*.log ${OUTPUTDIRECTORY}/*.fdb_latexmk
