# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="buehmann"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

BUNDLED_COMMANDS=(rubocop)

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git github ruby rails bundler docker docker-compose colored-man-pages)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
export MANPATH="$HOME/share/man:$MANPATH"

# GNU utils on Mac OS (brew)
gnu=(coreutils gnu-tar grep gnu-sed findutils)
for g in ${gnu[@]}; do
  utils=/usr/local/opt/$g/libexec
  if [[ -d $utils ]]; then
    export MANPATH=$utils/gnuman:$MANPATH
    export PATH=$utils/gnubin:$PATH
  fi
done

if (( $+commands[brew] )); then
  export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
fi
export PATH=$HOME/dev/scheduler_tools/bin:$PATH
export PATH=$HOME/dev/deploy-tools/bin:$PATH
# export PATH=$HOME/.rbenv/shims:$PATH
export PATH=$HOME/bin:$PATH

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR=nvim

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias be="bundle exec"
alias co="c|o"
alias diff="colordiff"
alias vim=nvim
alias vimdiff="nvim -d"
alias view="nvim -R"
alias b="bc -lq"

alias dotfiles="GIT_DIR=~/.dotfiles GIT_WORK_TREE=~ git"
alias .f=dotfiles
# dotfiles config status.showUntrackedFiles no
# dotfiles remote add buehmann git@github.com:buehmann/dotfiles.git

cdpath=~/dev

# map non-breaking space (alt-shift) to space
bindkey -s "\M-B\M- " " "
bindkey -r "\M-B"

export GITHUB_HOST=github.fidor.de
export GIT=hub
export LESS="-FRX"
export ENABLE_BOOTSNAP=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta,bold'

# anonymous function for scoping of local variables
function {
  local prefix syntax
  for prefix in /usr/{local/,}share; do
    syntax=$prefix/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    if [[ -r $syntax ]]; then
      source "$syntax"
      break
    fi
  done
}

# ls coloring (defaults in .oh-my-zsh/lib/theme-and-appearance.zsh do not recognize GNU ls on Mac)
(( $+commands[dircolors] )) && eval "$(dircolors -b)"
ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }

# Take advantage of $LS_COLORS for completion as well.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh

# Delete Git's official completions to allow Zsh's official Git completions to work.
# This is also necessary for hub's Zsh completions to work:
# https://github.com/github/hub/issues/1956.
function () {
  (( $+commands[brew] )) || return
  GIT_ZSH_COMPLETIONS_FILE_PATH="$(brew --prefix)/share/zsh/site-functions/_git"
  if [ -f $GIT_ZSH_COMPLETIONS_FILE_PATH ]
  then
    rm $GIT_ZSH_COMPLETIONS_FILE_PATH
  fi
}

# rbenv shell integration
eval "$(rbenv init -)"
