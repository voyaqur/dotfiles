fpath=(/usr/share/zsh/site-functions $fpath)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_STRATEGY=(history)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
# ZSH_HIGHLIGHT_STYLES[comment]='fg=cyan'
## Starship cache
# autoload -Uz predict-on && predict-on
if [[ ! -f ~/.cache/starship_init.zsh ]]; then
    starship init zsh > ~/.cache/starship_init.zsh
fi

# Zoxide cache
if [[ ! -f ~/.cache/zoxide_init.zsh ]]; then
    zoxide init zsh > ~/.cache/zoxide_init.zsh
fi

if [[ ! -f ~/.cache/fzf_init.zsh ]]; then
    fzf --zsh > ~/.cache/fzf_init.zsh
fi

if [[ ! -f ~/.cache/atuin_init.zsh ]]; then
    atuin init zsh > ~/.cache/atuin_init.zsh
fi
source ~/.cache/starship_init.zsh
source ~/.cache/zoxide_init.zsh
source ~/.cache/fzf_init.zsh
source ~/.cache/atuin_init.zsh
bindkey '^R' _atuin_search_widget
# bindkey '^[r' atuin-search-vicmd
# bindkey '^[r' atuin-search
