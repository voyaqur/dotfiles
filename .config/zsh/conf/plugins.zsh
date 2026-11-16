[[ -d /usr/share/zsh/site-functions ]] && fpath=(/usr/share/zsh/site-functions $fpath)

starship init zsh > ~/.cache/starship.zsh && zcompile ~/.cache/starship.zsh
zoxide init zsh > ~/.cache/zoxide.zsh && zcompile ~/.cache/zoxide.zsh
# zsh-patina activate > ~/.cache/zsh_patina.zsh && zcompile ~/.cache/zsh_patina.zsh
# fzf --zsh > ~/.cache/fzf.zsh && zcompile ~/.cache/fzf.zsh
# atuin init zsh > ~/.cache/atuin.zsh && zcompile ~/.cache/atuin.zsh

[[ -f ~/.cache/starship.zsh ]] && source ~/.cache/starship.zsh
[[ -f ~/.cache/zoxide.zsh ]] && source ~/.cache/zoxide.zsh
# [[ -f ~/.cache/zsh_patina.zsh ]] && source ~/.cache/zsh_patina.zsh

# bindkey '^R' _atuin_search_widget
# bindkey '^[r' atuin-search-vicmd
# bindkey '^[r' atuin-search
