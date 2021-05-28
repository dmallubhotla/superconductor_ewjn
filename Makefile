### Build tools
#
LATEXMK := latexmk -pdflatex="luahblatex %O %S" -pdf -dvi- -ps- -quiet -logfilewarninglist
WS := wolframscript -f

### Directory variables
#
PDF_DIR := pdfs
FIG_DIR := figures
CALC_DIR := calc

### Here we go
#
OUT_PDF:= $(PDF_DIR)/superconductor_ewjn.pdf

.PHONY: all
all: $(OUT_PDF)

### How we do that
#

## setup main pdf deps as variable that subdirs can add to
MAIN_PDF_DEPS := bibliography.bib

## Defining common directory recipes
$(PDF_DIR):
	mkdir $(PDF_DIR)
$(FIG_DIR):
	mkdir -p $(FIG_DIR)
$(CALC_DIR):
	mkdir -p $(CALC_DIR)

## Figures
#

FIGURES := 
## Making main.pdf and other pdfs
#
$(PDF_DIR)/superconductor_ewjn.pdf: superconductor_ewjn.tex $(MAIN_PDF_DEPS) | $(PDF_DIR) $(FIGURES)
	$(LATEXMK) $(<F)
	cp $(@F) $@

### Convenience scripts for tidying tex
.PHONY: declutter
declutter:
	@rm -f *.tdo
	@rm -f *.run.xml
	@rm -f *.bbl

.PHONY: tidy
tidy: declutter
	@latexmk -c
.PHONY: clean
clean: declutter
	rm -rf $(PDF_DIR)
	@latexmk -C
