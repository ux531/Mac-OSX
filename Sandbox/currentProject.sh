#!/bin/bash

options=("Base Account" "Emailio Account" "CAH Flickr Albums" "CAH Flickr Photos" "Box" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Base Account")
            open -a /Applications/Google\ Chrome.app/ https://inbox.google.com/u/0/
						break
            ;;
        "Emailio Account")
            open -a /Applications/Google\ Chrome.app/ https://inbox.google.com/u/1/
						break
						;;
        "CAH Flickr Albums")
            open -a /Applications/Google\ Chrome.app/ https://www.flickr.com/photos/advanced-hindsight/albums
						break
            ;;
        "CAH Flickr Photos")
            open -a /Applications/Google\ Chrome.app/ https://www.flickr.com/groups/advancedhindsight/pool
						break
            ;;
				"Box")
            open -a /Applications/Google\ Chrome.app/ https://app.box.com/folder/33807519146
						break
            ;;
        "Quit")
            break
            ;;
        *) echo You gotta pick some number from the list.
						;;
    esac
done
