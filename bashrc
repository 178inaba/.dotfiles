# dotfiles path
DF=~/.dotfiles

# git
. $DF/dl/sh/git-completion.bash
. $DF/dl/sh/git-prompt.sh

# bash prompt
YELLOW='\[\e[0;33m\]'
RESET_COLOR='\[\e[0m\]'
PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+($YELLOW$(basename $VIRTUAL_ENV)$RESET_COLOR)}\u@\h:\w" "\\\$ "'
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
alias em='emacs'
alias h='history | grep'
alias c='clear && clear'
alias gohome="cd $GOPATH/src/github.com/178inaba"
alias dfiles="cd $DF"

# git alias
alias ga='git add -A'
alias gb='git checkout -b'
alias gc='git checkout'
alias gd='git d'
alias gs='git branch && git status && gu'
alias gca='git commit -a -m'
alias gcm='git commit -m'
alias gp='git push -u origin'
alias gpm='git push -u origin master'
alias inaba='git config user.name "178inaba" && git config user.email "178inaba@users.noreply.github.com"'

# funcs
docker() {
	if [[ $@ == 'reset' ]]; then
		docker-machine restart default

		if [[ $(docker-machine url default) =~ ^tcp://(.+):(.+)$ ]]; then
			IP=${BASH_REMATCH[1]}
			PORT=${BASH_REMATCH[2]}
		else
			echo 'not get ip and port!!'
			return 1
		fi

		until nc -z $IP $PORT
		do
			echo 'wait port open...'
			sleep 1s
		done

		eval "$(docker-machine env default)"

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

# git funcs
gu() {
	if [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
		echo "User: $(git config user.name) <$(git config user.email)>"
	fi
}

# load local
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
