# Managed by linux-setup. Apply with scripts/apply-zsh-config.

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
export PATH="$HOME/.local/bin:$PATH"

if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
else
  print -u2 'Oh My Zsh is not installed; run scripts/install-zsh-framework.'
fi
