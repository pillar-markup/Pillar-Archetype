copySupport: initDir
	find . -type d \
		-path $(OUTPUTDIRECTORY) -prune \
		-o -wholename "*/figures" \
		-exec mkdir -p ${OUTPUTDIRECTORY}/{} \; \
		-exec rsync -rR {} ${OUTPUTDIRECTORY}/ \;
	cp -R support ${OUTPUTDIRECTORY}
	cp latexmkrc ${OUTPUTDIRECTORY}
