#==============================================================#
## Setup zinit                                                ##
#==============================================================#
# cSpell:disable
if [ -z "$ZPLG_HOME" ]; then
	ZPLG_HOME="$ZDATADIR/zinit"
fi

if ! test -d "$ZPLG_HOME"; then
	mkdir -p "$ZPLG_HOME"
	chmod g-rwX "$ZPLG_HOME"
	git clone --depth 10 https://github.com/zdharma-continuum/zinit.git "${ZPLG_HOME}/bin"
fi

typeset -gAH ZPLGM
ZPLGM[HOME_DIR]="${ZPLG_HOME}"
source "$ZPLG_HOME/bin/zinit.zsh"
autoload -Uz _zinit
((${+_comps})) && _comps[zinit]=_zinit # shuck: ignore=C006 # zinit is an assoc-array key here

zinit wait'0b' lucid \
	atload"source $ZHOMEDIR/plugs/zsh-autosuggestions.zsh" \
	light-mode for @zsh-users/zsh-autosuggestions

# zinit wait'0c' lucid nocompletions \
# 	atinit"source $ZHOMEDIR/plugs/zsh-autocomplete_atinit.zsh" \
# 	atload"source $ZHOMEDIR/plugs/zsh-autocomplete_atload.zsh" \
# 	light-mode for @marlonrichert/zsh-autocomplete

zinit wait'0b' lucid as"completion" \
	atload"source $ZHOMEDIR/plugs/zsh-autocompletion.zsh; zicompinit; zicdreplay" \
	light-mode for @zsh-users/zsh-completions

zinit wait'0a' lucid \
	if"(( ${ZSH_VERSION%%.*} > 4.4))" \
	atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
	atload"source $ZHOMEDIR/plugs/fast-syntax-highlighting.zsh" \
	light-mode for @zdharma-continuum/fast-syntax-highlighting

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit wait'1' lucid \
	light-mode for @zsh-users/zsh-history-substring-search

zinit wait'0' lucid \
	light-mode for @mafredri/zsh-async


zinit wait'2' lucid \
	light-mode for @hlissner/zsh-autopair

