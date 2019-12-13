" vim: fdm=marker
if &compatible
  set nocompatible
endif

exec 'source' fnamemodify($MYVIMRC, ':h') . '/basic.vim'
