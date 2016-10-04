.phony: prepare download submodules figures

# Install build tools & dependencies, create the build directory structure
prepare: submodules pillar mustache $(OUTPUTDIRECTORY) figures $(OUTPUTDIRECTORY)/support


$(OUTPUTDIRECTORY):
	mkdir -p $(OUTPUTDIRECTORY)

$(OUTPUTDIRECTORY)/support: $(OUTPUTDIRECTORY)
	ln -fs ../support $(OUTPUTDIRECTORY)

# wrapper scripts for pillar and mustache are created together from the pillar install script
pillar mustache: | download
download: ## Install Pharo VM & image for Pillar & Mustache
	wget --quiet --output-document=- "https://raw.githubusercontent.com/pillar-markup/pillar/master/download.sh" | bash -s $$*

# git doesn't automatically update the contents of submodules
submodules:
	git submodule update --init --recursive

# mirror figure directories, since they have to match the repo hierarchy
# symlinking them would be nice, but rsync is easier
figures:
	find . -type d \
		\( -wholename $(OUTPUTDIRECTORY) -or -wholename ./support \) -prune \
		-or -name figures -prune \
		-print \
		-exec mkdir -p $(OUTPUTDIRECTORY)/{} \; \
		-exec rsync --recursive --relative {}/ $(OUTPUTDIRECTORY) \;
