set nobackup
set nowritebackup
set noswapfile
set showmode
set showcmd
set showmatch			"show matching brackets (),{},[]
set mat=3               	"show matching brackets for 0.3 seconds
set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set backspace=indent,eol,start	"more flexible backspace
set mouse=a			"enable mouse usage in all modes
set incsearch			"jump to match during searching
set hlsearch			"highlight search
set ttyfast			"fast terminal connection

"use a terminal title
set title
set titlestring=%F\ [vim]

" tab settings
set tabstop=2                     " tab character amount
set expandtab                     " tabs as space
set autoindent
set smartindent                   " smart autoindenting on a new line
set shiftwidth=2                  " set spaces for autoindent
set softtabstop=2

"statusline
set laststatus=2
set statusline=%<%F\ %h%m%r%=[type=%Y\ %{&ff}]\ %=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l/%L,%c%V%)\ %P

"shortcuts
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O><F2>
set pastetoggle=<F2>
map <F3> :nohlsearch<CR>
autocmd FileType python map <F5> :w<CR>:!python2 "%"<CR>
autocmd FileType tex map <F5> :w<CR>:!latexmk -pdf "%"<CR>
map <F6> :w<CR>:!make<CR>
nnoremap <F11> :TlistToggle<CR>

"folding for python
autocmd FileType python setlocal foldmethod=indent

"switch spellcheck languages
let g:myLang = 0
let g:myLangList = [ "nospell", "de_de", "en_us" ]
function! MySpellLang()
  "loop through languages
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
  if g:myLang == 0 | set nospell | endif
  if g:myLang == 1 | setlocal spell spelllang=de_de spellfile=~/.vim/spell/de.utf-8.add | endif
  if g:myLang == 2 | setlocal spell spelllang=en_us spellfile=~/.vim/spell/en.utf-8.add | endif
  echo "language:" g:myLangList[g:myLang]
endf

map <F7> :call MySpellLang()<CR>
imap <F7> <C-o>:call MySpellLang()<CR>

"Will allow you to use :w!! to write to a file using sudo if you forgot to "sudo vim file" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

"vim-pydiction
filetype plugin on
let g:pydiction_location = '/usr/share/pydiction/complete-dict'

"syntax, 256 colors, colorscheme
syntax on
set t_Co=256
colorscheme neon
