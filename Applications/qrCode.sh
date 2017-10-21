#!/usr/bin/env bash

currentVersion="1.19.1"
multiline="0" # flag that indicates multiline option


## This function determines which http get tool the system has installed and returns an error if there isnt one
getConfiguredClient()
{
  if  command -v curl &>/dev/null; then
    configuredClient="curl"
  elif command -v wget &>/dev/null; then
    configuredClient="wget"
  elif command -v http &>/dev/null; then
    configuredClient="httpie"
  elif command -v fetch &>/dev/null; then
    configuredClient="fetch"
  else
    echo "Error: This tool reqires either curl, wget, httpie or fetch to be installed." >&2
    return 1
  fi
}

## Allows to call the users configured client without if statements everywhere
httpGet()
{
  case "$configuredClient" in
    curl)  curl -A curl -s "$@" ;;
    wget)  wget -qO- "$@" ;;
    httpie) http -b GET "$@" ;;
    fetch) fetch -q "$@" ;;
  esac
}

update()
{
  # Author: Alexander Epstein https://github.com/alexanderepstein
  # Update utility version 2.2.0
  # To test the tool enter in the defualt values that are in the examples for each variable
  repositoryName="Bash-Snippets" #Name of repostiory to be updated ex. Sandman-Lite
  githubUserName="alexanderepstein" #username that hosts the repostiory ex. alexanderepstein
  nameOfInstallFile="install.sh" # change this if the installer file has a different name be sure to include file extension if there is one
  latestVersion=$(httpGet https://api.github.com/repos/$githubUserName/$repositoryName/tags | grep -Eo '"name":.*?[^\\]",'| head -1 | grep -Eo "[0-9.]+" ) #always grabs the tag without the v option

  if [[ $currentVersion == "" || $repositoryName == "" || $githubUserName == "" || $nameOfInstallFile == "" ]]; then
    echo "Error: update utility has not been configured correctly." >&2
    exit 1
  elif [[ $latestVersion == "" ]]; then
    echo "Error: no active internet connection" >&2
    exit 1
  else
    if [[ "$latestVersion" != "$currentVersion" ]]; then
      echo "Version $latestVersion available"
      echo -n "Do you wish to update $repositoryName [Y/n]: "
      read -r answer
      if [[ "$answer" == [Yy] ]]; then
        cd ~ || { echo 'Update Failed'; exit 1; }
        if [[ -d  ~/$repositoryName ]]; then rm -r -f $repositoryName || { echo "Permissions Error: try running the update as sudo"; exit 1; } ; fi
        echo -n "Downloading latest version of: $repositoryName."
        git clone -q "https://github.com/$githubUserName/$repositoryName" && touch .BSnippetsHiddenFile || { echo "Failure!"; exit 1; } &
        while [ ! -f .BSnippetsHiddenFile ]; do { echo -n "."; sleep 2; };done
        rm -f .BSnippetsHiddenFile
        echo "Success!"
        cd $repositoryName || { echo 'Update Failed'; exit 1; }
        git checkout "v$latestVersion" 2> /dev/null || git checkout "$latestVersion" 2> /dev/null || echo "Couldn't git checkout to stable release, updating to latest commit."
        chmod a+x install.sh #this might be necessary in your case but wasnt in mine.
        ./$nameOfInstallFile "update" || exit 1
        cd ..
        rm -r -f $repositoryName || { echo "Permissions Error: update succesfull but cannot delete temp files located at ~/$repositoryName delete this directory with sudo"; exit 1; }
      else
        exit 1
      fi
    else
      echo "$repositoryName is already the latest version"
    fi
  fi
}

makeqr()
{
  input=$(echo ${input} | sed s/" "/%20/g ) ## replace all spaces in the sentence with HTML-encoded space %20
  httpGet qrenco.de/${input} ## get a response for the qrcode
}

makeMultiLineQr()
{
  if [[ ${configuredClient} != "curl" ]]; then ## prevent usage without curl it is unreliable
    echo "Multiline currently only supports curl!"
    return 1
  else
    printf "%s" "$*"  | curl -F-=\<- qrenco.de
  fi
}

checkInternet()
{
  httpGet github.com > /dev/null 2>&1 || { echo "Error: no active internet connection" >&2; return 1; } # query github with a get request
}

usage()
{
  cat <<EOF
Qrify
Description: Converts strings or URLs into a QR code.
Usage: qrify [stringtoturnintoqrcode]
    -u  Update Bash-Snippet Tools
    -m  Enable multiline support (feature not working yet)
    -h  Show the help
    -v  Get the tool version
Examples:
    qrify this is a test string
    qrify -m two\\\\nlines
    qrify github.com (no http:// or https://)
EOF
}

getConfiguredClient || exit 1


while getopts "m:hvu*:" option
do
  case "${option}" in
    v) echo "Version ${currentVersion}" && exit 0 ;;
    u) checkInternet && update && exit 0 || exit 1 ;;
    h) usage && exit 0 ;;
    m) multiline="1" && echo "Error this is not a supported feature yet" && exit 1 ;;
    *) usage && exit 0 ;;
  esac
done

if [[ $# == "0" ]]; then
  usage
  exit 0
elif [[ $# == "1" ]];then
  if [[ $1 == "help" || $1 == ":help" ]]; then
    usage
    exit 0
  elif [[ $1 == "update" ]]; then
    checkInternet || exit 1
    update || exit 1
    exit 0
  else
    usage
    exit 1
  fi
else
  if [[ $multiline == "0" ]]; then
    checkInternet || exit 1
    input=$(printf '%s ' "$@")
    makeqr || exit 1
    exit 0
  else
    checkInternet || exit 1
    makeMultiLineQr "${@:2}" || exit 1 ## if multiline that means a flag existed so start from the second argument
    exit 0
  fi
fi