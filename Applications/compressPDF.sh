# Usage: compresspdf [input file] [output file] [screen*|ebook|printer|prepress]

# /screen selects low-resolution output similar to the Acrobat Distiller "Screen Optimized" setting.
# /ebook selects medium-resolution output similar to the Acrobat Distiller "eBook" setting.
# /printer selects output similar to the Acrobat Distiller "Print Optimized" setting.
# /prepress selects output similar to Acrobat Distiller "Prepress Optimized" setting.
# /default selects output intended to be useful across a wide variety of uses, possibly at the expense of a larger output file.


cpdf() {
    gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dPDFSETTINGS=/ebook -dCompatibilityLevel=1.4 -sOutputFile="$2" "$1"
}

CompressPDF="cpdf"

# Bulk compress pdf files in current/folder
( set -x ; for f in *.pdf ; do $CompressPDF "$f" "${f%}.pdf"; done )
