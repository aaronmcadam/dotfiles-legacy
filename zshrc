autoload -U colors && colors
setopt auto_cd
cdpath=($HOME/Workspace $HOME/Workspace/code $HOME/Workspace/work $HOME)

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

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# ruby GC performance
export RUBY_GC_HEAP_INIT_SLOTS=600000
export RUBY_GC_HEAP_FREE_SLOTS=600000
export RUBY_GC_HEAP_GROWTH_FACTOR=1.25
export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=300000

# rbenv
export RBENV_ROOT="${HOME}/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init - --no-rehash)"
fi

# Load direnv
eval "$(direnv hook zsh)"

# Load dotfiles scripts
export PATH="$HOME/.bin:$PATH"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
