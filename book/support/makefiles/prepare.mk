.phony: prepare prepare-build prepare-clean download submodules

FIGURES := $(shell find . \
		-type f \
		-path '*/figures/*' \
		! -path '$(OUTPUTDIRECTORY)/*' \
		! -path './support/*' \
		-print)

# Install build tools & dependencies, create the build directory structure
prepare: submodules pillar mustache prepare-build

# git doesn't automatically update the contents of submodules
submodules:
	git submodule update --init --recursive

# wrapper scripts for pillar and mustache are created together from the pillar install script
pillar mustache: | download
download: ## Install Pharo VM & image for Pillar & Mustache
	wget --quiet --output-document=- "https://raw.githubusercontent.com/pillar-markup/pillar/master/download.sh" | bash -s $$*

# create & initialize output directory, mirroring stuff that has to match the
# repo hierarchy inside the output dir.
prepare-build: $(addprefix $(OUTPUTDIRECTORY)/, support gitHeadLocal.gin $(FIGURES))

# cleanup stuff created in this makefile
prepare-clean:
	rm -f $(addprefix $(OUTPUTDIRECTORY)/, support gitHeadLocal.gin)

$(OUTPUTDIRECTORY):
	mkdir -p $(OUTPUTDIRECTORY)

$(OUTPUTDIRECTORY)/support: $(OUTPUTDIRECTORY)
	ln -fs ../support $(OUTPUTDIRECTORY)

# extract versioning info for LaTeX
$(OUTPUTDIRECTORY)/gitHeadLocal.gin: $(OUTPUTDIRECTORY) | submodules
	support/latex/sbabook/gitinfo2.sh > $@

# this is making hardlinks (symlinks are verbose with absolute paths and
# computing relative paths is… complicated)
$(FIGURES:%=$(OUTPUTDIRECTORY)/%): $(OUTPUTDIRECTORY)/% : %
	@mkdir -p $(dir $@)
	ln -f $< $@
