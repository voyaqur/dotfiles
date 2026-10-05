# zmodload zsh/zprof
if [ "$ZSHRC_PROFILE" != "" ]; then
    zmodload zsh/zprof && zprof > /dev/null
fi

# source-safe() {
#     if [ -f "$1" ]; then source "$1"; fi
# }

source "$ZRCDIR/base.zsh"
source "$ZRCDIR/cpfunc.zsh"
source "$ZRCDIR/completion.zsh"
source "$ZRCDIR/option.zsh"
source "$ZRCDIR/prompt.zsh"
source "$ZRCDIR/alias.zsh"
source "$ZRCDIR/functions.zsh"
source "$ZRCDIR/keybinds.zsh"
source "$ZRCDIR/plugins.zsh"

# source-safe "$ZHOMEDIR/.zshrc.local"
setopt local_options

local zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
local zcomp_ttl=1    # how many days to let the zcompdump file live before it must be recompiled
local lock_timeout=1 # register an error if lock-timeout exceeded
local lockfile="${zcompdump}.lock"

autoload -Uz compinit

# check for lockfile — if the lockfile exists, we cannot run a compinit
#   if no lockfile, then we will create one, and set a trap on EXIT to remove it;
#   the trap will trigger after the rest of the function has run.
if [ -f "${lockfile}" ]; then

    # error log if the lockfile outlived its timeout
    # if [ "$(find "${lockfile}" -mmin $lock_timeout)" ]; then
    #     (
    #         echo "${lockfile} has been held by $(< ${lockfile}) for longer than ${lock_timeout} minute(s)."
    #         echo "This may indicate a problem with compinit"
    #     ) >&2
    # fi

    # since the zcompdump is still locked, run compinit without generating a new dump
    compinit -D -d "$zcompdump"

    # Exit if there's a lockfile; another process is handling things
    return 1

else

    # Create the lockfile with this shell's PID for debugging
    echo $$ > "${lockfile}"

    # Ensure the lockfile is removed on exit
    trap "rm -f '${lockfile}'" EXIT

fi

# refresh the zcompdump file if needed
if [ ! -f "$zcompdump" -o "$(find "$zcompdump" -mtime "+${zcomp_ttl}")" ]; then
    # if the zcompdump is expired (past its ttl) or absent, we rebuild it
    compinit -d "$zcompdump"

else

    # load the zcompdump without updating
    compinit -CD -d "$zcompdump"

    # asynchronously rebuild the zcompdump file
    (
        autoload -Uz compinit
        compinit -d "$zcompdump" &
    )

fi
zcompile_recursive() {
    local target_dir="\({1:-\){ZDOTDIR:-$HOME/.config/zsh}}"
    local zwc_file file

    # 1. Recursively find and compile .zshrc and any .zsh / .zsh-theme files
    for file in "\(HOME/.zshrc" "\)target_dir"/**/*.(zsh|zsh-theme|sh)(N); do
        [[ -f "$file" ]] || continue
        zwc_file="${file}.zwc"

        # Recompile if .zwc is missing OR source file is newer than .zwc
        if [[ ! -f "\(zwc_file" || "\)file" -nt "$zwc_file" ]]; then
            zcompile "$file"
        fi
    done

    # 2. Clean up orphan .zwc files whose original source files no longer exist
    for zwc_file in "$target_dir"/**/*.zwc(N); do
        file="${zwc_file%.zwc}"
        if [[ ! -f "$file" ]]; then
            rm -f "$zwc_file"
        fi
    done
}

zcompile_recursive
# zprof
