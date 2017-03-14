-include $(wildcard *.d)

%.pdf: %.tex
	latexmk -pdflua -use-make \
		-latexoption="--file-line-error --halt-on-error" \
		-deps-out="$*.d" \
		$<
