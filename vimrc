language en_US
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

let g:polyglot_disabled = ['erl', 'rs']

call plug#begin('~/.vim/plugged')
"Add your bundles here
Plug 'neomake/neomake'
Plug 'sheerun/vim-polyglot'
Plug 'altercation/vim-colors-solarized' "T-H-E colorscheme
Plug 'tpope/vim-sensible'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-erlang/vim-erlang-tags'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'edkolev/erlang-motions.vim'
"    Plug 'vim-airline/vim-airline'
"    Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'ntpeters/vim-better-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'elixir-lang/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'tpope/vim-sleuth'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rust-lang/rust.vim'
Plug 'ervandew/supertab'
Plug 'w0rp/ale'
Plug 'tpope/vim-endwise'
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

" Setting up Vundle - the vim plugin bundler end

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

let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v([\/]\.(git|hg|svn)$)|(Mnesia.*)|(ct_report)',
      \ 'file': '\v\.(exe|so|dll|beam)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
let g:ctrlp_working_path_mode = ''

let g:NERDTreeIgnore = ['\~$','\.beam$'] "ignore such files in the tree
let g:NERDTreeChDirMode = 2 "change directory when opening NERDtree with a path

let g:erlang_tags_ignore = ['"_build/mim*"', '"_build/fed*"', '_build/default/lib/ejabberd', '_build/default/lib/mongooseim']

let g:neomake_erlang_enabled_makers = []
let g:neomake_elixir_enabled_makers = ['mix', 'credo']

let g:mix_format_on_save = 1

let g:HardMode_level = 'wannabe'

let g:erlangWranglerPath = '/Users/michalpiotrowski/projects/wrangler/bin'

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


let g:ale_rust_cargo_use_check = 1

let g:ale_linters = {
      \   'erlang': [],
      \   'elixir': [],
      \}

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
" Space o opens CtrlP search window
nnoremap <Leader>o :CtrlP<CR>
" Space w saves the file
nnoremap <Leader>w :w<CR>
"toggles the NERDTree
nnoremap <Leader>t :NERDTreeToggle<CR>
"moves cursor to the NERDTree window
nnoremap <Leader>f :NERDTreeFocus<CR>
"opens window with location list for current file
nnoremap <Leader>e :lopen<CR>
"toogles the HardMode
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
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
