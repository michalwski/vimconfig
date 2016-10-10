" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle
        let iCanHazVundle=0
	endif
    set nocompatible              " be iMproved, required
    filetype off                  " required
    set rtp+=~/.vim/bundle/vundle/
    call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    "Add your bundles here
    Plugin 'Syntastic' "uber awesome syntax and errors highlighter
    Plugin 'altercation/vim-colors-solarized' "T-H-E colorscheme
    Plugin 'tpope/vim-sensible'
    Plugin 'vim-erlang/vim-erlang-compiler'
    Plugin 'vim-erlang/vim-erlang-runtime'
    Plugin 'vim-erlang/vim-erlang-tags'
    Plugin 'vim-erlang/vim-erlang-omnicomplete'
    Plugin 'vim-erlang/vim-compot'
    Plugin 'edkolev/erlang-motions.vim'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'tpope/vim-fugitive'
    Plugin 'ntpeters/vim-better-whitespace'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'tpope/vim-commentary'
    Plugin 'mileszs/ack.vim'
    Plugin 'scrooloose/nerdtree'
    Plugin 'terryma/vim-multiple-cursors'
    Plugin 'elixir-lang/vim-elixir'
    Plugin 'wikitopian/hardmode'
    "...All your other bundles...
    if iCanHazVundle == 0
        echo "Installing Vundles, please ignore key map error messages"
        echo ""
        :PluginInstall
    endif

    call vundle#end()
    "must be last
    filetype plugin indent on " load filetype plugins/indent settings
    colorscheme solarized
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
set relativenumber "display relative line numbers
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.beam "do not suggest this files in explore :e command
set background=dark "tells vim the background has dark color
set nowrap "do not wrap long lines
set title "set the window title
set colorcolumn=80
set ttimeoutlen=-1
set hlsearch

"Set colorschemes
let g:airline_theme = 'solarized'

"Erlang files
autocmd BufEnter *.escript   if &filetype == '' | setlocal filetype=erlang | endif
autocmd BufEnter rebar.config*   if &filetype == '' | setlocal filetype=erlang | endif
autocmd BufEnter app.config,sys.config   if &filetype == '' | setlocal filetype=erlang | endif

"use 4 spaces for tab in Erlang files
autocmd FileType erlang   setlocal foldmethod=syntax expandtab tabstop=4 shiftwidth=4 textwidth=0

"automatically remove trailing whitespace
autocmd BufWritePre * StripWhitespace

"change default gitgutter update time
set updatetime=1000

let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v([\/]\.(git|hg|svn)$)|(Mnesia.*)',
			\ 'file': '\v\.(exe|so|dll|beam)$',
			\ 'link': 'some_bad_symbolic_links',
			\ }
let g:ctrlp_working_path_mode = ''

let g:NERDTreeIgnore = ['\~$','\.beam$'] "ignore such files in the tree
let g:NERDTreeChDirMode = 2 "change directory when opening NERDtree with a path

"configure syntastic
let g:syntastic_enable_elixir_checker = 1 "enable for elixir
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
			\ "mode": "active",
			\ "passive_filetypes": ["erlang"] }

let g:HardMode_level = 'wannabe'

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor

	let g:ctrlp_user_command = 'ag %s -l -U --nocolor -g ""'
else
	let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
	let g:ctrlp_prompt_mappings = {
				\ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
				\ }
	endif

let mapleader = "," " , is the leader char
"map ,, to open completion
inoremap <Leader>, <C-x><C-o>
imap <C-w> <C-o><C-w>

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
