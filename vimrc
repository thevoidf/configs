call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-slash'
Plug 'machakann/vim-highlightedyank'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'w0rp/ale', { 'on': 'ALEToggle' }
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-signify'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': ':call mkdp#util#install()', 'for': 'markdown', 'on': 'MarkdownPreview' }
Plug 'metakirby5/codi.vim', { 'on': 'Codi' }

" Colors
Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'
Plug 'cocopon/iceberg.vim'
Plug 'sjl/badwolf'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'kabbamine/yowish.vim'
Plug 'mhinz/vim-janah'

call plug#end()

let mapleader = ' '
let maplocalleader = ' '

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
set encoding=utf-8
syntax on
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set noexpandtab
" set relativenumber

" python indent
autocmd FileType python setlocal tabstop=4 shiftwidth=4 noexpandtab

" show indent
set list
set listchars=tab:\|\ ,space:.,trail:!

" spell checking
set spelllang=en_us
noremap <leader>s :set spell!<cr>
autocmd BufRead,BufNewFile *.txt set complete+=kspell

" default remaps
noremap <C-c> <Esc>
noremap <C-i> <C-y>
noremap q <nop>

" enable gui colors
if has('termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

" fix css and js indent in html
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" match html tags
runtime macros/matchit.vim

" ctags
set tags=./tags;/

" set theme
color janah
set background=dark

" color overrides
hi LineNr ctermfg=white ctermbg=NONE guifg=#ffffff guibg=NONE
hi CursorLineNr ctermfg=white ctermbg=NONE guifg=#ffffff guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi EndOfBuffer ctermbg=NONE guibg=NONE
hi Normal ctermbg=NONE guibg=NONE 
hi SpecialKey ctermbg=NONE ctermfg=20 guibg=NONE guifg=#3d3d3d
hi NonText ctermbg=NONE ctermfg=20 guibg=NONE guifg=#3d3d3d

" plug
let g:plug_window = 'enew' 

" markdown
let g:vim_markdown_folding_disabled = 1

" highlightedyank
let g:highlightedyank_highlight_duration = 200
highlight HighlightedyankRegion ctermbg=darkgray guibg=#3d3d3d

" NERD Tree
noremap <c-n> :NERDTreeToggle<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize = 24

" ale
let g:ale_linters = { 'javascript': ['eslint'] }
hi ALEError guibg=NONE
hi ALEWarning guibg=NONE
hi ALEInfo guibg=NONE
hi ALEStyleError guibg=NONE
hi ALEStyleWarning guibg=NONE

" signify
let g:signify_vcs_list = ['git']

hi SignifySignAdd guibg=#000000 guifg=#ffffff
hi SignifySignChange guibg=#000000 guifg=#ffffff
hi SignifySignDelete guibg=#000000 guifg=#ffffff
hi SignifySignChangeDelete guibg=#000000 guifg=#ffffff
hi SignifySignDeleteFirstLine guibg=#000000 guifg=#ffffff

nmap h] <plug>(signify-next-hunk)
nmap h[ <plug>(signify-prev-hunk)

" fzf
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" remap fzf opens
let g:fzf_action = {
	\ 'ctrl-t': 'tab split',
	\ 'ctrl-h': 'split',
	\ 'ctrl-v': 'vsplit' }

" fzf colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
	\ 'bg':      ['bg', 'Normal'],
	\ 'hl':      ['fg', 'Comment'],
	\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
	\ 'hl+':     ['fg', 'Statement'],
	\ 'info':    ['fg', 'PreProc'],
	\ 'border':  ['fg', 'Ignore'],
	\ 'prompt':  ['fg', 'Conditional'],
	\ 'pointer': ['fg', 'Exception'],
	\ 'marker':  ['fg', 'Keyword'],
	\ 'spinner': ['fg', 'Label'],
	\ 'header':  ['fg', 'Comment'] }

" fzf maps
nmap <c-p> :Files<cr>
nmap <c-o> :Buffers<cr>

" hide fzf status
if has('nvim')
	autocmd! FileType fzf
	autocmd  FileType fzf set laststatus=0 noshowmode noruler
		\| autocmd BufLeave <buffer> set laststatus=2
endif

" codi
noremap <leader>j :Codi javascript<cr>

" statusline
let g:mode_map = {
	\ 'n': 'Normal',
	\ 'i': 'Insert',
	\ 'v': 'Visual',
	\ 'V': 'Visual',
	\ 'R': 'Replace',
	\ 's': 'Select',
	\ 't': 'Terminal',
	\ 'c': 'Command',
	\ '!': 'Shell'
	\ }

function! s:make_statusline()
	let mode = '%1* %{g:mode_map[mode()]} %0*'
	let fn = '%2* %f %0*'
	let branch = " %{fugitive#head() != '' ? 'git->'.fugitive#head() : ''}"
	let num = '%= %{&filetype} %3* %l:%c %P %0*'
	return mode.fn.branch.num
endfunction

let &statusline = s:make_statusline()

hi StatusLine ctermbg=black ctermfg=235 guibg=#212121 guifg=#ffffff
hi StatusLineTerm ctermbg=black ctermfg=white guibg=#282C34 guifg=#ffffff
hi StatusLineTermNC ctermbg=black ctermfg=white guibg=#282C34 guifg=#ffffff

hi User1 ctermfg=235 ctermbg=111 guibg=#61AFEF guifg=#000000
hi User2 ctermfg=255 ctermbg=236 guibg=#98C379 guifg=#000000
hi User3 ctermfg=255 ctermbg=236 guibg=#E5C07B guifg=#000000

" keys
noremap <s-f> mzgg=G`z
noremap <leader>w :w<cr>
noremap <leader>q :q!<cr>
noremap <leader>c :bd!<cr>
noremap <leader>x :qa!<cr>
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>
nnoremap <leader>e :source %<cr>
nnoremap <leader>i :PlugInstall<cr>
nnoremap <leader>g :Gstatus<cr>
noremap <leader>r :Commands<cr>
noremap <leader>u :UndotreeToggle<cr>

" move lines
noremap <c-j> :move+<cr>
noremap <c-k> :move-2<cr>

" resize
nnoremap <leader>rh :vertical resize -1<cr>
nnoremap <leader>rl :vertical resize +1<cr>
nnoremap <leader>rj :resize +1<cr>
nnoremap <leader>rk :resize -1<cr>

function! ToggleIndent()
	if &expandtab == 0
		set expandtab
	else
		set noexpandtab
	endif
endfunction

command! ToggleIndent call ToggleIndent()

function! Find()
	let $FZF_DEFAULT_COMMAND = 'fd --type f --max-depth 1 --hidden'
	execute ':Files'
	let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endfunction

nnoremap <leader>f :call Find()<cr>
