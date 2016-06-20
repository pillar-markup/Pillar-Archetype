OUTPUTDIRECTORY = ./book-result
LATEXTEMPLATE = ./support/templates/template.latex.mustache
HTMLTEMPLATE = ./support/templates/template.html.mustache

EPUBMAKEFILE = ./epub-Makefile/Makefile

init:
	mkdir -p ${OUTPUTDIRECTORY}

include $(EPUBMAKEFILE)

#Tex compilation
$(OUTPUTDIRECTORY)/%.tex.json: %.pillar
	./pillar export --to="latex" --path="${<}" $<

$(OUTPUTDIRECTORY)/%.tex: $(OUTPUTDIRECTORY)/%.tex.json
	./mustache --data=$< --template=${LATEXTEMPLATE} > $@

$(OUTPUTDIRECTORY)/%.pdf: $(OUTPUTDIRECTORY)/%.tex
	latexmk -outdir=${OUTPUTDIRECTORY} -use-make -pdf ${OUTPUTDIRECTORY}/$<
	make cleanBookResult

#HTML compilation
$(OUTPUTDIRECTORY)/%.html.json: %.pillar
	./pillar export --to="html" --path="${<}" $<

$(OUTPUTDIRECTORY)/%.html: $(OUTPUTDIRECTORY)/%.html.json
	./mustache --data=$< --template=${HTMLTEMPLATE} > $@

#cleaning
cleanWorkspace: clean
	rm -r ${OUTPUTDIRECTORY} || true

clean:
	rm -f *.aux *.log *.fls *.fdb_latexmk *.lof EnterprisePharo.out *.toc *.listing

cleanBookResult:
	rm ${OUTPUTDIRECTORY}/*.aux ${OUTPUTDIRECTORY}/*.fls ${OUTPUTDIRECTORY}/*.log ${OUTPUTDIRECTORY}/*.fdb_latexmk
