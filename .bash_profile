#   -------------------------------------------------------------
#   NETWORKING
#   -------------------------------------------------------------
    alias netCons='lsof -i'                                                     # netCons:      Show all open TCP/IP sockets
    alias flushDNS='dscacheutil -flushcache'                                    # flushDNS:     Flush out the DNS Cache
    alias lsock='sudo /usr/sbin/lsof -i -P'                                     # lsock:        Display open sockets
    alias net='ping google.com'                                                 # net:          Cheat
    alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'                           # lsockU:       Display only open UDP sockets
    alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'                           # lsockT:       Display only open TCP sockets
    alias openPorts='sudo lsof -i | grep LISTEN'                                # openPorts:    All listening connections
    alias ip="curl ipecho.net/plain ; echo"                                     # ip:           Preferred ip echo implementation
    alias rout='traceroute '                                                    # rout:         Traceroute
    alias path='echo -e ${PATH//:/\\n}'                                         # path:         Echo all executable Paths
    alias nets='netstat -ap tcp '                                               # nets:         Active Internet connections, including servers
    alias pros='/Applications/Shell/System/proxyStats.sh '                      # pros:         Get network stats
    alias prox='/Applications/Shell/System/systemProxy.sh'                      # prox:         Start secure session

#   -------------------------------------------------------------
#   TERMINAL / COMMON
#   -------------------------------------------------------------
    alias §="ls -l && du -sh"                                                   # §             Show list of dir with file size
    alias .='cd ~'                                                              # .:            Go to Home directory from anywhere
    alias c="cd"                                                                # c:            Change directory
    alias w='pwd'                                                               # w:            List working directory
    alias f='open -a Finder ./'                                                 # f:            Opens current directory in MacOS Finder
    alias cp='cp -iv'                                                           # cp:           Preferred implementation: Copy
    alias mv='mv -iv'                                                           # mv:           Preferred implementation: Move
    alias cc='history -c && clear'                                              # cc:           Clear terminal hostory
    alias l='ls -lah $LS_COLOR'                                                 # l:            Preferred implementation
    alias edit='atom'                                                           # edit:         Opens in atom editor
    alias d='cd ~/Downloads && clear'                                           # d:            Go to downloads from anywhere
    alias dd='cd ~/Desktop && clear'                                            # dd:           Go to desktop from anywhere
    alias ddd='cd ~/Documents && clear'                                         # ddd:          Go to Documents from anywhere
    alias r='rm -rf '                                                           # r:            Remove files and folders recursively

#   -------------------------------------------------------------
#   SYSTEM
#   -------------------------------------------------------------
    alias prof="atom ~/.bash_profile"                                           # prof:         Preferred bash_profile edit implementation
    alias re="source ~/.bash_profile"                                           # reset:        Reload bash_profile
    alias mem='sudo purge'                                                      # mem:          Flush memory
    export EDITOR=/usr/bin/atom                                                 #               Set default editor

#   -------------------------------------------------------------
#   REMOVE ALL FILES DIRECTORY EXCEPT ALL THAT MATCH FILE TYPE
#   -------------------------------------------------------------
    not () {
      find . -maxdepth 1 -type f ! -iname *.$1 -ls -delete ;
      echo "All files except *.$1 ware removed!" && ls -l
    }

    q () {
      ls | grep -i "$1"
    }

    x () {
       find . -type f -iname *.$1 ;
    }

#   -------------------------------------------------------------
#   INTERNET / COMMON
#   -------------------------------------------------------------
    alias header='curl -I'                                                      # header                Get web server headers #
    alias headerc='curl -I --compress'                                          # headerc               Get web server headers compressed
    alias apacheEdit='sudo edit /etc/httpd/httpd.conf'                          # apacheEdit:           Edit httpd.conf
    alias apacheRestart='sudo apachectl graceful'                               # apacheRestart:        Restart Apache
    alias editHosts='sudo edit /etc/hosts'                                      # editHosts:            Edit /etc/hosts file
    alias herr='tail /var/log/httpd/error_log'                                  # herr:                 Tails HTTP error logs
    alias apacheLogs="less +F /var/log/apache2/error_log"                       # Apachelogs:           Shows apache error logs
    alias pyServer="python -m SimpleHTTPServer"                                 # pyServer              Python server from current directory tree at http://$HOSTNAME:8000/
    alias phpServer="php -S 127.0.0.1:8080"                                     # phpServer             PHP server from current directory tree at http://$HOSTNAME:8080/

