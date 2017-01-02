set background=dark

execute pathogen#infect()

filetype plugin indent on
syntax enable

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if has('mouse_sgr')
  set ttymouse=sgr
endif

set updatetime=250
let g:gitgutter_sign_column_always = 1

let g:github_enterprise_urls = ['https://github.fidor.de']

let g:is_bash=1

let g:ctrlp_clear_cache_on_exit = 0

set title
set shiftwidth=2
set expandtab
set shiftround
set smartindent
set autoindent

set modeline
set modelines=3
set mouse=a
set hlsearch
set ruler
set wildmenu
set laststatus=2
set scrolloff=2
set sidescrolloff=5
set display+=lastline

set hlsearch
set incsearch

set pastetoggle=<F10>

runtime! macros/matchit.vim

autocmd Filetype ruby setlocal shiftwidth=2 sts=2 expandtab textwidth=80
let ruby_space_errors = 1

set colorcolumn=+0
hi ColorColumn ctermbg=234
hi SignColumn ctermbg=234
