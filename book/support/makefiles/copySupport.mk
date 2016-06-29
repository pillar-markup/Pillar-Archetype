copySupport:
	find . -type d -wholename "*/figures" -exec cp {} --parents -r ${OUTPUTDIRECTORY} \;
	cp -r support/ ${OUTPUTDIRECTORY}
	cp .latexmkrc ${OUTPUTDIRECTORY}
