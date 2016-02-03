# Sets up ssh-agent to forward key, supressing the output
ssh-add 2>/dev/null

if [[ -e /usr/local/share/chruby ]]; then
  source '/usr/local/share/chruby/chruby.sh'
  source '/usr/local/share/chruby/auto.sh'
  if [[ -f ~/.ruby-version ]]; then
    chruby $(cat ~/.ruby-version)
  fi
fi

export PATH="$HOME/.bin:$PATH"

# Deduplicates PATH (https://github.com/thoughtbot/dotfiles/commit/f074afeae3cd9075c0cca1078bc7dfdaa447bc9f)
export -U PATH
