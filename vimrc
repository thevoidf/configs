call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale', { 'on':  'ALEToggle' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-signify'
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'cocopon/iceberg.vim'
Plug 'sjl/badwolf'
Plug 'rakr/vim-one'

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
set wildmode=full
syntax on
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set noexpandtab

" spell checking
setlocal spell
setlocal spell spelllang=en_us
" set complete+=kspell " word completion

" show indent
set list listchars=tab:»·,trail:·,nbsp:·

" remap esc to ctrl-c
noremap <C-c> <Esc>

if has('termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
	set t_Co=256
endif

" fix css and js indent in html
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

runtime macros/matchit.vim

" plug
let g:plug_window = 'enew' 

" keys
nmap <s-f> mzgg=G`z
noremap <leader>e :qa!<cr>
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>

" set theme
color one
set background=dark

" line number colors
highlight LineNr ctermfg=white ctermbg=NONE guifg=#ffffff guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
hi EndOfBuffer ctermbg=NONE guibg=NONE
hi Normal ctermbg=NONE guibg=NONE 

" NERD Tree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=24

" fzf
let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
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
	let fn = '%2* %f %0*'
	let branch = " %{fugitive#head() != '' ? 'git->'.fugitive#head() : ''}"
	let num = '%= %{&filetype} %3* %l:%c %P %0*'
	return mode.fn.branch.num
endfunction

let &statusline = s:make_statusline()
hi StatusLine ctermbg=black ctermfg=235 guibg=#282C34 guifg=#ffffff
hi StatusLineTerm ctermbg=black ctermfg=white guibg=#282C34 guifg=#ffffff
hi StatusLineTermNC ctermbg=black ctermfg=white guibg=#282C34 guifg=#ffffff

hi User1 ctermfg=235 ctermbg=111 guibg=#61AFEF guifg=#000000
hi User2 ctermfg=255 ctermbg=236 guibg=#98C379 guifg=#000000
hi User3 ctermfg=255 ctermbg=236 guibg=#E5C07B guifg=#000000

" signify
let g:signify_vcs_list = ['git']

" call in ~/.vim/after/ftplugin/python.vim
function! SetupPython()
	setlocal tabstop=4
	setlocal shiftwidth=4
	setlocal noexpandtab
endfunction
command! -bar SetupPython call SetupPython()

" cursor types
if exists('$TMUX')
	let &t_SI = "\<Esc>Ptmux;\<Esc>\e[6 q\<Esc>\\"
	let &t_SR = "\<Esc>Ptmux;\<Esc>\e[4 q\<Esc>\\"
	let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
	let &t_SI = "\<Esc>[6 q"
	let &t_SR = "\<Esc>[4 q"
	let &t_EI = "\<Esc>[2 q"
endif
