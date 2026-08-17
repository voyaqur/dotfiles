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

_ZCOMPDUMP="${ZDATADIR}/.zcompdump"
zstyle -e '*:compinit' arguments '
	typeset -ga reply
	if [[ -n "${_ZCOMPDUMP}(#qN.mh+24)" ]]; then
		reply=( )     # dump missing or >24h old: full rebuild
	else
		reply=( -C )  # fresh dump: skip the security scan
	fi
'

zinit ice as"command" from"gh-r" \
	atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
	atpull"%atclone" src"init.zsh"
zinit light starship/starship

zinit wait'0' lucid \
	light-mode for @mafredri/zsh-async

zinit wait'0a' lucid \
	atload"source $ZHOMEDIR/plugs/zsh-autosuggestions.zsh" \
	light-mode for @zsh-users/zsh-autosuggestions

# Only adds _foo definition files to $fpath — no compinit call here.
# Must load before zsh-autocomplete (0b before 0c) so its files are
# already on $fpath when Autocomplete's internal compinit scans it.
zinit wait'0b' lucid as"completion" blockf \
	light-mode for @zsh-users/zsh-completions

zinit wait'0c' lucid \
	atinit"zcompile -R $ZHOMEDIR/plugs/zsh-autocomplete_atinit.zsh 2>/dev/null; source $ZHOMEDIR/plugs/zsh-autocomplete_atinit.zsh" \
	atload"zcompile -R $ZHOMEDIR/plugs/zsh-autocomplete_atload.zsh 2>/dev/null; source $ZHOMEDIR/plugs/zsh-autocomplete_atload.zsh" \
	light-mode for @marlonrichert/zsh-autocomplete

zinit wait'1' lucid \
	light-mode for @zsh-users/zsh-history-substring-search

zinit wait'2' lucid \
	light-mode for @hlissner/zsh-autopair

zinit ice as"program" from"gh-r" \
	pick"zsh-patina-*/zsh-patina" \
    atclone"./zsh-patina-*/zsh-patina completion > _zsh-patina" \
    atpull"%atclone" \
    atload'eval "$(zsh-patina activate)"' \
	wait'0c' lucid
zinit light @michel-kraemer/zsh-patina
