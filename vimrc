" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

" 将下面配置文件加入到.vimrc文件中
set nocompatible " 必须
filetype off     " 必须

" 将Vundle加入运行时路径中(Runtime path)
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" 使用Vundle管理插件，必须
Plugin 'gmarik/Vundle.vim'
Bundle 'vim-ruby/vim-ruby'

Plugin 'tpope/vim-fugitive'
Plugin 'plasticboy/vim-markdown'
Plugin 'Lokaltog/vim-powerline'
Plugin 'erikw/tmux-powerline'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'endwise.vim'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-rails'
Plugin 'ervandew/supertab'
Plugin 'flazz/vim-colorschemes'
Plugin 'tomasr/molokai'



"
" 其他插件
"

call vundle#end() " 必须
filetype plugin indent on " 必须
" In VIM, Command :BundleInstall , Display plugin with command :PluginInstall

set nu!
syntax on
set autoindent 
set smartindent
syntax enable

