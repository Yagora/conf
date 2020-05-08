# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

#enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# User configuration

alias more='less'

alias ls='ls --color=auto'
alias nslookup='nslookup -sil'
alias tf='tail -f'

alias grep="grep --color=auto --exclude-dir '.svn' --exclude-dir '.git'"


alias h="history"
alias j="jobs"




# export pour l'historique des commandes
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE

export PAGER=less

export TERM=xterm-256color

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(time)
POWERLEVEL9K_MODE='awesome-fontconfig'
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
#POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_STATUS_BACKGROUND=234


ZGEN_AUTOLOAD_COMPINIT=true
# If user is root it can have some issues with access to competition files
if [[ "${USER}" == "root" ]]; then
    ZGEN_AUTOLOAD_COMPINIT=false
fi

source ~/.zgen/zgen.zsh
source ~/.bashrc
source ~/.fonts/*.sh

if ! zgen saved; then
    # zgen will load oh-my-zsh and download it if required
    zgen oh-my-zsh

    # list of plugins from zsh I use
    # see https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/kubectl
    zgen oh-my-zsh plugins/npm
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/man
    zgen oh-my-zsh plugins/grunt
    zgen oh-my-zsh plugins/nvm
    zgen oh-my-zsh plugins/debian
    zgen oh-my-zsh plugins/grunt
#    zgen oh-my-zsh plugins/emacs
    
    # https://github.com/zsh-users/zsh-completions
    zgen load zsh-users/zsh-completions src

    zgen load zsh-users/zsh-syntax-highlighting

    zgen load zsh-users/zsh-history-substring-search    

    # load https://github.com/bhilburn/powerlevel9k theme for zsh
    zgen load bhilburn/powerlevel9k powerlevel9k.zsh-theme
    
    zgen save
fi


# specific for machine configuration, which I don't sync
if [ -f ~/.machinerc ]; then
    source ~/.machinerc
fi

# additional configuration for zsh
# Remove the history (fc -l) command from the history list when invoked.
setopt histnostore

# Remove superfluous blanks from each command line being added to the history list.
setopt histreduceblanks
unsetopt share_history

# Kube autocompletion
source <(kubectl completion zsh)
fpath=($fpath "/home/tanguy/.zfunctions")

# Remove auto correction
unsetopt correct_all
export PATH=$PATH:/home/$USER/.local/bin/
source /home/$USER/.local/bin/aws_zsh_completer.sh
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
