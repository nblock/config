set nobackup
set nowritebackup
set noswapfile
set showmode
set showcmd
set showmatch         "show matching brackets (),{},[]
set mat=3             "show matching brackets for 0.3 seconds
set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos
set encoding=utf-8    "use utf-8 everywhere
set fileencoding=utf-8
set termencoding=utf-8
set backspace=indent,eol,start	"more flexible backspace
set mouse=a			      "enable mouse usage in all modes
set incsearch			    "jump to match during searching
set hlsearch			    "highlight search
set ttyfast			      "fast terminal connection
set autochdir         "automatically change to dir where $FILE resides
set scrolloff=4       "4 lines above/below cursor when scrolling
set listchars=tab:▸\ ,eol:¬ "different symbols for tabs and eol
set number            "enable line numbering

"use a terminal title
set title
set titlestring=%F\ [vim]

" tab settings
set tabstop=2         "tab character amount
set expandtab         "tabs as space
set autoindent
set smartindent       "smart autoindenting on a new line
set shiftwidth=2      "set spaces for autoindent
set softtabstop=2

"statusline
set laststatus=2
set statusline=%<%F\ %h%m%r%=%k\ %-10.(%l/%L,%c%V%)\ %P\ [%{&encoding}:%{&fileformat}]%(\ %w%)\ %y

"shortcuts
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O><F2>
set pastetoggle=<F2>
map <F3> :nohlsearch<CR>
autocmd FileType python map <F5> :w<CR>:!python2 "%"<CR>
autocmd FileType tex map <F5> :w<CR>:!latexmk -pdf "%"<CR>
map <F6> :w<CR>:!make<CR>
vmap <F9> :!xclip -f -sel clip<CR>
map <F10> :-1r !xclip -o -sel clip<CR>
nnoremap <silent> <F11> :TagbarToggle<CR>
map <F12> <C-]>

"folding for python
autocmd FileType python setlocal foldmethod=indent

"switch spellcheck languages
let g:myLang = 0
let g:myLangList = [ "nospell", "de", "en" ]
function! MySpellLang()
  "loop through languages
  let g:myLang = g:myLang + 1
  if g:myLang >= len(g:myLangList) | let g:myLang = 0 | endif
  if g:myLang == 0 | set nospell | endif
  if g:myLang == 1 | setlocal spell spelllang=de | endif
  if g:myLang == 2 | setlocal spell spelllang=en | endif
  echo "language:" g:myLangList[g:myLang]
endf

map <F7> :call MySpellLang()<CR>
imap <F7> <C-o>:call MySpellLang()<CR>

"Will allow you to use :w!! to write to a file using sudo if you forgot to "sudo vim file" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

let g:tex_flavor = "latex"  "assume latex

"vim-pydiction
filetype plugin on
let g:pydiction_location = '/usr/share/pydiction/complete-dict'

"tagbar
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

"supertab
let g:SuperTabDefaultCompletionType='context' "autodetect completion mode

"syntax, 256 colors, colorscheme
syntax on
set t_Co=256
colorscheme neon
