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
