alias ll='ls -Alhtr --color'
alias install='sudo sbopkg -Bi '
alias update='sudo sbopkg -r'
alias search='sudo sbopkg -g '
alias h='history|grep'
alias weather='wget -O - ftp://tgftp.nws.noaa.gov/data/observations/metar/decoded/EPWA.TXT 2>/dev/null'
alias pk='pkg-config --list-all | grep '
alias oe='openemacs'
alias ytl='youtube-dl --extract-audio --audio-format mp3'
alias sedit='SUDO_EDITOR="/home/ja/bin/edit -nw" sudoedit'
alias sb='sudo sbopkg'
alias bashrc='$EDITOR -nw ~/.bashrc && source ~/.bashrc'
alias p='ps aux | grep'
alias nb='newsbeuter'
alias ff='find . -name '
alias ffi='find . -iname'
alias slrn='NNTPSERVER=news.gmane.org slrn -f ~/.jnewsrc_gmane.org -i ~/.slrnrc.ml'
alias srfc='SURFRAW_graphical=no SURFRAW_text_browser=lynx SURFRAW_text_browser_args=-dump surfraw rfc'
alias kp='kpcli --kdb ~/Dropbox/DroppedBoxx/KEEPASS/passwords_database.kdb'
# https://stackoverflow.com/questions/4561895/how-to-recursively-find-the-latest-modified-file-in-a-directory
alias newest='find . -type f -printf '\''%T@ %p\n'\'' | sort -n | tail -1 | cut -f2- -d" "'
alias sp='slackpkg'
alias texbib='pdflatex praca.tex && bibtex praca && pdflatex praca.tex && pdflatex praca.tex'
alias ubuntu='vboxmanage startvm ubuntu --type headless'
alias sudo='sudo '
alias fdd='ll /dev/disk/by-id'
alias bro='/home/ja/.gem/ruby/1.9.1/bin/bro'
