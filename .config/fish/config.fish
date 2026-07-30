if status is-interactive
    # Commands to run in interactive sessions can go here
	set -gx EDITOR nvim
	if uwsm check may-start
	    exec uwsm start hyprland.desktop
	end
	abbr -a hlua nvim ~/.config/hypr/hyprland.lua
	fish_vi_key_bindings
end
set -U fish_greeting
# eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
zoxide init fish | source
set -gx BUN_INSTALL "$HOME/.bun"
fish_add_path $HOME/.bun/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin

function starship_transient_rprompt_func
  starship module time
end
starship init fish | source
enable_transience
# Make sure you initialize and enable transience at the end of the file
starship init fish | source
enable_transience