#   -------------------------------------------------------------
#   SYSTEMS OPERATIONS & INFORMATION
#   -------------------------------------------------------------
    alias nods="find . -type f -name '*.DS_Store' -ls -delete"                  # nods:                 Recursively delete .DS_Store files
    alias ShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'        # finderShowHidden:     Show hidden files in Finder
    alias HideHidden='defaults write com.apple.finder ShowAllFiles FALSE'       # finderHideHidden:     Hide hidden files in Finderalias battery='system_profiler SPPowerDataType'                             # battery:              Long versions of the above
    alias hardware='system_profiler SPHardwareDataType'                         # hardware:             Hardware information
    alias network='system_profiler SPNetworkDataType'                           # network:              Network information
    alias software='system_profiler SPSoftwareDataType'                         # software:             Software information
    alias internet='system_profiler SPAirPortDataType'                          # internet:             Airport information
    alias flush='sudo /Applications/Shell/Maintenance/flushLogs.sh '            # flush:                Clear System Log Files...
    alias config='/Applications/Shell/System/systemConfig.sh '                  # config:               Mac OS X config
    alias privacy='sudo /Applications/Shell/System/systemPrivacy.sh '           # config:               Mac OS X config


#   -------------------------------------------------------------
#   Setting PATH for Python 3.5 / Orginal in .bash_profile.pysave
#   -------------------------------------------------------------
    PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
    export PATH

#   -------------------------------------------------------------
#   Wget Shortcuts
#   -------------------------------------------------------------
    alias wall='wget -e robots=off -x --mirror --recursive --page-requisites'
    alias dla='youtube-dl --extract-audio --audio-format mp3 '
    alias ww='wget -r -k -p -np -E --no-cookies '

#   -------------------------------------------------------------
#   Ghostscript & ImageShack & xattr
#   -------------------------------------------------------------
    alias xmetad='xattr -d com.apple.metadata:kMDItemWhereFroms '
    alias xmetaw='xattr -w com.apple.metadata:kMDItemCreators "Naha" '
    alias con='convert -compress jpeg -enhance -interlace line -quality 90 -colors 810 '
    alias ccc='convert $1 -quality 50 $2'

#   -------------------------------------------------------------
#   Sandbox
#   -------------------------------------------------------------
    alias p='/Applications/Shell/Sandbox/currentProject.sh '
    alias s='/Applications/Shell/Sandbox/searchEngine.sh '
    alias ss='/Applications/Shell/Sandbox/storeSession.sh '

#   -------------------------------------------------------------
#   Apps
#   -------------------------------------------------------------
    alias trace='/Applications/Shell/Applications/traceFiles.sh '               # trace:                Trace raster files
    alias pdf='/Applications/Shell/Applications/compressPDF.sh '                # pdf:                  Compress PDF files [imagemagick]
    alias wf='curl wttr.in/varna'                                               # wf:                   Get Weather Forecast
    alias curr='/Applications/Shell/Applications/currencyConvert.sh '           # curr:                 A realtime currency converter
    alias do='/Applications/Shell/Applications/toDoApp.sh '                     # do:                   Simple ToDo app
    alias geo='/Applications/Shell/Applications/geoLocation.sh '                # goe:                  Geo location info
    alias mov='/Applications/Shell/Applications/movieInfo.sh '                  # mov:                  Get movie info
    alias qr='/Applications/Shell/Applications/qrCode.sh qrify '                # qr:                   Generate QR code from string or URL
    alias exif='/Applications/Shell/Applications/exifMeta.sh '                  # exif:                 Exif to update meta
