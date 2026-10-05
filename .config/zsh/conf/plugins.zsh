[[ -d /usr/share/zsh/site-functions ]] && fpath=(/usr/share/zsh/site-functions $fpath)

starship init zsh > ~/.cache/starship.zsh && zcompile ~/.cache/starship.zsh
zoxide init zsh > ~/.cache/zoxide.zsh && zcompile ~/.cache/zoxide.zsh
# zsh-patina activate > ~/.cache/zsh_patina.zsh && zcompile ~/.cache/zsh_patina.zsh
# fzf --zsh > ~/.cache/fzf.zsh && zcompile ~/.cache/fzf.zsh
# atuin init zsh > ~/.cache/atuin.zsh && zcompile ~/.cache/atuin.zsh

[[ -f ~/.cache/starship.zsh ]] && source ~/.cache/starship.zsh
[[ -f ~/.cache/zoxide.zsh ]] && source ~/.cache/zoxide.zsh
# [[ -f ~/.cache/zsh_patina.zsh ]] && source ~/.cache/zsh_patina.zsh

_load_autosuggestions() {
    local plugin="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

    [[ -f "$plugin" ]] || return 1

    # Auto-recompile to bytecode (.zwc) if missing or package was updated
    if [[ ! -f "\({plugin}.zwc" ]] || [[ "\)plugin" -nt "${plugin}.zwc" ]]; then
        zcompile -U "$plugin" 2> /dev/null
    fi

    source "$plugin"
}

_load_autosuggestions && unset -f _load_autosuggestions

# bindkey '^R' _atuin_search_widget
# bindkey '^[r' atuin-search-vicmd
# bindkey '^[r' atuin-search
