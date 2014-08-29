# Linux Kernel in a Nutshell

## About
Linux Kernel in a Nutshell is a 2006 book by Greg Kroah-Hartman.  It is released under the Creative Commons [Attribution-ShareAlike 2.5](http://creativecommons.org/licenses/by-sa/2.5/) License.

This is a mirror and not the authoritative location (http://www.kroah.com/lkn/)

## Building the book

The book is written in Docbook XML format as per standard O'Reilly guidelines.  More information on their toolchain can be found in the `dblite` directory.  O'Reilly books use a modified version of Docbook XML and their corredponding DTD files are in the `dblite` path.

One of the primary reasons for this mirror was creating a version of the book in EPUB and Mobi format.  These files are located under the "releases" directory.  The source for the epub changes are in the **epub** branch.

To generate the required files for the epub:

```
$ xsltproc /usr/share/sgml/docbook/xsl-stylesheets-1.78.1/epub/docbook.xsl ../book.xml
$ cp -r ../images OEBPS/
$ echo "application/epub+zip" > mimetype
$ zip -0Xqr  lkn.epub mimetype META-INF OEBPS/
```

This will create two new directories META-INF and OEBPS.  These contain the content for the book.  Unfortunately since the O'Reilly Docbook is non standard it doesn't know how to handle the images, but copying the directory into OEBPS fixes this.  Finally, the zip command generates the actual epub file `lkn.epub`.


## Other resources

  * [Kernel Newbies](http://www.kernelnewbies.org)
  * [Kernel Newbies Forum](http://forum.kernelnewbies.org/)
