if &term =~ "xterm"
  set background=dark
endif

execute pathogen#infect()
syntax enable

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if has('mouse_sgr')
  set ttymouse=sgr
endif

filetype plugin indent on

set updatetime=250
let g:gitgutter_sign_column_always = 1

let g:is_bash=1

set title
set shiftwidth=2
set expandtab
set shiftround
set smartindent
set autoindent

set modeline
set modelines=3
set mouse=a
set background=dark
set hlsearch
set ruler
set laststatus=2
set scrolloff=2

set hlsearch
set incsearch

set pastetoggle=<F10>

autocmd Filetype ruby setlocal shiftwidth=2 sts=2 expandtab textwidth=80 

set colorcolumn=+0
hi ColorColumn ctermbg=234
hi SignColumn ctermbg=234
