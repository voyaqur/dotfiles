set -g status-style "fg=#536971,bg=#fdf5e2"
set -g mode-style "fg=#fdf5e2,bg=#b58900,bold"
set -g message-style "fg=#fdf5e2,bg=#b58900,bold"
set -g message-command-style "fg=#fdf5e2,bg=#cb4b16,bold"
set -g pane-border-style "fg=#f4eecd"
set -g pane-active-border-style "fg=#268bd3"

os="#( \
  if [ \"$(uname)\" = 'Darwin' ]; then echo '󰀵'; \
  elif [ \"$(uname)\" = 'FreeBSD' ]; then echo ''; \
  elif grep -qi 'arch' /etc/os-release 2>/dev/null; then echo '󰣇'; \
  elif grep -qi 'void' /etc/os-release 2>/dev/null; then echo ''; \
  elif grep -qi 'ubuntu' /etc/os-release 2>/dev/null; then echo '󰕈'; \
  elif grep -qi 'debian' /etc/os-release 2>/dev/null; then echo '󰣚'; \
  elif grep -qi -e 'suse' -e 'opensuse' /etc/os-release 2>/dev/null; then echo ''; \
  elif grep -qi 'fedora' /etc/os-release 2>/dev/null; then echo ''; \
  elif grep -qi 'nixos' /etc/os-release 2>/dev/null; then echo ''; \
  elif grep -qi 'alpine' /etc/os-release 2>/dev/null; then echo ''; \
  elif grep -qi 'gentoo' /etc/os-release 2>/dev/null; then echo ''; \
  elif grep -qi 'raspbian' /etc/os-release 2>/dev/null; then echo ''; \
  elif grep -qi 'rocky' /etc/os-release 2>/dev/null; then echo ''; \
  elif grep -qi 'almalinux' /etc/os-release 2>/dev/null; then echo ''; \
  elif grep -qi 'centos' /etc/os-release 2>/dev/null; then echo ''; \
  elif grep -qi 'kali' /etc/os-release 2>/dev/null; then echo ''; \
  elif grep -qi 'mint' /etc/os-release 2>/dev/null; then echo '󰣭'; \
  elif grep -qi 'manjaro' /etc/os-release 2>/dev/null; then echo ''; \
  elif grep -qi 'microsoft' /proc/version 2>/dev/null || [ -n \"$WSL_DISTRO_NAME\" ]; then echo '󰍲'; \
  else echo ''; fi \
)"

# Left section: Highlighted session badge
set -g status-left "#[fg=#fdf5e2,bg=#268bd3,bold] $os #S:#I.#P #[fg=#268bd3,bg=#fdf5e2]"
setw -g window-status-activity-style "underscore,fg=#536971,bg=#fdf5e2"
setw -g window-status-separator " "
setw -g window-status-style "NONE,fg=#637981,bg=#fdf5e2"
setw -g window-status-format '#[fg=#637981,bg=#fdf5e2] #I #[fg=#637981] #[fg=#637981]#W#F'
setw -g window-status-current-format '#[fg=#fdf5e2,bg=#f4eecd]#[fg=#cb4b16,bg=#f4eecd,bold] #I #[fg=#f4eecd,bg=#b58900]#[fg=#fdf5e2,bold] #W #[fg=#b58900,bg=#fdf5e2]'
set -g @prefix_highlight_output_prefix "#[fg=#b28500]#[bg=#fdf5e2]#[fg=#fdf5e2]#[bg=#b28500]"
set -g @prefix_highlight_output_suffix ""
set -g @prefix_highlight_show_sync_mode 'on'
set -g @prefix_highlight_empty_has_affixes 'on'
set -g @prefix_highlight_show_copy_mode 'on'
set -g status-right "#[fg=#fdf5e2,bg=#fdf5e2]#[fg=#268bd3,bg=#fdf5e2,bold]#{prefix_highlight}#[fg=#268bd3,bg=#fdf5e2]#[fg=#fdf5e2,bg=#268bd3,bold]#H@#(whoami) "
