.PHONY: doc examples ctan

EXAMPLES = contributor-credits-example contributor-credits-example-granular contributor-credits-example-text
PDFLATEX = pdflatex -no-shell-escape -interaction=nonstopmode -halt-on-error -output-directory=build

doc:
	mkdir -p build
	$(PDFLATEX) contributor-credits-doc.tex
	$(PDFLATEX) contributor-credits-doc.tex

examples:
	mkdir -p build
	for f in $(EXAMPLES); do $(PDFLATEX) $$f.tex || exit 1; done

ctan: doc examples
	rm -rf build/contributor-credits
	mkdir -p build/contributor-credits/assets
	cp contributor-credits.sty contributor-credits-doc.tex README.md LICENSE.md Makefile CITATION.cff build/contributor-credits/
	for f in $(EXAMPLES); do cp $$f.tex build/$$f.pdf build/contributor-credits/; done
	cp assets/*.png build/contributor-credits/assets/
	cp build/contributor-credits-doc.pdf build/contributor-credits/
	rm -f build/contributor-credits.zip
	cd build && zip -r contributor-credits.zip contributor-credits
