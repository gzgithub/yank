MANDOC=		mandoc
MANDOCFLAGS=	-Thtml -Oman=/yank/%N.%S,style=mandoc.css

BSDSRCDIR=	/usr/src

all: index.html mandoc.css

index.html:
	git show master:yank.1 | ${MANDOC} ${MANDOCFLAGS} \
		>${.CURDIR}/index.html
.PHONY: index.html

mandoc.css: ${BSDSRCDIR}/usr.bin/mandoc/mandoc.css
	cp ${BSDSRCDIR}/usr.bin/mandoc/mandoc.css ${.CURDIR}/mandoc.css
