if [ "$ZSHRC_PROFILE" != "" ]; then
    zmodload zsh/zprof && zprof > /dev/null
fi

source-safe() {
    if [ -f "$1" ]; then source "$1"; fi
}

source "$ZRCDIR/base.zsh"
source "$ZRCDIR/cpfunc.zsh"
source "$ZRCDIR/completion.zsh"
source "$ZRCDIR/option.zsh"
source "$ZRCDIR/prompt.zsh"
source "$ZRCDIR/alias.zsh"
source "$ZRCDIR/functions.zsh"
source "$ZRCDIR/plugins.zsh"
source "$ZRCDIR/keybinds.zsh"

source-safe "$ZHOMEDIR/.zshrc.local"
