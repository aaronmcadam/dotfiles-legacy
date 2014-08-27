autoload -U colors && colors

# cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5
cdpath=($HOME/workspace $HOME/workspace/repos $HOME/workspace/work $HOME)

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

autoload -U promptinit && promptinit
prompt pure

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# use vim as the visual editor
# but still use emacs-style ZSH bindings
# to allow things like reverse-search (Ctrl-R) to work
# source: http://superuser.com/a/457401/147601
export VISUAL=vim
export EDITOR=$VISUAL
bindkey -e

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# ruby GC performance
export RUBY_GC_HEAP_INIT_SLOTS=600000
export RUBY_GC_HEAP_FREE_SLOTS=600000
export RUBY_GC_HEAP_GROWTH_FACTOR=1.25
export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=300000

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
