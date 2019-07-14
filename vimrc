set nocompatible                " set compatibility to Vim only

" ========= Vim Plug =========
call plug#begin(expand('~/.config/nvim/plugged'))

" fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'	" grep
" Plug 'w0rp/ale'			    " linting

" autocompletion
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" snippets
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'

Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'

Plug 'itchyny/lightline.vim'  " statusline
Plug 'majutsushi/tagbar'
Plug 'AndrewRadev/splitjoin.vim'

" Distraction-free writing
Plug 'junegunn/goyo.vim'
" Paragraph highlighting - good for focusing
Plug 'junegunn/limelight.vim'

" color scheme
Plug 'dracula/vim', { 'as': 'dracula' }

" languages
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }	" Go
" Plug 'zchee/deoplete-go', { 'do': 'make'}	        " Go support for deoplete
Plug 'cespare/vim-toml'
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'

call plug#end()

" ========= General Settings =========

set termguicolors
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
set relativenumber              " enable relative numbers
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

" disable relativenumber when entering 'Insert' mode
" enable relativenumber when leaving 'Insert' mode
augroup toggle_relative_number
  autocmd InsertEnter * :setlocal norelativenumber
  autocmd InsertLeave * :setlocal relativenumber
augroup END

" ========= Mappings =========
" Fix some common typos
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" remap window navigation
nnoremap <C-H> <C-W><C-H>       " switch to window on the left
nnoremap <C-J> <C-W><C-J>       " switch to window below
nnoremap <C-K> <C-W><C-K>       " switch to window above
nnoremap <C-L> <C-W><C-L>       " switch to window on the right

" split creation
nnoremap <Leader>h :split<CR>   " split window horizontal
nnoremap <Leader>v :vsplit<CR>  " split window vertical

nnoremap <Leader>w :w!<CR>      " save file

" easier jump between errors in quickfix list
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

function! s:clear_search_highlight()
  let @/ = ""
  call go#guru#ClearSameIds()
endfunction
nnoremap <silent> <leader>csh :<C-u>call <SID>clear_search_highlight()<CR>

" ========= netrw =========
" NERDtree like settings for netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

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

" ========= yaml =========
autocmd BufNewFile,BufRead *.{yaml,yml} setlocal filetype=yaml foldmethod=indent tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" ========= Markdown =========
autocmd FileType markdown set conceallevel=0
autocmd FileType markdown normal zR

let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
" let g:vim_markdown_json_frontmatter = 1

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

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction

augroup go
  autocmd!

  autocmd FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd FileType go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd FileType go command! -bang AH call go#alternate#Switch(<bang>0, 'spli')
  autocmd FileType go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

  autocmd Filetype go nmap <Leader>r <Plug>(go-run)
  autocmd Filetype go nmap <Leader>t <Plug>(go-test)
  autocmd Filetype go nmap <Leader>c <Plug>(go-coverage-toggle)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd Filetype go nmap <Leader>b :<C-u>call <SID>build_go_files()<CR>

  autocmd FileType go nmap <Leader>gdv <Plug>(go-def-vertical)
  " autocmd FileType go nmap <Leader>gdh <Plug>(go-def-split)
  autocmd FileType go nmap <Leader>gDv <Plug>(go-doc-vertical)
  " autocmd FileType go nmap <Leader>gDh <Plug>(go-doc-split)

  autocmd FileType go nmap <C-g> :GoDecls<CR>
  autocmd FileType go imap <C-g> <ESC>:<C-u>GoDecls<CR>

  autocmd FileType go nmap <Leader>gt :GoDeclsDir<CR>
augroup END

" " ========= deoplete =========
" if has('nvim')
" 	" enable deoplete on startup
" 	let g:deoplete#enable_at_startup = 1
" endif

" " neocomplete like
" set completeopt+=noinsert
" " deoplete.nvim recommend
" set completeopt+=noselect

" " Skip the check of neovim module
" let g:python3_host_skip_check = 1

" " specifies path to gocode binary
" let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
" " specifies the sort order for gocode
" let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
" " Enable completing of go pointers
" let g:deoplete#sources#go#pointer = 1
" " enable to automatically set GOOS environment when calling gocode
" let g:deoplete#sources#go#auto_goos = 1

" " ========= neosnippet =========
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)

" imap <expr><TAB> pumvisible() ? /"\<C-n>" : neosnippet#expandable_or_jumpable() ? /"\<Plug>(neosnippet_expand_or_jump)" : /"\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ? /"\<Plug>(neosnippet_expand_or_jump)" : /"\<TAB>"

" " ========= tagbar =========
nmap <F4> :TagbarToggle<CR>

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" " if hidden is not set, TextEdit might fail.
" set hidden
" " Better display for messages
" set cmdheight=2
" " Smaller updatetime for CursorHold & CursorHoldI
" set updatetime=300
" " don't give |ins-completion-menu| messages.
" set shortmess+=c
" " always show signcolumns
" set signcolumn=yes

" " Use tab for trigger completion with characters ahead and navigate.
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? /"\<C-n>" :
"       \ <SID>check_back_space() ? /"\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? /"\<C-p>" : /"\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" " Use `[c` and `]c` to navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)

" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Use U to show documentation in preview window
" nnoremap <silent> U :call <SID>show_documentation()<CR>

" " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

" " Remap for format selected region
" vmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
