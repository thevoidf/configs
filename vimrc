call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale', { 'on':  'ALEToggle' }
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-signify'
" Plug 'vbe0201/vimdiscord'

call plug#end()

set noswapfile
set hidden
set splitbelow
set splitright
set clipboard=unnamedplus
set nowrap
set number
set incsearch
set hlsearch
set ignorecase
set smartcase
set laststatus=2
set noshowmode
set wildmenu
set wildmode=list:longest,full
syntax on
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set noexpandtab

" fix css and js indent in html
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" don't split plug
let g:plug_window = 'enew' 

" easier movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" keys
nmap <s-f> mzgg=G`z " indent buffer
noremap <leader>e :qa!<cr>
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>

" set theme
color seoul256
" let g:gruvbox_contrast_dark = 'hard'
" color gruvbox
set background=dark
" line number colors
highlight LineNr ctermfg=white ctermbg=NONE
" transparent bg
hi Normal guibg=NONE ctermbg=NONE

" NERD Tree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=24

" fzf
let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
nmap <c-f> :Ag 
nmap <c-p> :Files<cr>
nmap <c-o> :Buffers<cr>

" statusline
let g:mode_map = {
	\	'n': 'Normal',
	\	'i': 'Insert',
	\	'v': 'Visual',
	\	'V': 'Visual',
	\	'R': 'Replace',
	\	's': 'Select',
	\	't': 'Terminal',
	\	'c': 'Command',
	\	'!': 'Shell'
\ }

function! s:make_statusline()
	let mode = '%1* %{g:mode_map[mode()]} %0*'
	let fn = ' %f '
	let branch = "%{fugitive#head() != '' ? '│ '.fugitive#head() : ''}"
	let num = '%= %{&filetype} │ %l:%c │ %P '
	return mode.fn.branch.num
endfunction

let &statusline = s:make_statusline()
hi StatusLine ctermbg=223 ctermfg=235
hi StatusLineTerm ctermbg=black ctermfg=white
hi StatusLineTermNC ctermbg=black ctermfg=white

hi User1 ctermfg=235 ctermbg=223

" signify
let g:signify_vcs_list = ['git']

" call in ~/.vim/after/ftplugin/python.vim
function! SetupPython()
	setlocal tabstop=4
	setlocal shiftwidth=4
	setlocal noexpandtab
endfunction
command! -bar SetupPython call SetupPython()

runtime macros/matchit.vim

if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\e[6 q\<Esc>\\"
	let &t_SR = "\<Esc>Ptmux;\<Esc>\e[4 q\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
	let &t_SI = "\<Esc>[6 q"
	let &t_SR = "\<Esc>[4 q"
	let &t_EI = "\<Esc>[2 q"
endif
