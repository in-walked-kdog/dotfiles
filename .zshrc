export ZSH="/Users/kevinrathbun/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git git-extras gitignore brew vi-mode history osx colorize)

ZSH_COLORIZE_STYLE="monokai"

source $ZSH/oh-my-zsh.sh

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

setopt NO_BEEP

# Open a manpage in Preview, which can be saved to PDF
manp() { man -t "${1}" | open -f -a /Applications/Preview.app; }
preview() { open -a /Applications/Preview.app; }

which less &> /dev/null
if [ "$?" = "0" ]; then
    # the R option passes through ANSI color escape sequences; needed for git diff output
    # http://stackoverflow.com/questions/20414596/how-to-get-rid-of-esc-characters-when-using-git-diff-on-mac-os-x-mavericks
    export PAGER="less -i"
    export LESS=eFIMRX
fi

# ignored by tab completion
export FIGNORE="$FIGNORE:.DS_Store"

if [ "$JAVA_HOME" = "" ]; then
    JAVA_HOME=$(/usr/libexec/java_home &> /dev/null)
    export JAVA_HOME
fi

# added or changed for zsh
alias his="history -20"
# alias more="more -i"
alias more="less -i"
# alias cat="ccat"
# https://gist.github.com/BretFisher/6f688dde0122399efdca5a9d26100437
# using zsh colorize plugin instead of this
# alias pcat='pygmentize -f terminal256 -O style=monokai -g'

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ds="dirs -v"
alias ls="ls -F"
alias la="ls -a"
alias ll="ls -l"
alias ".."="cd .."
alias cd..="cd ../.."
alias cd...="cd ../../.."
alias cd....="cd ../../../.."
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

### REVIEW BELOW ONE MORE TIME THEN DELETE ####

# https://stackoverflow.com/questions/24226685/have-zsh-return-case-insensitive-auto-complete-matches-but-prefer-exact-matches
# using ~/.oh-my-zsh/custom/better-completion.zsh instead of this
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# WILL THIS WORK SINCE I USED CUSTOM case_sensitive completion
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

function fold {
    if [ $# -eq 0 ]; then
        /usr/bin/fold -w $COLUMNS -s
    else
        /usr/bin/fold $*
    fi
}

function spell {
    cat /usr/share/dict/words | fzf --preview 'wn {} -over | fold' --preview-window=up:60%
}

function dic {
    if [ $# -eq 0 ]; then
        wn `spell` -over | fold
    else
        wn $1 -over | fold
    fi
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kevinrathbun/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kevinrathbun/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/kevinrathbun/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kevinrathbun/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# copied from .fzf.zsh
if [[ ! "$PATH" == *emacs* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/kevinrathbun/.emacs.d/bin:/Users/kevinrathbun/bin"
fi

# RUST
export PATH="$HOME/.cargo/bin:$PATH"
