# Some shell magic to auto-document the main targets. To have a target appear in
# the output, add a short, one-line comment with a double ## on the same line as
# the target.
#
# See http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

.phony: help

help: ## Describe the main targets (this list)
	@echo "Main targets you can build:"
	@awk -F ':|## *' \
		'/^[^\t].+:.*##/ {\
			printf "  \033[36m%s\033[0m\t%s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) \
	| column -s $$'\t' -t
	@echo "Combined format+volume targets are also defined: pdfbook, htmlchapters…"
	@echo "To make a single specific file/format, ask for it explicitly:"
	@echo "  make $(OUTPUTDIRECTORY)/$(firstword $(CHAPTERS)).pdf"
