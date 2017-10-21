#!/bin/bash

# Convert files to png

( set -x ; for i in *.jpg ; do convert "$i" "${i%}_.png" ; done )
( set -x ; for i in *.jpeg ; do convert "$i" "${i%}_.png" ; done )
( set -x ; for file in *.png ; do f="${file%.png}" ; convert "$file" "$f.pnm" && potrace "$f.pnm" -s -o "$f.svg"; done )

rm *.pnm
rm -f *_.jpg
rm -f *_.png
