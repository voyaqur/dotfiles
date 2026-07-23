bindkey -v
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 == 'block' ]]; then
    echo -ne '\e[2q' # Solid block cursor for Normal mode
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} == '' ]] ||
       [[ $1 == 'beam' ]]; then
    echo -ne '\e[5q' # Steady beam cursor for Insert mode
  fi
}
zle -N zle-keymap-select

_fix_cursor() {
   echo -ne '\e[5q'
}
precmd_functions+=(_fix_cursor)
# Allow backspace to delete past insertion point
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char

bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd '?' history-incremental-search-forward

autoload -Uz smart-insert-last-word
zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'

zmodload zsh/complist
bindkey '^[[Z' reverse-menu-complete
bindkey -M menuselect '^[[Z' reverse-menu-complete

## edit ##
bindkey '^[u' undo
bindkey '^[r' redo

# edit command-line using editor (like fc command)
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

bindkey '^X*' expand-word
# stack command
zle -N show_buffer_stack
bindkey '^Q' show_buffer_stack
