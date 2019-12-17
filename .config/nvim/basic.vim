" vim: fdm=marker

set background=dark
syntax on

" Avoid :intro message
set shortmess+=I

let g:mapleader = ','
noremap \ ,

if has('mouse_sgr')
  set ttymouse=sgr
endif

set updatetime=150
if has('signcolumn')
  set signcolumn=yes
endif

set title

" Indentation {{{1
set shiftwidth=2
set expandtab
set shiftround
set autoindent
" }}}1

set modeline modelines=3
set mouse=a
set ruler
set wildmenu
set wildmode=longest,list:longest,full
set wildignorecase
set laststatus=2
set scrolloff=2 sidescrolloff=5
set display+=lastline
set number relativenumber

nnoremap <Leader>c :set cursorline!<CR>

" Status line {{{1
set statusline=\ %(%h\ %)%f%(\ %m%r%)
set statusline+=%=
set statusline+=\ %{&filetype}
set statusline+=\ \ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ \ %3p%%
set statusline+=\ %4l/%L\ :%3c\ 

" Search & replace {{{1
set hlsearch incsearch
if exists('&inccommand')
  set inccommand=nosplit " show :s preview as you type
endif
set ignorecase
set smartcase

" }}}1

runtime! macros/matchit.vim

" Basic mappings {{{1
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
imap <Up> <Nop>
imap <Down> <Nop>
imap <Left> <Nop>
imap <Right> <Nop>

nnoremap <F1> <Esc>
inoremap <F1> <Esc>

" File types {{{1
augroup filetype_dbaccess
  autocmd!
  autocmd BufNewFile,BufRead /tmp/rsq* set filetype=sql | SQLSetType sqlinformix
augroup END
