.PHONY: doc ctan

doc:
	mkdir -p build
	pdflatex -no-shell-escape -interaction=nonstopmode -halt-on-error -output-directory=build credits-doc.tex
	pdflatex -no-shell-escape -interaction=nonstopmode -halt-on-error -output-directory=build credits-doc.tex

ctan: doc
	rm -rf build/credits
	mkdir -p build/credits/assets
	cp credits.sty credits-doc.tex README.md LICENSE.md Makefile CITATION.cff example.tex example_granular.tex example_text.tex build/credits/
	cp assets/*.png build/credits/assets/
	cp build/credits-doc.pdf build/credits/
	rm -f build/credits.zip
	cd build && zip -r credits.zip credits
