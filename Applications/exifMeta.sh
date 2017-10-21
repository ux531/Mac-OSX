#!/bin/bash
# Remove all Metadata from PDF
# Required libraries: exiftool & qpdf
# Install using brew : brew install exiftool | brew install qpdf

# set -x

fileName=$1
tempName="${1//[^[:alnum:].pdf]/}"

# read tags from the original PDF
#exiftool -all:all $FILE

for f in *.pdf ; do mv "${1}" "${tempName}"; done
# for f in $tempName; do mv "$fileName" "${tempName}" ; done

# remove tags (XMP + metadata) from the PDF
exiftool -all:all= $tempName

# linearize the file to remove orphan data
qpdf --linearize $tempName q_$tempName

# read XMP from the modified PDF
# exiftool -all:all q_$tempName

# update metadata
exiftool -Title="" -Author="" -Subject="" -Creator="" -Keywords="" -Producer="" q_$tempName

# revert the original name to the newly created file
for f in q_$tempName; do mv "$f" "${fileName}" ; done

# remove all copies of the "_original" file and leave only the new copy
rm -f -rf *original
rm -f -rf q_*.pdf
rm -f -rf $tempName
rm -f -rf q_$tempName

# pdfinfo $1
# exiftool -all:all $1
exit
