#!/usr/bin/env bash

# Ask for the administrator password upfront
if [ "$EUID" -ne 0  ]; then
	echo "Please run as root"
	exit
fi

echo 'Clear System Log Files...'

sudo rm -rf /Library/Containers/com.apple.mail/Data/Library/Logs/Mail/* &>/dev/null
sudo rm -rf /Library/logs/*
sudo rm -rf /Users/Naacal/Library/Caches/*
sudo rm -rf /Users/Naacal/Library/Autosave\ Information/*
sudo rm -rf /var/log/*
sudo rm -rf /private/var/vm
sudo rm -rf /private/var/folders/*
sudo rm -rf /private/var/log/asl/*.asl &>/dev/null
sudo rm -rf /.DocumentRevisions-V100/


echo 'Clear temporary autosave storage...'

sudo rm -rf ~/Library/Autosave Information/
sudo rm -rf ~/Library/Logs

echo 'Clear Adobe Cache Files...'
sudo rm -rfv ~/Library/Application\ Support/Adobe/Common/Media\ Cache\ Files/* &>/dev/null

echo 'Clear System Cache Files...'
sudo rm -rfv /System/Library/Caches/*

echo 'Purge inactive memory...'
purge

for x in $(ls ~/Library/Containers/)
do
    echo "cleaning ~/Libarary/Containers/$x/Data/Library/Caches"
    rm -rf ~/Library/Containers/$x/Data/Library/Caches/*
    echo "done cleaning ~/Library/Containers/$x/Data/Library/Caches"
done
