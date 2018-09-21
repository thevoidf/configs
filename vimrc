call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

set noswapfile
set hidden
set splitbelow
set splitright
set clipboard=unnamedplus
set nowrap
set number
set laststatus=2
set noshowmode
syntax on
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set noexpandtab

" fix css and js indent in html
let g:html_indent_script1 = "inc" 
let g:html_indent_style1 = "inc" 
let g:plug_window = 'enew' " don't split plug

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nmap <s-f> mzgg=G`z " indent buffer
" noremap <c-e> :qa!<cr>

" set theme
let g:gruvbox_contrast_dark = 'hard'
color gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE " transparent bg

" NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ctrlp
" let g:ctrlp_show_hidden = 1
" let g:ctrlp_custom_ignore = 'node_modules\|__pycache__\|.git'
" nmap <c-l> :CtrlPBuffer<cr>

" fzf
let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
nmap <c-p> :Files<cr>
nmap <c-o> :Buffers<cr>

" lightline
let g:lightline = {
	\ 'colorscheme': 'deus',
	\ 'active': {
	\		'left': [ [ 'mode'], [ 'filename' ] ],
	\		'right': [ [ 'lineinfo' ], [ 'percent' ],
	\              ['filetype'] ]
	\ }
\ }

" call in ~/.vim/after/ftplugin/python.vim
function! SetupPython()
	setlocal tabstop=4
	setlocal shiftwidth=4
	setlocal noexpandtab
endfunction
command! -bar SetupPython call SetupPython()
