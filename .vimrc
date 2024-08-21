call plug#begin("~/.vim/plugged")
  " Themes
  Plug 'morhetz/gruvbox'
  " Plug 'phanviet/vim-monokai-pro'
  " Navigation
  " -> NerdTree
  Plug 'scrooloose/nerdtree'
  Plug 'preservim/nerdcommenter'
  Plug 'ryanoasis/vim-devicons'
  " --> Search
  Plug 'mhinz/vim-grepper'
  " https://github.com/junegunn/fzf#installation
  Plug'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  "	Git
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'airblade/vim-gitgutter'
  Plug 'f-person/git-blame.nvim'
  Plug 'sindrets/diffview.nvim'
  " Autocomplete
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'prettier/vim-prettier', { 'do': 'npm install' }
  "	Easymotion
  Plug 'easymotion/vim-easymotion'
  "	Tmux navigator
  Plug 'christoomey/vim-tmux-navigator'
  " Copilot chat
  Plug 'github/copilot.vim'
  Plug 'zbirenbaum/copilot.lua'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'CopilotC-Nvim/CopilotChat.nvim', { 'branch': 'canary' }
call plug#end()

" ------> Variables
let mapleader=" "

" ------> Configs

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=2               " number of columns occupied by a tab 
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.
set number
set relativenumber

" Coc SASS
autocmd FileType scss setl iskeyword+=@-@

" -------> Shortcuts 
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

" -----> NerdTree
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber
nmap <Leader>nt :NERDTreeFind<CR>
let NERDTreeShowHidden=1

" ------> Themes
colorscheme gruvbox
" colorscheme morning
" colorscheme sublimemonokai
" colorscheme minimalis
set termguicolors

" ---> Prettier 
set tabstop=2
let g:prettier#config#tab_width=2
let g:prettier#config#use_tabs='false'

" ---> Easymotion
nmap <Leader>s <Plug>(easymotion-s2)

" ---> COC
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>rr <Plug>(coc-rename)
inoremap <silent><expr> <C-x> coc#refresh()
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" ---> Fuzy Finder && GREP
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
  \ 'ctrl-s': 'vsplit',
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

" ---> Copilot
"  Copilot Chat
lua << EOF
require("CopilotChat").setup {
  debug = true, -- Enable debugging
  -- See Configuration section for rest
}
EOF
