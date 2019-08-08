call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale', { 'on':  'ALEToggle' }
Plug 'dracula/vim'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'vbe0201/vimdiscord'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'airblade/vim-gitgutter', { 'on': 'GitGutterEnable' }

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
let g:gruvbox_contrast_dark = 'hard'
color gruvbox
set background=dark
hi Normal guibg=NONE ctermbg=NONE " transparent bg

" NERD Tree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=24

" fzf
let $FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
nmap <c-f> :Ag 
nmap <c-p> :Files<cr>
nmap <c-o> :Buffers<cr>

" light line
let g:lightline = {
	\ 'colorscheme': 'deus',
	\ 'active': {
	\		'left': [ [ 'mode'], [ 'filename' ] ],
	\		'right': [ [ 'lineinfo' ], [ 'percent' ],
	\              ['filetype'] ]
	\ }
\ }

" limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'
let g:limelight_priority = -1

" git gutter
set updatetime=100

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

" Delete buffer while keeping window layout (don't close buffer's windows).
if v:version < 700 || exists('loaded_bclose') || &cp
	finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
	let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
	echohl ErrorMsg
	echomsg a:msg
	echohl NONE
endfunction

" close buffer properly when nerdtree is opened
function! s:Bclose(bang, buffer)
	if empty(a:buffer)
		let btarget = bufnr('%')
	elseif a:buffer =~ '^\d\+$'
		let btarget = bufnr(str2nr(a:buffer))
	else
		let btarget = bufnr(a:buffer)
	endif
	if btarget < 0
		call s:Warn('No matching buffer for '.a:buffer)
		return
	endif
	if empty(a:bang) && getbufvar(btarget, '&modified')
		call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
		return
	endif
	let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
	if !g:bclose_multiple && len(wnums) > 1
		call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
		return
	endif
	let wcurrent = winnr()
	for w in wnums
		execute w.'wincmd w'
		let prevbuf = bufnr('#')
		if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
			buffer #
		else
			bprevious
		endif
		if btarget == bufnr('%')
			let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
			let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
			let bjump = (bhidden + blisted + [-1])[0]
			if bjump > 0
				execute 'buffer '.bjump
			else
				execute 'enew'.a:bang
			endif
		endif
	endfor
	execute 'bdelete'.a:bang.' '.btarget
	execute wcurrent.'wincmd w'
endfunction

command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose('<bang>', '<args>')
nnoremap <silent> <leader>q :Bclose!<cr>
