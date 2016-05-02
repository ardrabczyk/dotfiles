# If not running interactively, don't do anything
[ -z "$PS1" ] && return

############################################################
# shell options
############################################################
HISTCONTROL=ignoreboth
HISTIGNORE='ll:bg:fg:history'
HISTSIZE=5000
HISTFILESIZE=5000
HISTTIMEFORMAT="%F %T "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# append to the history file, don't overwrite it
shopt -s histappend

shopt -s cdspell

############################################################
# alias definitions
############################################################
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

############################################################
# function definitions
############################################################
function mkcd {
    if [ ! -n "$1" ]; then
	echo "Enter a directory name"
    elif [ -d $1 ]; then
	echo "\`$1' already exists"
    else
	mkdir -p $1 && cd $1
    fi
}

function cl {
    cd "$1"
    if [ 0 != $? ]; then
	return 1
    fi

    ll .
}

# Go up directory tree X number of directories
function up() {
    COUNTER="$@";
    # default $COUNTER to 1 if it isn't already set
    if [[ -z $COUNTER ]]; then
	COUNTER=1
    fi
    # make sure $COUNTER is a number
    if [ $COUNTER -eq $COUNTER 2> /dev/null ]; then
	nwd=`pwd` # Set new working directory (nwd) to current directory
	# Loop $nwd up directory tree one at a time
	until [[ $COUNTER -lt 1 ]]; do
	    nwd=`dirname $nwd`
	    let COUNTER-=1
	done
	cd $nwd # change directories to the new working directory
    else
	# print usage and return error
	echo "usage: up [NUMBER]"
	return 1
    fi
}

# uncompress depending on extension...
function ext() {
    if [ -f "$1" ] ; then
	case "$1" in
	    *.tar.bz2) tar xvjf "$1"   ;;
	    *.tar.gz)  tar xvzf "$1"   ;;
	    *.tar.xz)  tar Jxvf $1     ;;
	    *.bz2)     bunzip2 "$1"    ;;
	    *.rar)     unrar x "$1"    ;;
	    *.gz)      gunzip "$1"     ;;
	    *.tar)     tar xvf "$1"    ;;
	    *.tbz2)    tar xvjf "$1"   ;;
	    *.tgz)     tar xvzf "$1"   ;;
	    *.zip)     unzip "$1"      ;;
	    *.Z)       uncompress "$1" ;;
	    *.7z)      7z x "$1"       ;;
	    *.txz)     tar Jxvf "$1"   ;;
	    *.txz)     unxz "$1"       ;;
	    *)
		echo "'$1' cannot be extracted"
		return 1
		;;
	esac
    else
	echo "'$1' is not a valid file"
	return 1
    fi
    return 0
}

function swiki ()
{
    SURFRAW_graphical=no SURFRAW_text_browser=lynx SURFRAW_text_browser_args=-dump surfraw wikipedia "$1" | sed 's/\^*\[[0-9]\+\]//g' | sed 's/^\[edit\] //g'
}

function append_emacs ()
{
    emacsclient --eval "(with-current-buffer (window-buffer) (insert \"$1\"))"
}

function openemacs ()
{
    echo $PWD
    wmctrl -a emacs@
    if [ "." = $(dirname "$1") ] || [ ".." = $(dirname "$1") ]
    then
	emacsclient --eval "(with-current-buffer  (window-buffer) (find-file \"$PWD/$1\"))"
    else
	emacsclient --eval "(with-current-buffer  (window-buffer) (find-file \"$1\"))"
    fi
}

function title ()
{
    echo -ne "\033]0;"$1"\007"
}

function yt ()
{
    mplayer $(youtube-dl -g $1)
}

function cur() { curl -s "http://www.google.com/finance/converter?a="$2"&from="$1"&to=pln&hl=en" |  sed '/res/!d;s/<[^>]*>//g'; }

function man()
{
    env LESS_TERMCAP_mb=$'\E[01;31m' \
	LESS_TERMCAP_md=$'\E[1;31m' \
	LESS_TERMCAP_me=$'\E[0m' \
	LESS_TERMCAP_se=$'\E[0m' \
	LESS_TERMCAP_ue=$'\E[0m' \
	LESS_TERMCAP_us=$'\E[1;32m' \
	man "$@"
}

############################################################
# variable definitions
############################################################
export EMAIL="arkadiusz@drabczyk.org"
export SURFRAW_google_results=100
export PERL_LOCAL_LIB_ROOT="/home/ja/perl5";
export PERL_MB_OPT="--install_base /home/ja/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/ja/perl5";
export PERL5LIB="/home/ja/perl5/lib/perl5/i686-linux-gnu-thread-multi-64int:/home/ja/perl5/lib/perl5";
export PATH="$PATH:/home/ja/perl5/bin"
export PATH="$PATH:/usr/share/surfraw"
export EDITOR=~/bin/edit
export LESS=-MRF
if [ -d ~/bin ] ; then
    export PATH=~/bin:"${PATH}"
fi
export PATH="${PATH}:/sbin:/usr/sbin"
export LANG=en_US.UTF8

############################################################
# source bookmarking system: https://github.com/ardrabczyk/bm
############################################################
. /home/ja/bm/bm.bash-completion
. /home/ja/bm/bm.sh

############################################################
# set prompt: https://github.com/nojhan/liquidprompt
############################################################
. ~/liquidprompt/liquidprompt

####################################################################################################
# enable completion
####################################################################################################
. /etc/profile.d/bash_completion.sh

############################################################
# some fun
############################################################
cowsay -w $(fortune)
