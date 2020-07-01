" File: init.vim
" Maintainer: Jack Novotny
" Description: With as few commands as possible #minimalism

" -------
" Plugins
" -------

call plug#begin(stdpath('data') . '/plugged')

" Match color scheme to terminal's colors
Plug 'jeffkreeftmeijer/vim-dim'

" Syntax pack with lots of language support
Plug 'sheerun/vim-polyglot'

" Completion engine, file explorer, linter, formatter
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Status line
Plug 'itchyny/lightline.vim'

" Commenting made easy
Plug 'tpope/vim-commentary'

call plug#end()

" Enable fzf (installed with Homebrew)
set rtp+=/usr/local/opt/fzf


" ------
" Visual
" ------

" Show line numbers
set number

" Show relative line numbers
set relativenumber

" Show padding when scrolling
set so=2

" Use spaces instead of tabs (visual only)
set expandtab

" Tab width (visual only)
set tabstop=4
set shiftwidth=4

" List characters show spaces and tabs
set listchars=space:·,tab:»·

" Add coc status to status bar
let g:lightline = {
    \ 'colorscheme': '16color',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified', 'cocstatus'  ] ]
    \ },
    \ 'component_function': {
    \   'cocstatus': 'coc#status'
    \ },
    \ }

" Don't show mode in command bar
set noshowmode

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Color scheme
colorscheme dim


" ---------
" Mechanics
" ---------

" Set leader to comma key
let mapleader = ','

" Toggle showing whitespace characters
nmap <leader><space> :set list!<CR>

" Toggle highlighting search terms
nmap <leader>/ :let @/ = ""<CR>

" Open coc-explorer
nmap <leader>e :CocCommand explorer<CR>

" Use system clipboard
set clipboard+=unnamedplus

" Disable comment continuation
au FileType * set fo-=c fo-=r fo-=o

" Delete trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" When opening a directory, use coc-explorer
augroup CocExplorer
  autocmd!
  autocmd VimEnter * sil! au! FileExplorer *
  autocmd BufEnter * let d = expand('%') | if isdirectory(d) | bd | exe 'CocCommand explorer ' . d | endif
augroup END

" Save last position in file
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
