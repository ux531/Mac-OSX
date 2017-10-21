# Awesome OS X Command Line (https://github.com/herrbischoff/awesome-osx-command-line).

###############################################################################
# Create App Icon
# Function to quickly create an application icon from 1024px master file.
###############################################################################

function mkicns() {
    if [[ -z "$@" ]]; then
        echo "Input file missing"
    else
        filename=${1%.*}
        mkdir $filename.iconset
        sips -z 16 16   $1 --out $filename.iconset/icon_16x16.png
        sips -z 32 32   $1 --out $filename.iconset/icon_16x16@2x.png
        sips -z 32 32   $1 --out $filename.iconset/icon_32x32.png
        sips -z 64 64   $1 --out $filename.iconset/icon_32x32@2x.png
        sips -z 128 128 $1 --out $filename.iconset/icon_128x128.png
        sips -z 256 256 $1 --out $filename.iconset/icon_128x128@2x.png
        sips -z 256 256 $1 --out $filename.iconset/icon_256x256.png
        sips -z 512 512 $1 --out $filename.iconset/icon_256x256@2x.png
        sips -z 512 512 $1 --out $filename.iconset/icon_512x512.png
        cp $1 $filename.iconset/icon_512x512@2x.png
        iconutil -c icns $filename.iconset
        rm -r $filename.iconset
    fi
}

###############################################################################
# This function will use AppleScript to present a password entry dialog to make
# your scripts a little more user friendly.
###############################################################################

function gui_password {
    if [[ -z $1 ]]; then
        gui_prompt="Password:"
    else
        gui_prompt="$1"
    fi
    PW=$(osascript <<EOF
    tell application "System Events"
        activate
        text returned of (display dialog "${gui_prompt}" default answer "" with hidden answer)
    end tell
EOF
    )

    echo -n "${PW}"
}

###############################################################################
## Finder
### Get Path of Frontmost Finder Window
###############################################################################

function finder_path {
    osascript -e 'tell application "Finder"'\
        -e "if (${1-1} <= (count Finder windows)) then"\
        -e "get POSIX path of (target of window ${1-1} as alias)"\
        -e 'else' \
        -e 'get POSIX path of (desktop as alias)'\
        -e 'end if' \
        -e 'end tell';
}

###############################################################################
### Print Files Selected in Finder
###############################################################################

selected() {
    osascript <<EOT
        tell application "Finder"
            set theFiles to selection
            set theList to ""
            repeat with aFile in theFiles
                set theList to theList & POSIX path of (aFile as alias) & "\n"
            end repeat
            theList
        end tell
EOT
}

###############################################################################
### Set Current Directory's Finder View to Column View
###############################################################################

function column_view {
    osascript -e 'set cwd to do shell script "pwd"'\
      -e 'tell application "Finder"'\
      -e "if (${1-1} <= (count Finder windows)) then"\
      -e "set the target of window ${1-1} to (POSIX file cwd) as string"\
      -e "set the current view of the front Finder window to column view"\
      -e 'else' -e "open (POSIX file cwd) as string"\
      -e "set the current view of the front Finder window to column view"\
      -e 'end if' -e 'end tell';
}

###############################################################################
### Set Current Directory's Finder View to Icon View
###############################################################################

function icon_view {
    osascript -e 'set cwd to do shell script "pwd"'\
      -e 'tell application "Finder"'\
      -e "if (${1-1} <= (count Finder windows)) then"\
      -e "set the target of window ${1-1} to (POSIX file cwd) as string"\
      -e "set the current view of the front Finder window to icon view"\
      -e 'else' -e "open (POSIX file cwd) as string"\
      -e "set the current view of the front Finder window to icon view"\
      -e 'end if' -e 'end tell';
};

###############################################################################
### Set Current Directory's Finder View to List View
###############################################################################

function list_view {
  osascript -e 'set cwd to do shell script "pwd"'\
    -e 'tell application "Finder"'\
    -e "if (${1-1} <= (count Finder windows)) then"\
    -e "set the target of window ${1-1} to (POSIX file cwd) as string"\
    -e "set the current view of the front Finder window to list view"\
    -e 'else' -e "open (POSIX file cwd) as string"\
    -e "set the current view of the front Finder window to list view"\
    -e 'end if' -e 'end tell';\
}

###############################################################################
#### List All Apps Downloaded from App Store
###############################################################################

