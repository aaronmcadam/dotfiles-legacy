# Sets up ssh-agent to forward key, supressing the output
ssh-add 2>/dev/null

# Make sure homebrew installed apps take precedence over system apps
# Order path in the following order:
# dotfiles | homebrew | system path
export PATH="$HOME/.bin:/usr/local/bin:$PATH"

export RBENV_ROOT="${HOME}/.rbenv"
if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init - zsh --no-rehash)"
fi

# mkdir -p .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:${PATH}"
