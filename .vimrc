set nobackup
set nowritebackup
set noswapfile
set ruler
set showmode
set showcmd
set shiftwidth=1
set autoindent smartindent	"use smart indent
set tabpagemax=15
set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos
set fileencoding=utf-8 encoding=utf-8
set laststatus=2		"status line on
set backspace=indent,eol,start	"more flexible backspace

"shortcuts
nnoremap <F11> :TlistToggle<CR>
autocmd FileType python map <F5> :w<CR>:!python "%"<CR>
autocmd FileType tex map <F5> :w<CR>:!latexmk -pdf "%"<CR>
map <F6> :w<CR>:!make<CR>
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O><F2>
set pastetoggle=<F2>

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

set mouse=v	"kill fucking mouse shitbug

"Will allow you to use :w!! to write to a file using sudo if you forgot to "sudo vim file" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

"syntax and colorscheme related
syntax on
colorscheme neon
