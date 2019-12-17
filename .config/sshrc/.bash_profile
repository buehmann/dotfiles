if [[ -r $SSHRC_HOME/.bashrc ]]; then
  . "$SSHRC_HOME/.bashrc"
fi

PATH=$PATH:$SSHRC_ROOT/bin
