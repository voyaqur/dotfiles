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
zle -N edit-command-line
zle -N show_buffer_stack

autoload -U edit-command-line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# bindkey $key[Control - Space] list-expand
# list-expand:      Reveal hidden completions.
# set-mark-command: Activate text selection.

#bindkey -M menuselect $key[Return] .accept-line
# .accept-line: Accept command line.
# accept-line:  Accept selection and exit menu.
# bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
# bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
