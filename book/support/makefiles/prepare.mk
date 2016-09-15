.phony: prepare

$(OUTPUTDIRECTORY):
	mkdir -p $(OUTPUTDIRECTORY)

prepare: $(OUTPUTDIRECTORY)
	git submodule update --init
	find . -type d \
		\( -wholename $(OUTPUTDIRECTORY) -or -wholename ./support \) -prune \
		-or -name figures -prune \
		-print \
		-exec mkdir -p $(OUTPUTDIRECTORY)/{} \; \
		-exec rsync --recursive --relative {}/ $(OUTPUTDIRECTORY) \;
	ln -fs ../support $(OUTPUTDIRECTORY)/support
