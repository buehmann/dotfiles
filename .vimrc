if &term =~ "xterm"
  set background=dark
endif

execute pathogen#infect()
syntax on
filetype plugin indent on
let g:is_bash=1

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

let g:gitgutter_sign_column_always = 1
set updatetime=250

set shiftwidth=2
set shiftround
set smartindent
set autoindent
set modeline
set mouse=a
set laststatus=2
set scrolloff=2
set hlsearch

autocmd FileType ruby set sw=2 sts=2 et tw=80

set cc=+0
hi ColorColumn ctermbg=darkgrey
hi SignColumn ctermbg=darkgrey
