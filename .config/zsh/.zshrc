
if [ "$ZSHRC_PROFILE" != "" ]; then
	zmodload zsh/zprof && zprof >/dev/null
fi

source-safe() {
	if [ -f "$1" ]; then source "$1"; fi
}

# Only run fastfetch in interactive, top-level shells (avoids subshells/scripts)
# if [[ $- == *i* ]] && [[ -z "$TMUX" ]] && [[ "$SHLVL" -eq 1 ]]; then
	fastfetch --structure Title:Separator:OS:Host:Kernel:DateTime:Uptime:Packages:Shell:Processes:WM:LM:DE:Terminal:Editor:Memory:LocalIp:Locale:Break:Colors
# fi
source "$ZRCDIR/base.zsh"

source "$ZRCDIR/option.zsh"

source "$ZRCDIR/completion.zsh"

source "$ZRCDIR/prompt.zsh"

source "$ZRCDIR/functions.zsh"

source "$ZRCDIR/plugins.zsh"

source "$ZRCDIR/post.zsh"

source-safe "$ZHOMEDIR/.zshrc.local"

if [ -n "$ZSHRC_CI_TEST" ]; then
	echo "zshrc load complete"
	exit
fi
