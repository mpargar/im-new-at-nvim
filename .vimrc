" Custom configs
set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
set laststatus=2
set noshowmode
syntax on

" Plugins
call plug#begin('~/vimfiles/plugin')
" Themes
Plug 'morhetz/gruvbox'
" IDE
" 	Autocomplanion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"	NERDTree
Plug 'scrooloose/nerdtree'
"	NERDTree git
Plug 'Xuyuanp/nerdtree-git-plugin'
"	Git gutter
Plug 'airblade/vim-gitgutter'
"	Easymotion
Plug 'easymotion/vim-easymotion'
"	Tmux navigator
Plug 'christoomey/vim-tmux-navigator'
"	JS hightlighting
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'dikiaap/minimalist'
"	Prietter
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
call plug#end()
" Thmes
colorscheme gruvbox
" colorscheme morning
" colorscheme sublimemonokai
" colorscheme minimalis
" Leader
let mapleader=" "
"------------- Easymotion -----------------
nmap <Leader>s <Plug>(easymotion-s2)
"------------- Nerd tree -----------------
"	Relative number
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber
"	Shortcut
nmap <Leader>nt :NERDTreeFind<CR>
"------------- Prettier -----------------
let g:prettier#config#tab_width=2
let g:prettier#config#use_tabs='false'
"------------- Custom shortcuts -----------------
nmap <Leader>w :w<CR>
nmap <Leader>pr <Plug>(Prettier)
nmap <Leader>q :q<CR>
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gi <Plug>(coc-implementation)
