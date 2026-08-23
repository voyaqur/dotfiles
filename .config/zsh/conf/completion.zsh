#==============================================================#
##          Completion                                        ##
#==============================================================#

setopt prompt_subst # Pass escape sequence (environment variable) through prompt

# see http://zsh.sourceforge.net/Doc/Release/Completion-System.html

# :completion:function:completer:command:argument:tag

# Show explanation part with optional completion
zstyle ':completion:*' verbose yes
# Set the completion method. Execute in the specified order.
## _oldlist: Reuse previous completion results.
## _complete: normal completion function
## _ignored: Specify that the command is not a candidate for completion.
## _match: Completion of commands with globs such as *.
## _prefix: Ignore everything after the cursor and complete up to the cursor position.
## _approximate: Similar completion candidates are also completion candidates.
## _expand: Expand globs and variables. It allows finer control than the original expansion.
## _history: Completion from history. Used from _history_complete_word.
## _correct: Correct misspellings before completion.
zstyle ':completion:*' completer _oldlist _complete _ignored
zstyle ':completion:*:messages' format '%F{yellow}%d'
zstyle ':completion:*:warnings' format '%B%F{red}No matches for:''%F{white}%d%b'
zstyle ':completion:*:descriptions' format '%B%F{white}--- %d ---%f%b'
zstyle ':completion:*:corrections' format ' %F{green}%d (errors: %e) %f'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' recent-dirs-insert both
# Color-code the completion candidates (Adapted from GNU ls color definitions)
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' special-dirs true
# Case insensitive when completing (but if uppercase letters are typed, they are not converted to lowercase)
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
# Some command line definitions take longer to unpack
# apt-get, dpkg (Debian), rpm (Redhat), urpmi (Mandrake), perl's -M option,
# bogofilter (zsh 4.2.1 or later), fink, mac_apps (MacOS X)(zsh 4.2.2 or later)
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
# Select completion candidates with ←↓↑→ (completion candidates are displayed in different colors)
# zstyle show completion menu if 1 or more items to select
zstyle ':completion:*:default' menu select=1
# Candidate directories on cdpath only if there is no candidate in the current directory
zstyle ':completion:*:cd:*' tag-order local-directories path-directories
# Specify order of completion list
zstyle ':completion:*:cd:*' group-order local-directories path-directories
# completion of ps command
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
# completion of sudo command
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
# complete variable subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
# display man completion by section number
zstyle ':completion:*:manuals' separate-sections true
# Display man completions in order of modification date
zstyle ':completion:*' file-sort 'modification'

# make completion is slow
zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:make::' tag-order targets:
zstyle ':completion:*:*:*make:*:targets' command awk \''/^[a-zA-Z0-9][^\/\t=]+:/ {print $1}'\' \$file
zstyle ':completion:*:*:make:*:targets' ignored-patterns '*.o'
zstyle ':completion:*:*:*make:*:*' tag-order '!targets !functions !file-patterns'
zstyle ':completion:*:*:*make:*:*' avoid-completer '_files'

zstyle ':autocomplete:*' default-context ''
# '': Start each new command line with normal autocompletion.
# history-incremental-search-backward: Start in live history search mode.

zstyle ':autocomplete:*' delay 0.4 # number of seconds (float)
# 0:   Start autocompletion immediately when you stop typing.
# 0.4: Wait 0.4 seconds for more keyboard input before showing completions.

zstyle ':autocomplete:*' min-input 3 # number of characters (integer)
# 0: Show completions immediately on each new command line.
# 1: Wait for at least 1 character of input.

zstyle ':autocomplete:*' ignored-input '' # (extended) glob pattern
# '':     Always show completions.
# '..##': Don't show completions when the input consists of two or more dots.

# When completions don't fit on screen, show up to this many lines:
#zstyle ':autocomplete:*' list-lines 16  # (integer)
# NOTE: The actual amount shown can be less.
zstyle -e ':autocomplete:*' list-lines 'reply=( $(( LINES / 3 )) )'

zstyle ':autocomplete:history-search:*' list-lines 16 # int
# Show this many history lines when pressing ↑.

zstyle ':autocomplete:history-incremental-search-*:*' list-lines 16 # int
# Show this many history lines when pressing ⌃R or ⌃S.

zstyle ':autocomplete:*' insert-unambiguous no
# no:  (Shift-)Tab inserts top (bottom) completion.
# yes: Tab first inserts substring common to all listed completions (if any).

zstyle ':autocomplete:*' add-space \
    executables aliases functions builtins reserved-words commands

# Order in which completions are listed on screen, if shown at the same time:
zstyle ':completion:*:' tag-order '! history-words' -
zstyle ':completion:*:' group-order \
    expansions options \
    executables local-directories directories suffix-aliases \
    aliases functions builtins reserved-words commands

zstyle ':completion:*:complete:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ':completion:list-expand:*' completer _expand _complete _ignored
