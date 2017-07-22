NAME=gsharp

TEXFILES=$(NAME).tex $(shell ./tex-dependencies $(NAME).tex)
BIBFILES=$(NAME).bib
PSTEX_T=$(shell ./strip-dependence inputfig $(TEXFILES))
PDF_T=$(shell ./strip-dependence inputfig $(TEXFILES))
VERBATIM=$(shell ./strip-dependence verbatimtabinput $(TEXFILES))
CODEFILES=$(shell ./strip-dependence inputcode $(TEXFILES))
PDF=$(subst .pdf_t,.pdf,$(PDF_T))

all : $(NAME).pdf

%.pdf: %.fig
	fig2dev -Lpdftex -m 0.75  $< $@

%.pdf_t: %.fig %.pdf
	fig2dev -Lpdftex_t -m 0.75 -p $(basename $<).pdf $< $@

$(NAME).pdf: $(TEXFILES) $(PDF) $(PDF_T) $(VERBATIM) $(CODEFILES) $(BIBFILES)
	pdflatex $<
	bibtex $(NAME)
	pdflatex $<
	pdflatex $<

clean:
	rm -f *.aux *.log *.pdf *~

spotless: clean
	rm -f *.dvi *.pstex *.pstex_t *.toc *.idx *.ilg *.ind *.bbl

