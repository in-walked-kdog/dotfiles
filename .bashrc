set -o vi

case `uname -s` in
    CYGWIN*)
        OSID=cygwin ;;
    MINGW*)
        OSID=mingw ;;
    [Dd]arwin*)
        OSID=darwin ;;
    [Ll]inux*)
        OSID=linux ;;
    *)
        echo "Error: Couldn't determine OS from uname -s : $(uname -s)"
        exit 1 ;;
esac

# disabled due to taking too long
# which brew &> /dev/null
# if [ "$?" = "0" ]; then
    # [ -f "`brew --prefix git`/etc/bash_completion.d/git-completion.bash" ] && source `brew --prefix git`/etc/bash_completion.d/git-completion.bash
    # [ -f "`brew --prefix git`/etc/bash_completion.d/git-prompt.sh" ] && source `brew --prefix git`/etc/bash_completion.d/git-prompt.sh
# fi
source /usr/local/opt/git/etc/bash_completion.d/git-completion.bash
source /usr/local/opt/git/etc/bash_completion.d/git-prompt.sh

if [ "$OSID" = "darwin" ]; then
    # Open a manpage in Preview, which can be saved to PDF
    manp() { man -t "${1}" | open -f -a /Applications/Preview.app; }
    preview() { open -a /Applications/Preview.app; }
fi

which less &> /dev/null
if [ "$?" = "0" ]; then
    # the R option passes through ANSI color escape sequences; needed for git diff output
    # http://stackoverflow.com/questions/20414596/how-to-get-rid-of-esc-characters-when-using-git-diff-on-mac-os-x-mavericks
    export PAGER=less
    export LESS=eFIMRX
fi

export HISTSIZE=525727
export HISTFILESIZE=524272
export HISTCONTROL="ignoredups:ignorespace"
export HISTIGNORE="&:ls -lrt:[bf]g:pwd:exit:cd:"
export HISTTIMEFORMAT="%d/%m/%y %T "
shopt -s histappend

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=verbose

export PS1='\[\033[36m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '

export FIGNORE=DS_Store

if [ "$JAVA_HOME" = "" ]; then
    if [ "$OSID" = "darwin" ]; then
        JAVA_HOME=$(/usr/libexec/java_home)
    fi
    export JAVA_HOME
fi

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ds="dirs -v"
alias his="history 20"
alias ls="ls -F"
alias la="ls -a"
alias ll="ls -l"
if [ "$OSID" = "darwin" ]; then
    alias more="more -i"
fi
alias ".."="cd .."
alias cd..="cd ../.."
alias cd...="cd ../../.."
alias cd....="cd ../../../.."


lsf () { command ls -1 "$@" | grep -v / ; }
lsg () { command ls *"$@"** ; }

# lsd () { command ls "$@" | grep "/" ; }
# lsd () { command find . -maxdepth 1 -mindepth 1 -type d | grep -v ‘^\./\.’ ; }

alias pd=pushd
alias pd2="pushd +2"
alias pd3="pushd +3"
alias pd4="pushd +4"
alias pp=popd

alias sls="screen -ls"
alias sdr="screen -dr"

alias erase="stty erase ^h"
alias diffy="diff -by --width=200"

alias gg="git grep"
alias ggi="git grep -i"
# alias ggo="git grep -Ovim"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# RUST
export PATH="$HOME/.cargo/bin:$PATH"

