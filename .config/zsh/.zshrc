if [ "$ZSHRC_PROFILE" != "" ]; then
	zmodload zsh/zprof && zprof >/dev/null
fi

source-safe() {
	if [ -f "$1" ]; then source "$1"; fi
}

# if [[ $- == *i* ]] && [[ -z "$TMUX" ]] && [[ "$SHLVL" -eq 1 ]]; then
# fi
source "$ZRCDIR/base.zsh"

source "$ZRCDIR/option.zsh"

source "$ZRCDIR/completion.zsh"

source "$ZRCDIR/prompt.zsh"

source "$ZRCDIR/alias.zsh"

source "$ZRCDIR/functions.zsh"

source "$ZRCDIR/plugins.zsh"

source "$ZRCDIR/keybinds.zsh"

source "$ZRCDIR/post.zsh"

source-safe "$ZHOMEDIR/.zshrc.local"
if [ -n "$ZSHRC_CI_TEST" ]; then
	echo "zshrc load complete"
	exit
fi
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
#
# if [[ $- == *i* ]] && [[ -z "$VIMRUNTIME" ]] && (( $+commands[fish] )); then
#   exec fish
# fi
export PATH=$PATH:/home/voya/.spicetify

### Added by Zinit's installer
### End of Zinit's installer chunk
