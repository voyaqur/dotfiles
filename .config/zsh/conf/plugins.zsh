# Cache starship init output
fpath=(/usr/share/zsh/site-functions $fpath)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# if [[ ! -f ~/.cache/starship_init.zsh ]]; then
#     starship init zsh > ~/.cache/starship_init.zsh
# fi

# source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh 2> /dev/null
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2> /dev/null
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[comment]='fg=cyan,bold'
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(zsh-patina activate)"
eval "$(starship init zsh)"
