set nocompatible              " be iMproved, required
filetype off                  " required

" ====================== PLUGINS ======================
" ------> Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'leafOfTree/vim-vue-plugin'
Plugin 'udalov/kotlin-vim'
call vundle#end()            " required
filetype plugin indent on    " required

" ------> Plug
call plug#begin('~/vimfiles/plugin')
" Themes
Plug 'morhetz/gruvbox'
" Plug 'phanviet/vim-monokai-pro'
" IDE
" 	Autocomplanion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"	NERDTree
Plug 'scrooloose/nerdtree'
"	NERD Commeter
Plug 'preservim/nerdcommenter'
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
"	Vue hightlighting
"	Coolor (Color picker)
Plug 'KabbAmine/vCoolor.vim'
"	vim-multiple-cursos
Plug 'terryma/vim-multiple-cursors'
"	Prietter
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" emmt
Plug 'mattn/emmet-vim'
" RipGrep https://github.com/mhinz/vim-grepper
Plug 'mhinz/vim-grepper'
" fzf https://github.com/junegunn/fzf.vim
" https://github.com/junegunn/fzf#installation
Plug'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" ====================== Custom configs ======================

" ------> Variables
let mapleader=" "

" ------> Editor configs
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
set shell=/bin/bash
set backspace=indent,eol,start

" ------> Themes
colorscheme gruvbox
" colorscheme morning
" colorscheme sublimemonokai
" colorscheme minimalis
set termguicolors
" colorscheme monokai_pro

" ------> Shortcus & plugin configs
" ---> Easymotion
nmap <Leader>s <Plug>(easymotion-s2)

" ---> Nerd tree 
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber
nmap <Leader>nt :NERDTreeFind<CR>
let NERDTreeShowHidden=1

" ---> Prettier 
set tabstop=2
let g:prettier#config#tab_width=2
let g:prettier#config#use_tabs='false'

" ---> Vue config 
let g:vue_pre_processors = ['pug', 'scss']
let g:vue_pre_processors = 'detect_on_enter'

" ---> Editor shortcuts
nmap <Leader>w :w<CR>
nmap <Leader>pr <Plug>(Prettier)
nmap <Leader>q :q<CR>
" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" ---> COC
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gi <Plug>(coc-implementation)

" ---> Fuzy Finder
" junegunn/fzf.vim
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
" Customize fzf colors to match your color scheme.
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-b': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}
" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :FZF -m<CR>
" Map a few common things to do with FZF.
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>

" ---> Rip Grep
" Allow passing optional flags into the Rg command.
"   Example: :Rg myterm -g '*.md'
" command! -bang -nargs=* Rg
"  \ call fzf#vim#grep(
"  \ "rg --column --line-number --no-heading --color=always --smart-case" .
"  \ <q-args>, 1, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg -g '!design/' -g '!dist/' -g '!pnpm-lock.yaml' -g '!.git' -g '!node_modules' --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--exact --delimiter : --nth 4..'}), <bang>0) 
