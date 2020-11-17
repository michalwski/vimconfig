language en_US
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')
"Add your bundles here
Plug 'neomake/neomake'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-erlang/vim-erlang-tags'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'edkolev/erlang-motions.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'elixir-lang/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rust-lang/rust.vim'
Plug 'ervandew/supertab'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" Run PlugInstall if there are missing plugins
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"...All your other bundles...
"must be last
filetype plugin indent on " load filetype plugins/indent settings
colorscheme PaperColor
"colorscheme solarized
syntax on                      " enable syntax

if split(system('uname'))[0] == 'Darwin'
  if has('gui_running')
    set guifont=Source\ Code\ Pro\ Light:h11
    let $PATH .= ':/opt/local/bin'
    inoremap <C-Space> <C-n>
  endif
endif

set nofoldenable "disable folding
set number "display line numbers
set wildmode=longest:full,full
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.beam "do not suggest this files in explore :e command
set wildignore+=_build/default/lib/ejabberd/*,_build/mim*,_build/test/*,_build/fed*
set wildignore+=_build/default/lib/mongooseim/*,_build/mim*,_build/test/*,_build/fed*
set wildignore+=test.disabled/ejabberd_tests/ct_report/*
set background=light
set nowrap "do not wrap long lines
set title "set the window title
set colorcolumn=100
set ttimeoutlen=-1
set hlsearch
set autoread

"Set colorschemes
"let g:airline_theme = 'solarized'

autocmd CursorHold,CursorHoldI * if !bufexists("[Command Line]") | checktime | endif
"Erlang files
autocmd BufEnter *.escript   if &filetype == '' | setlocal filetype=erlang | endif
autocmd BufEnter rebar.config*   if &filetype == '' | setlocal filetype=erlang | endif
autocmd BufEnter app.config,sys.config   if &filetype == '' | setlocal filetype=erlang | endif
autocmd BufEnter Dockerfile*	setlocal filetype=dockerfile

"use 4 spaces for tab in Erlang files
autocmd FileType erlang   setlocal foldmethod=syntax expandtab tabstop=4 shiftwidth=4 textwidth=0
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"automatically remove trailing whitespace
autocmd BufWritePre * StripWhitespace

autocmd! BufWritePost * Neomake

"change default gitgutter update time
set updatetime=1000
let g:gitgutter_sign_allow_clobber = 1

let g:NERDTreeIgnore = ['\~$','\.beam$'] "ignore such files in the tree
let g:NERDTreeChDirMode = 2 "change directory when opening NERDtree with a path

let g:erlang_tags_ignore = ['"_build/mim*"', '"_build/fed*"', '_build/default/lib/ejabberd', '_build/default/lib/mongooseim']

let g:neomake_erlang_enabled_makers = []
let g:neomake_elixir_enabled_makers = ['mix', 'credo']

let g:mix_format_on_save = 1

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" FZF
let g:fzf_layout = { 'down': '~25%' }

let g:fzf_history_dir = '~/.local/share/fzf-history'

let mapleader = "," " , is the leader char
"map ,, to open completion
inoremap <Leader>, <C-x><C-o>
imap <C-w> <C-o><C-w>
imap jk <Esc>

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

let mapleader = "\<Space>" " Space is the leader now
" Space w saves the file
nnoremap <Leader>w :w<CR>
"toggles the NERDTree
nnoremap <Leader>t :NERDTreeToggle<CR>
"moves cursor to the NERDTree window
nnoremap <Leader>f :NERDTreeFocus<CR>
"opens window with location list for current file
nnoremap <Leader>e :lopen<CR>
" Autocorrect often misspelled commands/words
cabbr Q q
cabbr W w
cabbr WQ wq
cabbr Wq wq
cabbr Ed ed
cabbr Qall qall
cabbr Wqall wqall
cabbr E Explore
cabbr B b
" ---------- Coc Key Mappings

nmap <silent> <Leader>cf <Plug>(coc-format)
nmap <silent> <Leader>co :CocList outline<cr>
nmap <silent> <Leader>cd :CocList diagnostics<cr>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `gp` and `gn` to navigate diagnostics
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" FZF Key Mappings
" Space o opens FZF :Files search window
nnoremap <Leader>o :Files<CR>
nnoremap <C-p> :Files<CR>

autocmd FileType md,markdown,gitcommit setlocal spell spelllang=en

if has("nvim")
  set signcolumn=auto:3
  " Make escape work in the Neovim terminal.
  tnoremap <Esc> <C-\><C-n>

  " Make navigation into and out of Neovim terminal splits nicer.
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l

  " I like relative numbering when in normal mode.
  autocmd TermOpen * setlocal conceallevel=0 colorcolumn=0 relativenumber

  " Prefer Neovim terminal insert mode to normal mode.
  autocmd BufEnter term://* startinsert
endif
