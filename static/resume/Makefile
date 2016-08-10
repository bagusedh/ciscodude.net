SRCS		= theodore.md
PDFOBJS		= $(SRCS:.md=.pdf)
HTMLOBJS	= $(SRCS:.md=.html)
MD2RESUME	= ~/dev/github/markdown-resume/bin/md2resume

.PHONY: all html pdf 

all: $(HTMLOBJS) $(PDFOBJS)
	@echo html and PDF generated

%.pdf:	%.md
	$(MD2RESUME) pdf --template swissen $< .
	mv theodore.pdf theodorebaschak_resume.pdf

pdf: $(PDFOBJS)

%.html: %.md
	$(MD2RESUME) html --template swissen $< .
	mv theodore.html index.html

html: $(HTMLOBJS)
