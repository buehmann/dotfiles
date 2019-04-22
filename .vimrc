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
  call dein#add('junegunn/fzf', { 'build': './install --all' })
  call dein#add('junegunn/fzf.vim')
  call dein#add('kana/vim-textobj-indent')
  call dein#add('kana/vim-textobj-user')
  call dein#add('machakann/vim-highlightedyank')
  call dein#add('mhartington/oceanic-next')
  call dein#add('nelstrom/vim-textobj-rubyblock')
  call dein#add('neomake/neomake')
  call dein#add('ngmy/vim-rubocop')
  call dein#add('scrooloose/nerdtree', { 'on_cmd': 'NERDTreeToggle' })
  call dein#add('tpope/vim-bundler')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-rhubarb')
  call dein#add('tpope/vim-surround')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-scripts/confluencewiki.vim', { 'on_ft': 'confluencewiki' })
  call dein#add('wincent/command-t')

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
noremap \ ,

if has('termguicolors')
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

set updatetime=1500
if has('signcolumn')
  set signcolumn=yes
endif

let g:github_enterprise_urls = ['https://github.fidor.de']
let g:is_bash = 1

let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_ruby_rubocop_exe = 'be-rubocop'
" if exists("*neomake#configure#automake")
  call neomake#configure#automake('rnw', 750)
" endif

let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

let g:NERDTreeQuitOnOpen = 1

let g:ctrlp_clear_cache_on_exit = 0
let g:CommandTFileScanner = 'git'

let g:vimrubocop_rubocop_cmd = 'bundle exec rubocop '

set title

" Indentation {{{1
set shiftwidth=2
set expandtab
set shiftround
" set smartindent
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

" set colorcolumn=+0
" hi ColorColumn guibg=black
" hi SignColumn guibg=black

" Grepping {{{1
" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

nnoremap gr :Ggrep <cword><CR>:cw<CR>
nnoremap gR :Ggrep '\b<cword>\b'<CR>:cw<CR>

" Diff {{{1
" https://github.com/tpope/vim-unimpaired/blob/11dc568dbfd7a56866a4354c737515769f08e9fe/plugin/unimpaired.vim#L100-L146

nmap [n <Plug>unimpairedContextPrevious
nmap ]n <Plug>unimpairedContextNext
omap [n <Plug>unimpairedContextPrevious
omap ]n <Plug>unimpairedContextNext

nnoremap <silent> <Plug>unimpairedContextPrevious :call <SID>Context(1)<CR>
nnoremap <silent> <Plug>unimpairedContextNext     :call <SID>Context(0)<CR>
onoremap <silent> <Plug>unimpairedContextPrevious :call <SID>ContextMotion(1)<CR>
onoremap <silent> <Plug>unimpairedContextNext     :call <SID>ContextMotion(0)<CR>

function! s:Context(reverse)
  call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', a:reverse ? 'bW' : 'W')
endfunction

function! s:ContextMotion(reverse)
  if a:reverse
    -
  endif
  call search('^@@ .* @@\|^diff \|^[<=>|]\{7}[<=>|]\@!', 'bWc')
  if getline('.') =~# '^diff '
    let end = search('^diff ', 'Wn') - 1
    if end < 0
      let end = line('$')
    endif
  elseif getline('.') =~# '^@@ '
    let end = search('^@@ .* @@\|^diff ', 'Wn') - 1
    if end < 0
      let end = line('$')
    endif
  elseif getline('.') =~# '^=\{7\}'
    +
    let end = search('^>\{7}>\@!', 'Wnc')
  elseif getline('.') =~# '^[<=>|]\{7\}'
    let end = search('^[<=>|]\{7}[<=>|]\@!', 'Wn') - 1
  else
    return
  endif
  if end > line('.')
    execute 'normal! V'.(end - line('.')).'j'
  elseif end == line('.')
    normal! V
  endif
endfunction

" }}}1
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

" File types
augroup filetype_ssh
  autocmd!
  au BufNewFile,BufRead */.ssh/config.d/*.ssh setf sshconfig
augroup END

augroup filetype_ruby
  autocmd!
  autocmd Filetype ruby setlocal shiftwidth=2 sts=2 expandtab textwidth=80
augroup END
let g:ruby_space_errors = 1

" Folding {{{1
" let g:xml_syntax_folding=1
