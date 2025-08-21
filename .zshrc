# zmodload zsh/zprof
#
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="buehmann"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(aws git colored-man-pages evalcache)

source $ZSH/oh-my-zsh.sh

# User configuration
setopt share_history

# export MANPATH="/usr/local/man:$MANPATH"
export MANPATH="$HOME/share/man:$MANPATH"

# GNU utils on Mac OS (brew)
if (( $+commands[brew] )); then
  gnu=(coreutils gnu-tar grep gnu-sed findutils)
  for g in ${gnu[@]}; do
    utils=$HOMEBREW_PREFIX/opt/$g/libexec
    if [[ -d $utils ]]; then
      export MANPATH=$utils/gnuman:$MANPATH
      export PATH=$utils/gnubin:$PATH
    fi
  done
fi

export PATH=$HOME/dev/scheduler_tools/bin:$PATH
export PATH=$HOME/bin:$PATH

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi
export EDITOR=nvim

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias be="bundle exec"
alias diff="colordiff"
alias vim=nvim
alias vimdiff="nvim -d"
alias view="nvim -R"
alias b="bc -lq"

function dotfiles() (
  export GIT_DIR=~/.dotfiles GIT_WORK_TREE=~
  if (($# == 0)); then
    "$SHELL"
  else
    git "$@"
  fi
)

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
(( $+commands[dircolors] )) && _evalcache dircolors -b
ls --color -d . &>/dev/null && alias ls='ls --color=tty' || { ls -G . &>/dev/null && alias ls='ls -G' }

# Take advantage of $LS_COLORS for completion as well.
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh

# rbenv shell integration
_evalcache rbenv init --no-rehash - zsh

# perl5 config for Homebrew
if (( $+commands[brew] )); then
  _evalcache perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5
fi

# https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

if (( $+commands[pyenv] )); then
  eval "$(pyenv init -)"
fi

# http(ie): Python Requests
if (( $+commands[brew] )); then
  export REQUESTS_CA_BUNDLE=$HOMEBREW_PREFIX/etc/ca-certificates/cert.pem
fi

# httpless example.org
# httpsless example.org
function _httpless {
  local cmd="$1"; shift
  "$cmd" --pretty=all --print=hb "$@" | less -R
}
alias httpless="_httpless http"
alias httpsless="_httpless https"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C terraform terraform

# zprof
