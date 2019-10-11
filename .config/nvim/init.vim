" vim: fdm=marker
" Plugin setup {{{1
if &compatible
  set nocompatible
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-sort-motion'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-user'
Plug 'machakann/vim-highlightedyank'
Plug 'mhartington/oceanic-next'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'neomake/neomake'
Plug 'qxxxb/vim-searchhi'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/confluencewiki.vim', { 'for': 'confluencewiki' }

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

call plug#end()

" End plugin setup }}}1

" Avoid :intro message
set shortmess+=I

let g:mapleader = ','
noremap \ ,

if has('termguicolors') && $TERM_PROGRAM != 'Apple_Terminal'
  set termguicolors
else
  set t_Co=256
endif

colorscheme OceanicNext
let g:airline_theme='oceanicnext'

let g:markdown_fenced_languages = ['ruby']

let g:airline#extensions#tabline#enabled = 0
if $TERM != 'linux'
  let g:airline_powerline_fonts = 1
endif

if has('mouse_sgr')
  set ttymouse=sgr
endif

set updatetime=150
if has('signcolumn')
  set signcolumn=yes
endif

let g:github_enterprise_urls = ['https://github.fidor.de']
let g:is_bash = 1

let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_ruby_rubocop_exe = 'be-rubocop'
let g:neomake_open_list = 2
call neomake#configure#automake('rnw', 750)

" https://github.com/neomake/neomake/issues/1455
augroup buehmann_qf
  autocmd!
  autocmd QuitPre * if &filetype != 'qf' | lclose | cclose | endif
augroup END

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

let g:NERDTreeQuitOnOpen = 1

let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop '

set title

" Indentation {{{1
set shiftwidth=2
set expandtab
set shiftround
set autoindent
" }}}1

set noshowmode " displayed in airline
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

" Search & replace {{{1
set hlsearch incsearch
if exists('&inccommand')
  set inccommand=nosplit " show :s preview as you type
endif
" }}}1

set pastetoggle=<F10>
set clipboard+=unnamedplus

runtime! macros/matchit.vim

" Grepping {{{1
" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

nnoremap gr :Ggrep <cword><CR>:cw<CR>
nnoremap gR :Ggrep '\b<cword>\b'<CR>:cw<CR>

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
nnoremap <F1> <Esc>
inoremap <F1> <Esc>

map <C-n> :NERDTreeToggle<CR>

noremap <leader>gb :Gblame<CR>
noremap <leader>gh :Gbrowse<CR>
noremap <leader>gs :Gstatus<CR>

" File types {{{1
augroup filetype_ssh
  autocmd!
  au BufNewFile,BufRead */.ssh/config.d/*.ssh setf sshconfig
augroup END

augroup filetype_ruby
  autocmd!
  autocmd Filetype ruby setlocal shiftwidth=2 sts=2 expandtab textwidth=80
augroup END
let g:ruby_space_errors = 1
