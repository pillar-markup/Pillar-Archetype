.phony: prepare download

$(OUTPUTDIRECTORY):
	mkdir -p $(OUTPUTDIRECTORY)

prepare: $(OUTPUTDIRECTORY) pillar mustache
	git submodule update --init
	find . -type d \
		\( -wholename $(OUTPUTDIRECTORY) -or -wholename ./support \) -prune \
		-or -name figures -prune \
		-print \
		-exec mkdir -p $(OUTPUTDIRECTORY)/{} \; \
		-exec rsync --recursive --relative {}/ $(OUTPUTDIRECTORY) \;
	ln -fs ../support $(OUTPUTDIRECTORY)/support

pillar mustache: | download
download:
	wget --quiet --output-document=- "https://raw.githubusercontent.com/pillar-markup/pillar/master/download.sh" | bash -s $$*
