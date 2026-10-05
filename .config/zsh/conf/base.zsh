#==============================================================#
##          Base Configuration                                ##
#==============================================================#

HOSTNAME="$HOST"
HISTFILE="${ZDATADIR}/zsh_history"
HISTSIZE=10000  # Number of histories in memory
SAVEHIST=100000 # Number of histories to be saved
HISTORY_IGNORE="(ls|cd|pwd|zsh|exit|cd ..)"
ZSH_DISABLE_COMPFIX=true
LISTMAX=1000 # number of completion listings to ask for (1=shut up, 0=ask when window overflows)
# KEYTIMEOUT=1 # conflict with zsh-autocomplete
typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=1
typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
typeset -g ZSH_AUTOSUGGEST_MINIMUM_PREFIX_LEN=2
typeset -g ZSH_AUTOSUGGEST_STRATEGY=(history completion)
typeset -g ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# Do not add root commands to history
# if [ "$UID" = 0 ]; then
#   unset HISTFILE
#   SAVEHIST=0
# fi

# delete word by word with C-w when typing ls /usr/local/etc etc.
# default : ls /usr/local → ls /usr/ → ls /usr → ls /usr → ls /
# this setting : ls /usr/local → ls /usr/ → ls /usr/ → ls /
WORDCHARS='*?_-[]~&;!#$%^(){}<>|'

# List of directories to be searched by cd if there are no subdirectories in the current directory
cdpath=("$HOME" .. $HOME/*(N-/) $HOME/.config)

# autoload
# autoload -Uz run-help
# autoload -Uz add-zsh-hook
# autoload -Uz add-zsh-hook colors && colors
# define in post execution. because compinit is slow and plugin manager automatic load compinit.

# Unset the temporary wrapper and process queued calls
# unset -f compdef
# for cmd in "$_compdef_queue[@]"; do
#     eval "compdef $cmd"
# done
# unset _compdef_queue

# Call compinit ONCE with -C to bypass security checks on cached runs
# core
ulimit -c unlimited

# Permissions when creating files
umask 022

export DISABLE_DEVICONS=false

# Report CPU usage for commands running longer than 10 seconds
#REPORTTIME=10
#
#
