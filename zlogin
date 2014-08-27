# Sets up ssh-agent to forward key, supressing the output
ssh-add 2>/dev/null

# Make sure homebrew's installs apps take precedence over system apps
export PATH="/usr/local/bin:${PATH}"

# Load scripts
export PATH="$HOME/.bin:${PATH}"

export RBENV_ROOT="${HOME}/.rbenv"
if [ -d "${RBENV_ROOT}" ]; then
  export PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init - zsh --no-rehash)"
fi

# mkdir -p .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:${PATH}"
