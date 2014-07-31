FILE = main
DIAS := $(subst .dia,.pdf,$(wildcard img/dia/*.dia))
TIFS := $(subst .tif,.png,$(wildcard img/tif/*.tif))
ODSS := $(subst .ods,.pdf,$(wildcard ods/*.ods))
SVGS := $(subst .svg,.pdf,$(wildcard img/svg/*.svg))

all: show

show: $(FILE).pdf
	atril $+

$(FILE).pdf: $(FILE).tex $(wildcard *.tex) $(DIAS) $(TIFS) $(PLTS) $(ODSS) $(SVGS) vc.tex
	rubber -W all --pdf $<

.PHONY: vc.tex
vc.tex:
	./vc -m

img/tif/%.png: img/tif/%.tif
	tifftopnm $< | pnmtopng > $@

img/dia/%.eps: img/dia/%.dia
	dia $< -t eps-pango -e $@
	
img/dia/%.pdf: img/dia/%.eps
	epstopdf $<
	/bin/rm $<

img/svg/%.pdf: img/svg/%.svg
	inkscape -f $< -A $@

ods/%.pdf: ods/%.ods
	libreoffice --headless --nologo --invisible --convert-to pdf:writer_pdf_Export --outdir ods/ $<

clean:
	rubber --clean main.tex
	/bin/rm -rf $(FILEA).pdf \
		$(FILE).pdf \
		*.aux \
		*.log \
		*.ist \
		*.acn \
		*.glo \
		*.idx \
		$(FILE).out \
		$(FILE).tex~ \
		$(FILE).bbl \
		$(FILE).bib \
		$(FILE).blg \
		$(FILE).toc \
		$(FILE).lot \
		$(FILE).lof \
		$(FILE).acr \
		$(FILE).alg \
		$(FILE).ilg \
		$(FILE).ind \
		Makefile~ \
		img/dia/*.pdf \
		img/dia/*.dia~ \
		img/tif/*.png \
		img/svg/*.pdf \
		main-blx.bib \
		vc.tex \
		notes.pdf \
		*.snm \
		*.nav \
		*-blx.bib \
		$(FILE).run.xml \
		*.vrb
		
