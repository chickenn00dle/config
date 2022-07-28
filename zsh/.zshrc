################
#Load Pre Config
################
PRECONFIG=${ZDOTDIR:-$HOME}/preconfig.zsh
if [ -f "$PRECONFIG" ]; then
	. $PRECONFIG
fi

########
#Options
########
setopt nocaseglob
setopt autocd
setopt sharehistory
setopt appendhistory
setopt incappendhistory
setopt histignoredups
setopt histreduceblanks
setopt histverify
setopt correct
setopt correctall
setopt vi
setopt shwordsplit


#############
#Key Bindings
#############
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey -M viins 'jj' vi-cmd-mode


########
#History
########
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=5000
SAVEHIST=2000
HISTORY_IGNORE='(...|cd *|exit|h|history|ll|ls *|pwd)'


########
#Aliases
########
alias ll='ls -lahG'
alias ...='cd ~'
alias h='history'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias rmd='rm -Rf'
alias df='df -h'
alias du='du -h'
alias mkdir='mkdir -p'
alias -s log='tail -f -n 50'
alias topp='top -o cpu -s 3'
alias source='source ~/.config/zsh/.zshrc'
alias sites='cd ~/Sites'


#######
#Prompt
#######
autoload -Uz vcs_info
precmd() {
	vcs_info
	if [ ! ${vcs_info_msg_0_} ]
	then
		PS1='%F{240}%~%(!.#.:)%f '
	else
		zstyle ':vcs_info:git:*' formats '%b'
		PS1="%F{240}../%1~%f[${vcs_info_msg_0_}]%(!.#.:) "
	fi
}


###########
#Completion
###########
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
autoload -Uz compinit && compinit


############
#Load Config
############
CONFIG=${ZDOTDIR:-$HOME}/config.zsh
if [ -f "$CONFIG" ]; then
	. $CONFIG
fi
