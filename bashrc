PS1='$ '

export EDITOR=nvim
export PROJECTS=~/Projects

alias ls='ls --color=auto'
alias e=$EDITOR
alias ec="$EDITOR ~/.config/nvim/init.vim"
alias t='tmux'
alias dirs='dirs -v'
alias xrf='xrdb .Xresources'
alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -selection clipboard -o'

sps() {
	PS1='$ '
}

lps() {
	PS1='\[\033[0;31m\]\u\[\033[0;37m\]@\[\033[0;34m\]\h\[\033[0;0m\]\$ '
}

p() {
	cd $1
	op $(basename $1)
}

pf() {
	project=$(find $PROJECTS -maxdepth 1 -type d -not -path '*/\.*' | fzf)
	cd $project
	op $(basename $project)
}

op() {
	tmux new-session -d -s $1
	tmux send-keys $EDITOR 'C-m'
	tmux new-window
	tmux select-pane -t 0
	tmux select-window -t $1:0
	tmux -2 attach-session -t $1
}
