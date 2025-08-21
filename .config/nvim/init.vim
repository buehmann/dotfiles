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
Plug 'kana/vim-textobj-lastpat'
Plug 'kana/vim-textobj-user'
Plug 'machakann/vim-highlightedyank'
Plug 'mhartington/oceanic-next'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'neomake/neomake'
Plug 'pearofducks/ansible-vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/confluencewiki.vim', { 'for': 'confluencewiki' }
Plug 'hashivim/vim-terraform'

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

call plug#end()

" End plugin setup }}}1

exec 'source' fnamemodify($MYVIMRC, ':h') . '/basic.vim'

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

let g:fugitive_gitlab_domains = ['https://innersource.soprasteria.com']
let g:github_enterprise_urls = ['https://github.fidor.de']
let g:is_bash = 1

let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_ruby_rubocop_exe = 'be-rubocop'

let g:neomake_sh_enabled_makers = ['shellcheck'] " disable 'sh'

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

set noshowmode " displayed in airline

set clipboard+=unnamedplus

" Grepping {{{1
" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

nnoremap gr :Ggrep <cword><CR>:cw<CR>
nnoremap gR :Ggrep '\b<cword>\b'<CR>:cw<CR>

" Basic mappings {{{1
noremap <Esc> :nohl<CR>

map <C-n> :NERDTreeToggle<CR>

noremap <leader>gb :Git blame<CR>
noremap <leader>gh :GBrowse<CR>
noremap <leader>gs :Git<CR>
