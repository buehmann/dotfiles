" dein setup -----------------------------
if &compatible
  set nocompatible
endif

" Required:
" Let dein manage dein
set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim
call dein#begin('~/.vim')
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('airblade/vim-gitgutter')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('mhartington/oceanic-next')
call dein#add('neomake/neomake')
call dein#add('scrooloose/nerdtree')
call dein#add('tpope/vim-bundler')
call dein#add('tpope/vim-commentary')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-rhubarb')
call dein#add('tpope/vim-surround')
call dein#add('vim-airline/vim-airline')
call dein#add('wincent/command-t')
call dein#add('junegunn/fzf', { 'build': './install --all' })
call dein#add('junegunn/fzf.vim')

" You can specify revision/branch/tag.
"call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

" End dein setup -------------------------

if has('termguicolors')
  set termguicolors
else
  set t_Co=256
endif

colorscheme OceanicNext
let g:airline_theme='oceanicnext'

let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1

if has('mouse_sgr')
  set ttymouse=sgr
endif

set updatetime=250
let g:gitgutter_sign_column_always = 1

let g:github_enterprise_urls = ['https://github.fidor.de']
let g:is_bash = 1
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

let g:NERDTreeQuitOnOpen = 1

let g:ctrlp_clear_cache_on_exit = 0

set title
set shiftwidth=2
set expandtab
set shiftround
set smartindent
set autoindent

set noshowmode
set modeline modelines=3
set mouse=a
set ruler
set wildmenu
set laststatus=2
set scrolloff=2 sidescrolloff=5
set display+=lastline
set number relativenumber

set hlsearch incsearch

set pastetoggle=<F10>

runtime! macros/matchit.vim

autocmd Filetype ruby setlocal shiftwidth=2 sts=2 expandtab textwidth=80
let ruby_space_errors = 1

" set colorcolumn=+0
" hi ColorColumn guibg=black
" hi SignColumn guibg=black

map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>

noremap <Esc> :nohl<CR>

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

map <C-n> :NERDTreeToggle<CR>
