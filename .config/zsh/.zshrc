
if [ "$ZSHRC_PROFILE" != "" ]; then
	zmodload zsh/zprof && zprof >/dev/null
fi

source-safe() {
	if [ -f "$1" ]; then source "$1"; fi
}
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
