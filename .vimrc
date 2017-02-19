" vim: fdm=marker
" dein setup {{{1 -----------------------------
if &compatible
  set nocompatible
endif

let s:vim = "~/.vim"
let s:dein = s:vim . "/repos/github.com/Shougo/dein.vim"
let &runtimepath .= "," . s:dein

if dein#load_state(s:vim)
  call dein#begin(s:vim)

  " Let dein manage dein
  call dein#add(s:dein)

  " Add or remove your plugins here:
  call dein#add('airblade/vim-gitgutter')
  call dein#add('christoomey/vim-sort-motion')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('junegunn/fzf', { 'build': './install --all' })
  call dein#add('junegunn/fzf.vim')
  call dein#add('kana/vim-textobj-indent')
  call dein#add('kana/vim-textobj-user')
  call dein#add('machakann/vim-highlightedyank')
  call dein#add('mhartington/oceanic-next')
  call dein#add('nelstrom/vim-textobj-rubyblock')
  call dein#add('neomake/neomake')
  call dein#add('ngmy/vim-rubocop')
  call dein#add('scrooloose/nerdtree')
  call dein#add('tpope/vim-bundler')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-rhubarb')
  call dein#add('tpope/vim-surround')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-scripts/confluencewiki.vim')
  call dein#add('wincent/command-t', { 'build': 'sh -c "cd ruby/command-t && ruby extconf.rb && make"' })

  " You can specify revision/branch/tag.
  " call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

" End dein setup }}}1 -------------------------

let g:mapleader = ','

if has('termguicolors')
  set termguicolors
else
  set t_Co=256
endif

colorscheme OceanicNext
let g:airline_theme='oceanicnext'

let g:markdown_fenced_languages = ['ruby']

let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1

if has('mouse_sgr')
  set ttymouse=sgr
endif

set updatetime=1500
let g:gitgutter_sign_column_always = 1

let g:github_enterprise_urls = ['https://github.fidor.de']
let g:is_bash = 1
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

let g:NERDTreeQuitOnOpen = 1

let g:ctrlp_clear_cache_on_exit = 0
let g:CommandTFileScanner = 'git'

set title

" Indentation {{{1
set shiftwidth=2
set expandtab
set shiftround
set smartindent
set autoindent
" }}}1

set noshowmode " displayed in airline
set modeline modelines=3
set mouse=a
set ruler
set wildmenu
set laststatus=2
set scrolloff=2 sidescrolloff=5
set display+=lastline
set number relativenumber

" Search & replace {{{1
set hlsearch incsearch
if exists('&inccommand')
  set inccommand=nosplit " show :s preview as you type
endif
" }}}1

set pastetoggle=<F10>

runtime! macros/matchit.vim

augroup filetype_ruby
  autocmd!
  autocmd Filetype ruby setlocal shiftwidth=2 sts=2 expandtab textwidth=80
augroup END
let g:ruby_space_errors = 1

" set colorcolumn=+0
" hi ColorColumn guibg=black
" hi SignColumn guibg=black

" fzf: fuzzy finder {{{1
" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)


" Basic mappings {{{1
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
imap <Up> <Nop>
imap <Down> <Nop>
imap <Left> <Nop>
imap <Right> <Nop>

noremap <Esc> :nohl<CR>

map <C-n> :NERDTreeToggle<CR>

noremap <leader>gb :Gblame<CR>
noremap <leader>gh :Gbrowse<CR>
noremap <leader>gs :Gstatus<CR>
