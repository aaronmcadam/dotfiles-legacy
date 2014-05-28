# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="aaron"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

plugins=(tmux git git-flow git-extras brew osx jira syntax-highlighting git-flow-completion zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
autoload -U colors && colors
setopt auto_cd
cdpath=($HOME/Workspace $HOME/Workspace/code $HOME/Workspace/work $HOME)

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# enable colored output from ls, etc
export CLICOLOR=1

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# ruby GC performance
export RUBY_GC_HEAP_INIT_SLOTS=600000
export RUBY_GC_HEAP_FREE_SLOTS=600000
export RUBY_GC_HEAP_GROWTH_FACTOR=1.25
export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=300000

# Load dotfiles scripts
export PATH="$HOME/.bin:$PATH"

# Load direnv
eval "$(direnv hook zsh)"

# Add RVM to PATH for scripting
export PATH="$PATH:$HOME/.rvm/bin"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
