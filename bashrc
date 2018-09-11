PS1='\[\033[0;31m\]\u\[\033[0;37m\]@\[\033[0;34m\]\h\[\033[0;0m\]\$ '

function sps {
	PS1='$ '
}

function lps {
	PS1='\[\033[0;31m\]\u\[\033[0;37m\]@\[\033[0;34m\]\h\[\033[0;0m\]\$ '
}

alias ls='ls --color=auto'
alias dirs='dirs -v'