# Via find
find /Applications -path '*Contents/_MASReceipt/receipt' -maxdepth 4 -print |\sed 's#.app/Contents/_MASReceipt/receipt#.app#g; s#/Applications/##'

# Via Spotlight
mdfind kMDItemAppStoreHasReceipt=1

###############################################################################
#### Enable and Disable Remote Desktop Sharing
###############################################################################

# Allow Access for All Users and Give All Users Full Access
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all

# Disable ARD Agent and Remove Access Privileges for All Users
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -configure -access -off

###############################################################################
#### Remove Apple Remote Desktop Settings
###############################################################################

sudo rm -rf /var/db/RemoteManagement ; \
sudo defaults delete /Library/Preferences/com.apple.RemoteDesktop.plist ; \
defaults delete ~/Library/Preferences/com.apple.RemoteDesktop.plist ; \
sudo rm -r /Library/Application\ Support/Apple/Remote\ Desktop/ ; \
rm -r ~/Library/Application\ Support/Remote\ Desktop/ ; \
rm -r ~/Library/Containers/com.apple.RemoteDesktop

###############################################################################
#### Uninstall Google Update
###############################################################################

~/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/Resources/ksinstall --nuke

###############################################################################
### Safari - Enable Develop Menu and Web Inspector
###############################################################################

defaults write com.apple.Safari IncludeInternalDebugMenu -bool true && \
defaults write com.apple.Safari IncludeDevelopMenu -bool true && \
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true && \
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true && \
defaults write -g WebKitDeveloperExtras -bool true

###############################################################################
### Sketch - Export Compact SVGs
###############################################################################

defaults write com.bohemiancoding.sketch3 exportCompactSVG -bool yes


###############################################################################
### Xcode -Install Command Line Tools without Xcode
###############################################################################

xcode-select --install


###############################################################################
#### Convert File to HTML - [txt, rtf,doc/docx]
###############################################################################

textutil -convert html file.ext

###############################################################################
#### View File System Usage.
###############################################################################

sudo fs_usage

###############################################################################
#### Hide Folder in Finder
###############################################################################

chflags hidden /path/to/folder/

###############################################################################
#### Show All File Extensions
###############################################################################

defaults write -g AppleShowAllExtensions -bool true

###############################################################################
#### Show Hidden Files
###############################################################################

# Show All
defaults write com.apple.finder AppleShowAllFiles true

# Restore Default File Visibility
defaults write com.apple.finder AppleShowAllFiles false


###############################################################################
#### Remove Protected Flag
###############################################################################

sudo chflags -R nouchg /path/to/file/or/folder

###############################################################################
#### Show Full Path in Finder Title
###############################################################################

defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

###############################################################################
#### Unhide User Library Folder
###############################################################################

chflags nohidden ~/Library

###############################################################################
#### Increase Number of Recent Places
###############################################################################

defaults write -g NSNavRecentPlacesLimit -int 10 && \
killall Finder

###############################################################################
#### Rubberband Scrolling
###############################################################################

# Disable
defaults write -g NSScrollViewRubberbanding -bool false

# Enable (Default)
defaults write -g NSScrollViewRubberbanding -bool true

###############################################################################
#### Desktop Icon Visibility
###############################################################################

# Hide Icons
defaults write com.apple.finder CreateDesktop -bool false && \
killall Finder

# Show Icons (Default)
defaults write com.apple.finder CreateDesktop -bool true && \
killall Finder

###############################################################################
#### Status Bar
###############################################################################

# Show
defaults write com.apple.finder ShowStatusBar -bool true

# Hide (Default)
defaults write com.apple.finder ShowStatusBar -bool false


###############################################################################
#### Set Current Folder as Default Search Scope
###############################################################################

defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

###############################################################################
#### Disable Creation of Metadata Files on Network Volumes `.DS_Store`
###############################################################################

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true


###############################################################################
#### Disable Creation of Metadata Files on USB Volumes
###############################################################################

defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true


###############################################################################
### Bluetooth
###############################################################################

# Status
defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState

# Enable (Default)
sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 1

# Disable
sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0 && \
sudo killall -HUP blued

###############################################################################
#### Remaining Battery Percentage
###############################################################################

pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';'


###############################################################################
#### Remaining Battery Time
###############################################################################

pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f3 -d';'


###############################################################################
#### Prevent System Sleep
###############################################################################

caffeinate -u -t 3600


###############################################################################
#### Show All Power Management Settings
###############################################################################

sudo pmset -g

