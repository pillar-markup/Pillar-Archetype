OUTPUTDIRECTORY = ./book-result
LATEXTEMPLATE = ./support/templates/latex.mustache.template
HTMLTEMPLATE = ./support/templates/html.mustache.template

EPUBMAKEFILE = ./support/makefiles/epub.mk

include $(EPUBMAKEFILE)
include ./support/makefiles/copySupport.mk

#Tex compilation
$(OUTPUTDIRECTORY)/%.tex.json: %.pillar copySupport
	./pillar export --to="LaTeX" --path="${<}" $<

$(OUTPUTDIRECTORY)/%.tex: $(OUTPUTDIRECTORY)/%.tex.json
	./mustache --data=$< --template=${LATEXTEMPLATE} > $@

$(OUTPUTDIRECTORY)/%.pdf: $(OUTPUTDIRECTORY)/%.tex
	latexmk -outdir=${OUTPUTDIRECTORY} -use-make -pdf ${OUTPUTDIRECTORY}/$<
	make cleanBookResult

#HTML compilation
$(OUTPUTDIRECTORY)/%.html.json: %.pillar copySupport
	./pillar export --to="HTML" --path="${<}" $<

$(OUTPUTDIRECTORY)/%.html: $(OUTPUTDIRECTORY)/%.html.json
	./mustache --data=$< --template=${HTMLTEMPLATE} > $@

#cleaning
cleanWorkspace: clean
	rm -r ${OUTPUTDIRECTORY} || true

clean:
	rm -f *.aux *.log *.fls *.fdb_latexmk *.lof EnterprisePharo.out *.toc *.listing

cleanBookResult:
	rm ${OUTPUTDIRECTORY}/*.aux ${OUTPUTDIRECTORY}/*.fls ${OUTPUTDIRECTORY}/*.log ${OUTPUTDIRECTORY}/*.fdb_latexmk
