# Sets up ssh-agent to forward key, supressing the output
ssh-add 2>/dev/null

# Make sure homebrew installed apps take precedence over system apps
# Order path in the following order:
# dotfiles | homebrew | system path
export PATH="$HOME/.bin:/usr/local/bin:$PATH"

source /usr/local/opt/chruby/share/chruby/chruby.sh
chruby 2.3.0
source /usr/local/opt/chruby/share/chruby/auto.sh

# mkdir -p .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:${PATH}"

export PATH=/usr/texbin:"$PATH"
