MANDOC=		mandoc
MANDOCFLAGS+=	-Thtml
MANDOCFLAGS+=	-Oman="%N.%S;https://man.openbsd.org/%N.%S,style=mandoc.css"

BSDSRCDIR=	/usr/src

MAN=	yank.1
OBJ!=	for f in ${MAN}; do echo "${.CURDIR}/$$f.html"; done

.BEGIN:
.for f in ${MAN}
	git show master:$f >$f
.endfor

all: ${OBJ} mandoc.css
	cp ${.CURDIR}/yank.1.html ${.CURDIR}/index.html

.for f in ${MAN}
${.CURDIR}/$f.html: $f
	${MANDOC} ${MANDOCFLAGS} $f >${.CURDIR}/$f.html
.endfor

mandoc.css: ${BSDSRCDIR}/usr.bin/mandoc/mandoc.css
	cp ${BSDSRCDIR}/usr.bin/mandoc/mandoc.css ${.CURDIR}/mandoc.css
.PHONY: mandoc.css
