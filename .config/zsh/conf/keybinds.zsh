bindkey -e #emacs
#bindkey -v     # vi 
# _fix_cursor() {
#    echo -ne '\e[5q'
# }
# precmd_functions+=(_fix_cursor)
autoload -Uz smart-insert-last-word
zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'

function cd-up { zle push-line && LBUFFER='builtin cd ..' && zle accept-line; }
zle -N cd-up
autoload -U edit-command-line
zle -N edit-command-line
zle -N show_buffer_stack
