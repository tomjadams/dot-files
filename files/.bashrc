. ~/.aliases/colours
. ~/.ps1_color

# RedBubble Boxen
. /opt/boxen/env.sh

system_name=`uname -s`

# Requires https://github.com/magicmonty/bash-git-prompt
if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

if [ $system_name == 'Linux' ]; then
  [ -f /etc/bash_completion ] && . /etc/bash_completion
  export EDITOR='vim'
else
  #if [ -f `brew --prefix`/etc/bash_completion ]; then
  #  . `brew --prefix`/etc/bash_completion
  #fi
  #for cf in `brew --prefix`/etc/bash_completion.d/*; do . $cf; done
  #for cf in ~/.bash_completion.d/*; do . $cf; done  
  export EDITOR='vim'
fi

#export ARCHFLAGS='-arch x86_64'
#export CC=/usr/local/bin/gcc-4.2
export MAKEFLAGS='-j4'
export HISTSIZE=1000000
export FIGNORE="CVS:.swp:.DS_Store:.svn"
#export JAVA_HOME=/Library/Java/Home

export PATH=~/bin:/usr/local/mysql/bin:~/.cabal/bin:/usr/local/bin:/usr/local/sbin:${PATH}

#export http_proxy=http://username:password@host:port/
#export http_proxy=http://proxy.uq.net.au:80

# coloured ls
if [ "$TERM" != "dumb" ]; then

  if [ $system_name == 'Linux' ]; then
    color_option='--color=auto'
    alias du='du -k --max-depth=1'
  else
    color_option='-G'
    alias du='du -k -d1'
    alias top='top -o cpu'
    alias vi='vim'
  fi

  alias ls="ls $color_option"
  alias ll="ls -lh $color_option"
  alias la="ls -a $color_option"
  alias lal="ls -lha $color_option"

  . ~/.scripts/j.sh
  . ~/.scripts/goku.sh
fi

# sets the title window
case $TERM in
    xterm*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD}\007"'
        ;;
    vt100*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD}\007"'
        ;;
    *)
        PROMPT_COMMAND='${USER}@${HOSTNAME%%.*}:${PWD}"'
        ;;
esac

# disable the discard character (so ^O works in bash)
stty discard undef

# set the umask to something reasonable
umask 007

#shopt -s globstar

bind "C-p":history-search-backward
bind "C-n":history-search-forwardp
bind "set show-all-if-ambiguous On"

. ~/.aliases/git
. ~/.aliases/svn
. ~/.aliases/commands
. ~/.aliases/oomph

if [ -d ${HOME}/.rbenv ]; then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Docker
$(boot2docker shellinit > /dev/null 2> /dev/null)

