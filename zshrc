# cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5
cdpath=($HOME/workspace/code/apps $HOME/workspace/code/gems $HOME)

# completion
autoload -U compinit
compinit

# prompt
autoload -U promptinit && promptinit
prompt pure

# load our own completion functions
fpath=(~/.zsh/completion $fpath)
autoload -Uz ~/.zsh/completion/*(:t)

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

export VISUAL=nvim
export EDITOR=$VISUAL

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

eval "$(direnv hook zsh)"

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

bindkey -e
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
export KEYTIMEOUT=1
# Source: https://github.com/beefsack/zsh-simplicity/blob/master/input.zsh
stty -ixon
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kich1]}" overwrite-mode
bindkey "${terminfo[kdch1]}" delete-char
bindkey "${terminfo[kcuu1]}" up-line-or-history
bindkey "${terminfo[kcud1]}" down-line-or-history
bindkey "${terminfo[kcub1]}" backward-char
bindkey "${terminfo[kcuf1]}" forward-char

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
