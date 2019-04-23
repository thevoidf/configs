PS1='$ '

function sps {
	PS1='$ '
}

function lps {
	PS1='\[\033[0;31m\]\u\[\033[0;37m\]@\[\033[0;34m\]\h\[\033[0;0m\]\$ '
}

alias ls='ls --color=auto'
alias dirs='dirs -v'
alias tmux="TERM=screen-256color-bce tmux"
alias xrf='xrdb .Xresources'
export EDITOR='vim'

alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -selection clipboard -o'
