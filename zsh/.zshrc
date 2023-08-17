[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# history
HISTFILE=~/.zsh_history

# source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/path.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"

# plugins
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "zap-zsh/exa"
plug "chitoku-k/fzf-zsh-completions"
plug "Aloxaf/fzf-tab"
plug "zsh-users/zsh-syntax-highlighting"

# source completion
plug "$HOME/.config/zsh/completion.zsh"

eval "$(zoxide init zsh)"
# eval "$(starship init zsh)"

# keybinds
bindkey '^ ' autosuggest-accept

if command -v bat &> /dev/null; then
    alias cat="bat -pp --theme \"Visual Studio Dark+\""
    alias catt="bat --theme \"Visual Studio Dark+\""
fi