###############################################################################
#### Put Display to Sleep after 15 Minutes of Inactivity
###############################################################################

sudo pmset displaysleep 15

###############################################################################
#### Put Computer to Sleep after 30 Minutes of Inactivity
###############################################################################

sudo pmset sleep 30

###############################################################################
#### Check System Sleep Idle Time
###############################################################################

sudo systemsetup -getcomputersleep

###############################################################################
#### Set System Sleep Idle Time to 60 Minutes
###############################################################################

sudo systemsetup -setcomputersleep 60

###############################################################################
#### Turn Off System Sleep Completely
###############################################################################

sudo systemsetup -setcomputersleep Never

###############################################################################
#### Automatic Restart on System Freeze
###############################################################################

sudo systemsetup -setrestartfreeze on

###############################################################################
#### Auto-Correct
###############################################################################

# Disable
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Enable (Default)
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool true

# Show Status
defaults read -g NSAutomaticSpellingCorrectionEnabled


###############################################################################
#### Key Repeat - Disable the default "press and hold" behavior.
###############################################################################

# Enable Key Repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Disable Key Repeat
defaults write -g ApplePressAndHoldEnabled -bool true

###############################################################################
#### Key Repeat Rate - Sets a very fast repeat rate, adjust to taste.
###############################################################################

defaults write -g KeyRepeat -int 0.02

###############################################################################
#### Convert Audio File to iPhone Ringtone
###############################################################################

afconvert input.mp3 ringtone.m4r -f m4af

###############################################################################
#### Create Audiobook From Text
#Uses "Ava" voice, a plain UTF-8 encoded text file for input and AAC output.
###############################################################################

say -v Ava -f file.txt -o "output.m4a"

###############################################################################
#### Set Audio Volume
###############################################################################

osascript -e 'set volume 4'

###############################################################################
#### Play Audio File
###############################################################################

afplay -q 1 filename.mp3

###############################################################################
#### Renew DHCP Lease
###############################################################################

sudo ipconfig set en0 DHCP

###############################################################################
#### Show DHCP Info
###############################################################################

ipconfig getpacket en0

###############################################################################
#### Clear DNS Cache
###############################################################################

sudo dscacheutil -flushcache && \
sudo killall -HUP mDNSResponder

###############################################################################
#### Set Computer Name/Host Name
###############################################################################

sudo scutil --set ComputerName "newhostname" && \
sudo scutil --set HostName "newhostname" && \
sudo scutil --set LocalHostName "newhostname" && \
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "newhostname"

###############################################################################
#### Network Locations
#Switch between network locations created in the Network preference pane.
###############################################################################

# Status
scselect

# Switch Network Location
scselect LocationNameFromStatus

###############################################################################
#### SSH Remote Login
###############################################################################

# Enable remote login
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist

# Disable remote login
sudo launchctl unload -w /System/Library/LaunchDaemons/ssh.plist

###############################################################################
#### TCP/IP Show Application Using a Certain Port
# This outputs all applications currently using port 80.
###############################################################################

sudo lsof -i :80


###############################################################################
#### Show External IP Address
###############################################################################

dig +short myip.opendns.com @resolver1.opendns.com


###############################################################################
#### Firewall Service
###############################################################################

# Show Status
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

# Enable
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Disable (Default)
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off


###############################################################################
#### Generate Secure Password and Copy to Clipboard
###############################################################################

LC_ALL=C tr -dc "[:alpha:][:alnum:]" < /dev/urandom | head -c 20 | pbcopy


###############################################################################
#### Recursively Delete .DS_Store Files
###############################################################################

find . -type f -name '*.DS_Store' -ls -delete


###############################################################################
#### Compare Two Folders
###############################################################################

diff -qr /path/to/folder1 /path/to/folder2


###############################################################################
#### Generate Advanced System and Performance Report
###############################################################################

sudo sysdiagnose -f ~/Desktop/

###############################################################################
#### Notification Center Service
###############################################################################

# Disable
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist && \
killall -9 NotificationCenter

# Enable (Default)
launchctl load -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

###############################################################################
### Root User
###############################################################################

# Enable
dsenableroot

# Disable
dsenableroot -d

###############################################################################
#### Install All Available Software Updates
###############################################################################

sudo softwareupdate -ia

###############################################################################
#### Set Software Update Check Interval
#Set to check daily instead of weekly.
###############################################################################

defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

###############################################################################
#### Show Available Software Updates
###############################################################################

sudo softwareupdate -l
