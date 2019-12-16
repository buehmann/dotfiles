export VIMINIT='let $MYVIMRC = $SSHRC_HOME . "/.vimrc" | source $MYVIMRC'

if command -v vim > /dev/null; then
  export VISUAL=vim
else
  export VISUAL=vi
fi
export EDITOR=$VISUAL
export DBEDIT=$VISUAL # Informix dbaccess
