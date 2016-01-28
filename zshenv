# Sets up ssh-agent to forward key, supressing the output
ssh-add 2>/dev/null

source /usr/local/opt/chruby/share/chruby/chruby.sh
chruby 2.2.2

# Make sure homebrew installed apps take precedence over system apps
# Order path in the following order:
# dotfiles -> homebrew -> system path
export PATH="$HOME/.bin:$PATH"
export PATH="/usr/local/bin:$PATH"
# mkdir -p .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:${PATH}"
export PATH=/usr/texbin:"$PATH"

# Deduplicates PATH (https://github.com/thoughtbot/dotfiles/commit/f074afeae3cd9075c0cca1078bc7dfdaa447bc9f)
export -U PATH
