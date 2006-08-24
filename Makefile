BOOK_NAME=lkn

###################################
# book section

BOOK_SRC	:=	book.xml

CHAP_SRC	:= 	ch01.xml	\
			ch02.xml	\
			ch03.xml	\
			ch04.xml	\
			ch05.xml	\
			ch06.xml	\
			ch07.xml	\
			ch08.xml	\
			ch09.xml	\
			ch10.xml	\
			ch11.xml	\
			ch12.xml	\
			ch13.xml	\
			appa.xml	\
			appb.xml	\
			appc.xml	\
			appd.xml

all:
	@echo "need to tell me what to do"
	@echo "options are: clean check bookcheck html bookhtml"

clean:
	-rm *.html

check:
	xwf $(CHAP_SRC)

bookcheck:
	xval $(BOOK_SRC)

html:
	db2h $(CHAP_SRC)

bookhtml:
	db2h $(BOOK_SRC)


testbookcheck:
	xmllint --xinclude  --postvalid --noout test_book.xml

testchaptercheck:
	xmllint --dtdvalid "http://www.oasis-open.org/docbook/xml/4.4/docbookx.dtd" --noout $(FILES)



VERSION=$(shell date "+%Y_%m_%d"| awk '{print $$1}')

RELEASE_NAME=$(BOOK_NAME)-$(VERSION)
HTML_NAME=$(BOOK_NAME)-html-$(VERSION)
FIGURE_NAME=$(BOOK_NAME)-figures-$(VERSION)

FIGURESFILES = $(shell find . \( -not -name '.' \) -print | egrep -v '(BitKeeper|SCCS)' | grep -v "\.tar\.gz" | grep -v "\.dia" | grep figures | sort ) 
#HTMLFILES = $(shell find . \( -not -name '.' \) -print | egrep -v '(BitKeeper|SCCS|.git)' | grep -v "\.tar\.gz" | grep -v "\.dia" | grep html | sort )
IMAGEFILES = $(shell find -type f -name *png | sort)
HTMLFILES = $(shell ls *.html | sort )

distdir := $(RELEASE_NAME)
srcdir = .
release: clean
	git-tar-tree HEAD $(RELEASE_NAME) | gzip -9v > $(RELEASE_NAME).tar.gz
	@echo "Built $(RELEASE_NAME).tar.gz"

figure_release: clean
	@echo $(FIGURESFILES)
	#cd figures
	@-rm -rf $(distdir)
	@mkdir $(distdir)
	@-chmod 777 $(distdir)
	@for file in $(FIGURESFILES); do		\
		if test -d $$file; then			\
			mkdir $(distdir)/$$file;	\
		else					\
			cp -p $$file $(distdir)/$$file;	\
		fi;					\
	done
	@tar -c $(distdir) | gzip -9 > $(FIGURE_NAME).tar.gz
	@rm -rf $(distdir)
	@echo "Built $(FIGURE_NAME).tar.gz"

html_release:	bookhtml
	@echo $(HTMLFILES) $(IMAGEFILES)
	@-rm -rf $(distdir)
	@mkdir $(distdir)
	@-chmod 777 $(distdir)
	@for file in images $(HTMLFILES) $(IMAGEFILES); do	\
		if test -d $$file; then			\
			mkdir $(distdir)/$$file;	\
		else					\
			cp -p $$file $(distdir)/$$file;	\
		fi;					\
	done
	@tar -c $(distdir) | gzip -9 > $(HTML_NAME).tar.gz
	@rm -rf $(distdir)
	@echo "Built $(HTML_NAME).tar.gz"
