#
# ~/.zprofile
#
if uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
# ~/.zprofile
# --- Default Applications ---
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="bat --style=plain"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"  # Syntax-highlighted man pages using bat

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

typeset -U path  # Keep PATH entries unique (prevents duplicates)

path=(
  "$HOME/.local/bin"         # User binaries & custom scripts
  "$HOME/.cargo/bin"         # Rust binaries (eza, bat, yazi, zoxide, ripgrep)
	"$HOME/.rustowl"
  $path
)
export PATH
