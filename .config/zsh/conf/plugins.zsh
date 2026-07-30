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

# --- tier 0: prompt, loads synchronously so there's no flicker ---
zinit ice as"command" from"gh-r" \
	atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
	atpull"%atclone" src"init.zsh"
zinit light starship/starship

# --- tier 0 (immediate turbo): lightweight libs with no ZLE deps ---
zinit wait'0' lucid \
	light-mode for @mafredri/zsh-async

# --- 0a: autosuggestions first — cheap, no dependency on compinit ---
zinit wait'0a' lucid \
	atload"source $ZHOMEDIR/plugs/zsh-autosuggestions.zsh" \
	light-mode for @zsh-users/zsh-autosuggestions

# --- 0b: completions + compinit — must finish before patina activates ---
zinit wait'0b' lucid as"completion" \
	atload"source $ZHOMEDIR/plugs/zsh-autocompletion.zsh; zicompinit; zicdreplay" \
	light-mode for @zsh-users/zsh-completions

# zinit ice as"program" from"gh-r" \
# 	pick"zsh-patina-*/zsh-patina" \
# 	atclone"./zsh-patina completion > _zsh-patina" \
# 	atpull"%atclone" \
# 	atload'eval "$(zsh-patina activate)"' \
# 	wait'0c' lucid
# zinit light @michel-kraemer/zsh-patina
zinit ice as"program" from"gh-r" \
	pick"zsh-patina-*/zsh-patina" \
	atclone"./zsh-patina-*/zsh-patina completion > _zsh-patina" \
	atpull"%atclone" \
	atload'eval "$(zsh-patina activate)"' \
	wait'0c' lucid
zinit light michel-kraemer/zsh-patina
# --- 1: history-substring-search — after the highlighter/completions tier ---
zinit wait'1' lucid \
	light-mode for @zsh-users/zsh-history-substring-search


# --- 2: autopair last — purely cosmetic, least urgent ---
zinit wait'2' lucid \
	light-mode for @hlissner/zsh-autopair
