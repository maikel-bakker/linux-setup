# Managed by linux-setup. Apply with scripts/apply-zsh-config.

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
else
  print -u2 'Oh My Zsh is not installed; run scripts/install-zsh-framework.'
fi

# Enable Homebrew only on machines where it is installed.
if command -v brew > /dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

# Keep the short Codex command when the Node.js runner is available.
if command -v npx > /dev/null 2>&1; then
  alias codex='npx codex'
fi
