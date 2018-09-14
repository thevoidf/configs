set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'dracula/vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()            " required

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set noexpandtab
set nowrap
set number
syntax on

" set theme
color dracula
set background=dark
hi Normal guibg=NONE ctermbg=NONE

let g:airline_theme='simple'

set t_Co=256A

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
"let g:airline_section_x = '%{&filetype}'
"let g:airline_section_b = '%{&filetype}'
