.PHONY: doc ctan

doc:
	mkdir -p build
	pdflatex -no-shell-escape -interaction=nonstopmode -halt-on-error -output-directory=build contributor-credits-doc.tex
	pdflatex -no-shell-escape -interaction=nonstopmode -halt-on-error -output-directory=build contributor-credits-doc.tex

ctan: doc
	rm -rf build/contributor-credits
	mkdir -p build/contributor-credits/assets
	cp contributor-credits.sty contributor-credits-doc.tex README.md LICENSE.md Makefile CITATION.cff contributor-credits-example.tex contributor-credits-example-granular.tex contributor-credits-example-text.tex build/contributor-credits/
	cp assets/*.png build/contributor-credits/assets/
	cp build/contributor-credits-doc.pdf build/contributor-credits/
	rm -f build/contributor-credits.zip
	cd build && zip -r contributor-credits.zip contributor-credits
