" File: .vimrc
" Author: nblock <nblock [/at\] archlinux DOT us>
" Description: just another .vimrc
" Last Modified: Dezember 10th, 2011

set nocompatible
set nobackup
set nowritebackup
set noswapfile
set showmode                   " always display current mode
set showcmd                    " always display current command
set showmatch                  " show matching brackets (),{},[]
set mat=3                      " show matching brackets for 0.3 seconds
set encoding=utf-8             " use utf-8 everywhere
set fileencoding=utf-8         " use utf-8 everywhere
set termencoding=utf-8         " use utf-8 everywhere
set backspace=indent,eol,start " more flexible backspace
set mouse=a                    " enable mouse usage in all modes
set incsearch                  " jump to match during searching
set hlsearch                   " highlight search
set ttyfast                    " fast terminal connection
set scrolloff=4                " 4 lines above/below cursor when scrolling
set listchars=tab:▸\ ,eol:¬    " different symbols for tabs and eol
set nomodeline                 " use secure modeline
set tabpagemax=30              " 30 instead of 10 concurrent tabs
set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos

" use a terminal title
set title
set titlestring=%F\ [vim]

" tab settings
set tabstop=2     " tab character amount
set expandtab     " tabs as space
set autoindent
set smartindent   " smart autoindenting on a new line
set shiftwidth=2  " set spaces for autoindent
set softtabstop=2

" statusline
set laststatus=2
set statusline=%<%F\ %h%m%r%=%k\ %-10.(%l/%L,%c%V%)\ %P\ [%{&encoding}:%{&fileformat}]%(\ %w%)\ %y

" vundle settings
filetype off      "required by vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"plugins managed by vundle
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-speeddating'
Bundle 'godlygeek/tabular'
Bundle 'git://gitorious.org/vim-gnupg/vim-gnupg.git'
Bundle 'matchit.zip'
Bundle 'fs111/pydoc.vim'
Bundle 'paster.vim'
Bundle 'majutsushi/tagbar'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'ciaranm/securemodelines'
Bundle 'scrooloose/nerdcommenter'
Bundle 'AutoComplPop'
Bundle 'scrooloose/syntastic'
Bundle 'SirVer/ultisnips'
Bundle 'nblock/vim-dokuwiki'
Bundle 'SudoEdit.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-powerline'
Bundle 'sjl/gundo.vim'
Bundle 'vim-scripts/AutoTag'

filetype plugin indent on   " required by vundle

" switch spellcheck languages
let g:myLang = 0
let g:myLangList = [ "nospell", "de", "en" ]
function! MySpellLang()
  " loop through languages
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
  if g:myLang == 0 | set nospell | endif
  if g:myLang == 1 | setlocal spell spelllang=de | endif
  if g:myLang == 2 | setlocal spell spelllang=en | endif
  echo "language:" g:myLangList[g:myLang]
endf

" call the python version that is specified in the shebang
" in Arch Linux, `python` is Python 3.x
function! ExecSpecifiedPython()
  let lc = getline(1)

  " check if shebang is present
  if stridx(lc, "python") == -1
    let py = '!/usr/bin/python2 "%"' " default to python2
  else
    let lc = substitute(lc,"#", "", "g")
    let lc = substitute(lc,"env ", "", "g")
    let py = lc . ' "%"'
  endif
  exec py
endfunction

" cleaning up
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" shortcuts and mappings
let mapleader = ","
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O><F2>
set pastetoggle=<F2>
map <F3> :nohlsearch<CR>
autocmd FileType python map <F5> :w<CR>:call ExecSpecifiedPython()<CR>
autocmd FileType tex map <F5> :w<CR>:!latexmk -pdf "%"<CR>
map <F6> :w<CR>:!make<CR>
vmap <F9> :!xclip -f -sel clip<CR>
map <F10> :-1r !xclip -o -sel clip<CR>
nnoremap <silent> <F11> :TagbarToggle<CR>
map <F12> <C-]>
map <F7> :call MySpellLang()<CR>
imap <F7> <C-o>:call MySpellLang()<CR>
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap <leader>= :call Preserve("normal gg=G")<CR>
nnoremap <F9> :GundoToggle<CR>
map <leader>cf [[kV][,c<space><CR>

" switch between buffers
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>w <C-w>w
nnoremap <leader><space> <C-w>r

" enable very magic forward/backward search
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

let g:tex_flavor = "latex"  " assume latex as default tex

" UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<leader><tab>"
let g:UltiSnipsDontReverseSearchPath="1"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "nblock-snippets"]
py import sys; sys.path.append("/home/flo/.vim/nblock-snippets")

"syntastic
let g:syntastic_error_symbol='E'
let g:syntastic_style_error_symbol='e'
let g:syntastic_warning_symbol='W'
let g:syntastic_style_warning_symbol='w'

" vim-pydiction
filetype plugin on
let g:pydiction_location = '/usr/share/pydiction/complete-dict'

"gnupg.vim
let g:GPGUsePipes = 1

" tagbar latex support
let g:tagbar_type_tex = {
  \ 'ctagstype' : 'latex',
  \ 'kinds' : [
  \ 's:sections',
  \ 'g:graphics',
  \ 'l:labels',
  \ 'r:refs:1',
  \ 'L:listings',
  \ 'p:pagerefs:1'
  \ ],
  \ 'sort' : 0,
  \ }

" tagbar mediawiki support
autocmd FileType mediawiki :!ctags %
let g:tagbar_type_mediawiki = {
  \ 'ctagstype' : 'mediawiki',
  \ 'kinds'     : [
  \ 'h:header',
  \ ],
  \ 'sort'    : 0
  \ }

"AutoComplPop
let g:acp_behaviorKeywordLength=4 "start matching after 4 consecutive chars -> less cpu consumption

" settings for different filetypes
autocmd BufNewFile,BufRead PKGBUILD setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType tex setlocal textwidth=120 tabstop=2 shiftwidth=2 softtabstop=2 expandtab smartindent autoindent
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab smartindent autoindent foldmethod=indent
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete " change omnifunc for python
autocmd BufWritePre *.py,*.tex :call Preserve("%s/\\s\\+$//e")    " clean up whitespaces for certain filetypes

" colorscheme settings
syntax enable
set background=dark
colorscheme solarized
