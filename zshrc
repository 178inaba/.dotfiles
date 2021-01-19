# dotfiles path
DF=~/.dotfiles

# git
. $DF/dl/sh/git-completion.zsh
. $DF/dl/sh/git-prompt.sh

# prompt
YELLOW='\[\e[0;33m\]'
RESET_COLOR='\[\e[0m\]'
PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+($YELLOW$(basename $VIRTUAL_ENV)$RESET_COLOR)}\u@\H:\w" "\\\$ "'
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_HIDE_IF_PWD_IGNORED=true

# option for each OS
case $OSTYPE in
    # mac
    darwin*) LSCLR='-G' ;;
    # linux
    linux*) LSCLR='--color' ;;
esac

# alias
alias sudo='sudo -E '
alias ll="ls -l $LSCLR"
alias lh="ls -lh $LSCLR"
alias la="ls -la $LSCLR"
alias lah="ls -lah $LSCLR"
alias h='history | grep'
alias c='clear && clear'
alias dfiles="cd $DF"
alias em=emacs
alias cat='ccat --bg=dark'
alias goc='go test -coverprofile=/tmp/goc && go tool cover -html=/tmp/goc && rm /tmp/goc'

# git alias
alias ga='git add -A'
alias gb='git checkout -b'
alias gc='git checkout'
alias gd='git diff'
alias gs='git branch && git status && gu'
alias gca='git commit -a -m'
alias gcm='git commit -m'
alias gp='git push -u origin'
alias gpm='git push -u origin master'
alias gpd='git push -u origin develop'
alias gpp='git pull --prune'

# funcs
docker() {
    if [[ $@ == 'reset' ]]; then
        # clean
        docker stop $(docker ps -aq)
        docker rm $(docker ps -aq)
        docker rmi $(docker images -q)

        # check
        docker ps -a
        docker images
    else
        command docker "$@"
    fi
}

# Grep as the current directory.
gre() {
    grep -nr --color=always "$@" .
}

# git funcs
gu() {
    if [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
        echo "User: $(git config user.name) <$(git config user.email)>"
    fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# load local
if [ -f ~/.zshrc.local ]; then
    . ~/.zshrc.local
fi
