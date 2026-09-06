#==============================================================#
##          Prompt Configuration                              ##
#==============================================================#

###     git      ###

# Change % color by return code
#pct=$'%0(?||%147(?||%F{red}))%#%f'

# Left prompt
PROMPT='[%n@%m]${WINDOW:+"[$WINDOW]"}%# '
## <escape sequence>.
## If prompt_bang is enabled, then != current history event number, !! ='!' (literal)
# ${WINDOW:+"[$WINDOW]"} = screen number at runtime (prompt_subst is required)
# %B = underline
# %/ or %d = directory (0=all, -1=number from forward)
# %~ = directory
# %h or %! = current history event number
# %L = current $SHLVL value
# %M = full hostname of machine
# %m = first `.' of hostname
# %S (%s) = start (end) of background mode
# %U (%u) = start (end) of underline mode
# %B (%b) = start (end) of bold mode
# %t or %@ = current time in 12-hour format, am/pm
# %n or $USERNAME = user ($USERNAME is an environment variable and requires setopt prompt_subst)
# %N = shell name
# %i = number of line currently executed in script, source, or shell function given by %N (for debug)
# %T = current time in 24-hour format
# %* = current time in 24-hour format, with seconds
# %w = date in `day-day-of-week' format
# %W = date in `month/day/year' format
# %D = date in `year-month-day' format
# %D{string} = string formatted using the strftime function (man 3 strftime shows the format specification)
# %l = the terminal where the user is logged in, stripped of /dev/ prefix # %y = the terminal where the user is logged in, stripped of /dev/ prefix
# %y = user's login terminal without /dev/ prefix (/dev/tty* is sonoma)
# %? = return code of the command executed immediately before the prompt.
# %_ = parser status
# %E = clear to end of line
# %# = `#' if privileged shell is running, otherwise `%' == %(! #. %%)
# %v = value of first element of psvar array parameter
# %{... %} = include string as literal escape sequence
# %(x.true-text.false-text) = triplet expression
# %<string<, %>string>, %[xstring] = truncation behavior for the rest of the prompt
# `<' form truncates the left side of the string, `>' form truncates the right side of the string
# %c, %. , %C = backward component of $PWD

#PROMPT=ubst is required
# Right prompt

# ShellScript Debug
# PS4 for zsh script is overwritten by ~/.zshenv
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
export PROMPT4='+%N:%i> '
