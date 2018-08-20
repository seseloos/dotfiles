set nocompatible                " set compatibility to Vim only

" ========= Vim Plug =========
call plug#begin(expand('~/.config/nvim/plugged'))

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'	" grep
Plug 'w0rp/ale'			    " linting

" autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'

" statusline
 Plug 'itchyny/lightline.vim'

" color scheme
" Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }

" languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }	" Go
Plug 'zchee/deoplete-go', { 'do': 'make'}	        " Go support for deoplete
" Plug 'AndrewRadev/splitjoin.vim'

call plug#end()
""}}

" ========= General Settings =========

" set background=dark
set termguicolors
" colorscheme gruvbox
colorscheme dracula

" set leader key
let mapleader = ","

set backspace=indent,eol,start  " allow backspacing over indention, line breaks and insertion start
set showcmd                     " show incomplete commands at the bottom
set noshowmode                  " disable show current mode at the bottom
set hidden                      " enable hidden buffer (manage multiple buffers effectively)
set autoindent                  " take indent for new line from previous line
set autoread                    " reload file if file changes on disk
set autowrite                   " writes content of file automatically when ':make' is called

set laststatus=2                " always display the status bar
set ruler                       " always show cursor position
set wildmenu                    " display command line's tab complete option as a menu
set cursorline                  " highlight the line currently under cursor
set number                      " show line numbers
set noerrorbells                " disable beep on errors
set title

set noswapfile                  " disable swap files
set nobackup                    " disable backup files

" turn on filetype, plugin and indent detection
filetype plugin indent on

set tabstop=4                   " show existing tab with 4 spaces width
set softtabstop=2               " indent by 2 spaces when pressing tab
set shiftwidth=2                " when indenting with '>' use 2 sapces width
set expandtab                   " on pressing tab, insert 4 spaces
set nowrap                      " disable line wrapping

set incsearch                   " find the next match as we type the search.
set hlsearch                    " highlight searches
set ignorecase                  " ignore case when searching...
set smartcase                   " ... unless we type a capital

set encoding=utf-8              " set default encoding to UTF-8
set scrolloff=3                 " number of screen lines to keep above and below the cursor

syntax on                       " enable syntax highlight

set splitbelow                  " splits horizontal windows below the current window
set splitright                  " splits vertical windows right to the current window

" copy/paste/cut
if has('unnamedplus')
  " http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
  set clipboard=unnamed,unnamedplus
end

" ========= Mappings =========
" remap window navigation
nnoremap <C-H> <C-W><C-H>       " switch to window on the left
nnoremap <C-J> <C-W><C-J>       " switch to window below
nnoremap <C-K> <C-W><C-K>       " switch to window above
nnoremap <C-L> <C-W><C-L>       " switch to window on the right

nnoremap <Leader>h :split<CR>   " split window horizontal
nnoremap <Leader>v :vsplit<CR>  " split window vertical

nnoremap <Leader>w :w!<CR>      " save file

" ========= netrw =========
" NERDtree like settings for netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

nnoremap <F2> :Vexplore<CR>     " opens netrw in vertical split

" ========= FZF =========
" open FZF with Ctrl-P
nnoremap <C-p> :<C-u>FZF<CR>

" ========= ripgrep =========
if executable('rg')
	let $FZF_DEFAULT_COMMAND = 'rg --files'
endif

" ========= ALE =========
" only perform lint operations on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0

" keep the ALE gutter open
" let g:ale_sign_column_always = 1

" set ALE signs for error & warnings
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" ========= vim-grepper =========
let g:grepper = {}
let g:grepper.tools = [ 'grep', 'git', 'rg' ]

" search for the current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" ========= vim-go =========
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 

let g:go_test_timeout = '30s'
let g:go_fmt_command = "goimports"
let g:go_snippet_engine = "neosnippet"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1

let g:go_auto_sameids = 1

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" autocmd Filetype go nmap <leader>b <Plug>(go-build)
autocmd Filetype go nmap <leader>r <Plug>(go-run)
autocmd Filetype go nmap <leader>t <Plug>(go-test)
autocmd Filetype go nmap <leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction

autocmd Filetype go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" ========= deoplete =========
if has('nvim')
	" enable deoplete on startup
	let g:deoplete#enable_at_startup = 1
endif

" neocomplete like
set completeopt+=noinsert
" deoplete.nvim recommend
set completeopt+=noselect

" Skip the check of neovim module
let g:python3_host_skip_check = 1

" specifies path to gocode binary
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
" specifies the sort order for gocode
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
" Enable completing of go pointers
let g:deoplete#sources#go#pointer = 1
" enable to automatically set GOOS environment when calling gocode
let g:deoplete#sources#go#auto_goos = 1

" ========= neosnippet =========
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
