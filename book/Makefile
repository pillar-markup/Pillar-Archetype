OUTPUTDIRECTORY = ./book-result
DIRECTORIES = Teapot WebApp Zinc-Encoding-Meta Zinc-HTTP-Client Zinc-HTTP-Server\
							WebSockets NeoCSV NeoJSON STON Fuel Voyage Mustache RenoirST PillarChap\
							Artefact DeploymentWeb
LATEXTEMPLATE = ./support/templates/chapter.latex.template
HTMLTEMPLATE = ./support/templates/chapter.html.template
ASCIIDOCTEMPLATE = ./support/templates/chapter.asciidoc.template

init:
	mkdir -p ${OUTPUTDIRECTORY}

tex: ./book-result/Teapot/Teapot.tex \
			./book-result/WebApp/WebApp.tex \
			./book-result/Zinc-Encoding-Meta/Zinc-Encoding-Meta.tex \
			./book-result/Zinc-HTTP-Client/Zinc-HTTP-Client.tex \
			./book-result/Zinc-HTTP-Server/Zinc-HTTP-Server.tex \
			./book-result/WebSockets/WebSockets.tex \
			./book-result/NeoCSV/NeoCSV.tex \
			./book-result/NeoJSON/NeoJSON.tex \
			./book-result/STON/STON.tex \
			./book-result/Fuel/Fuel.tex \
			./book-result/Voyage/Voyage.tex \
			./book-result/Mustache/Mustache.tex \
			./book-result/RenoirST/RenoirST.tex \
			./book-result/PillarChap/Pillar.tex \
			./book-result/Artefact/Artefact.tex \
			./book-result/DeploymentWeb/DeployForProduction.tex

html: Teapot/Teapot.html \
			WebApp/WebApp.html \
			Zinc-Encoding-Meta/Zinc-Encoding-Meta.html \
			Zinc-HTTP-Client/Zinc-HTTP-Client.html \
			Zinc-HTTP-Server/Zinc-HTTP-Server.html \
			WebSockets/WebSockets.html \
			NeoCSV/NeoCSV.html \
			NeoJSON/NeoJSON.html \
			STON/STON.html \
			Fuel/Fuel.html \
			Voyage/Voyage.html \
			Mustache/Mustache.html \
			RenoirST/RenoirST.html \
			PillarChap/Pillar.html \
			Artefact/Artefact.html \
			DeploymentWeb/DeployForProduction.html

book: ./book-result/EnterprisePharo.pdf

$(OUTPUTDIRECTORY)/EnterprisePharo.pdf: EnterprisePharo.tex tex
	cd $(OUTPUTDIRECTORY)/ && latexmk -pdf ../$<
	make cleanBookResult

links:
	./makelinks.sh ($(DIRECTORIES))

#Epub
$(OUTPUTDIRECTORY)/%.epub: $(OUTPUTDIRECTORY)/%.html
	pandoc -f html -t epub $< -o $@

#asciidoc compilation
$(OUTPUTDIRECTORY)/%.asciidoc.json: %.pillar
	./pillar export --to="asciidoc" --path="${<}" $<

$(OUTPUTDIRECTORY)/%.asciidoc: $(OUTPUTDIRECTORY)/%.asciidoc.json
	./mustache --data=$< --template=$(ASCIIDOCTEMPLATE) > $@

#Tex compilation
$(OUTPUTDIRECTORY)/%.tex.json: %.pillar
	./pillar export --to="latex" --path="${<}" $<

$(OUTPUTDIRECTORY)/%.tex: $(OUTPUTDIRECTORY)/%.tex.json
	./mustache --data=$< --template=${LATEXTEMPLATE} > $@

$(OUTPUTDIRECTORY)/%.pdf: $(OUTPUTDIRECTORY)%.tex #$(shell ./pillar imagedepend `echo $$< | cut -d '.' -f1`.pillar)
	echo $^
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
	rm -f *.pdf

clean:
	rm -f *.aux *.log *.fls *.fdb_latexmk *.lof EnterprisePharo.out *.toc *.listing

cleanBookResult:
	rm ${OUTPUTDIRECTORY}/*.aux ${OUTPUTDIRECTORY}/*.fls ${OUTPUTDIRECTORY}/*.log ${OUTPUTDIRECTORY}/*.fdb_latexmk
