# autoload -U colors && colors

# cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5
cdpath=($HOME/workspace/work/apps $HOME/workspace/work/gems $HOME)

# completion
autoload -U compinit
compinit

# load our own completion functions
fpath=(~/.zsh/completion $fpath)
autoload -Uz ~/.zsh/completion/*(:t)

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

export GIT_RADAR_COLOR_LOCAL_AHEAD="%F{yellow}"
export GIT_RADAR_COLOR_LOCAL_BEHIND="%F{yellow}"
export GIT_RADAR_COLOR_LOCAL_DIVERGED="%F{yellow}"
export GIT_RADAR_COLOR_REMOTE_AHEAD="%F{yellow}"
export GIT_RADAR_COLOR_REMOTE_BEHIND="%F{yellow}"
export GIT_RADAR_COLOR_REMOTE_DIVERGED="%F{yellow}"
source ~/.zsh/prompts/slimline/slimline.zsh

# enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

export VISUAL=nvim
export EDITOR=$VISUAL

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# ruby GC performance
export RUBY_GC_HEAP_INIT_SLOTS=600000
export RUBY_GC_HEAP_FREE_SLOTS=600000
export RUBY_GC_HEAP_GROWTH_FACTOR=1.25
export RUBY_GC_HEAP_GROWTH_MAX_SLOTS=300000

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

eval "$(direnv hook zsh)"

autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
export KEYTIMEOUT=1

export FZF_DEFAULT_COMMAND='ag -l -g "" --hidden'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
