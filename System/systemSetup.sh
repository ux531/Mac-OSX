# #!/usr/bin/env bash
#
# # install homebrew
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#
# # removing mac system python in favor of installing latest versions from homebrew.
# sudo rm -rf /Library/Frameworks/Python.framework/Versions/2.7
# sudo rm -rf "/Applications/Python 2.7"
# cd /usr/local/bin/
# ls -l /usr/local/bin | grep '../Library/Frameworks/Python.framework/Versions/2.7' | awk '{print $9}' | tr -d @ | xargs rm
#
# # install application [cask]
#
# brew cask install google-chrome
# brew cask install firefox
# brew cask install slack
# brew cask install skype
# brew cask install atom
# brew cask install vlc
#
# # install libraries
#
# brew install curl
# brew install wget
# brew install node
# brew install youtube-dl
#
# # install additional tools
#
# brew install rename
# brew install exiftool
# brew install qpdf
# brew install ghostscript
# brew install imagemagick
# brew install tree
# brew install ffmpeg
#
# ## Append Bash Autocomplete for git commands
# mkdir ~/MiscFiles
# curl -o ~/MiscFiles/git-completion.bash 'https://github.com/git/git/blob/master/contrib/completion/git-completion.bash'
# echo "source ~/MiscFiles/git-autocomplete-script/git-completion.bash" >> ~/.bash_profile
