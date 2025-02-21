if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.bats         setfiletype sh
  au! BufRead,BufNewFile *.tf           setfiletype tf
augroup END
