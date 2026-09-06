set -g status-style "fg=#839496,bg=#002b36"
set -g mode-style "fg=#002b36,bg=#b58900,bold"
set -g message-style "fg=#002b36,bg=#b58900,bold"
set -g message-command-style "fg=#002b36,bg=#cb4b16,bold"
set -g pane-border-style "fg=#b58900"
set -g pane-active-border-style "fg=#b58900"

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

# Left section: Highlighted session badge using Solarized Yellow
set -g status-left "#[fg=#002b36,bg=#268bd3,bold] $os #S:#I.#P #[fg=#268bd3,bg=#002b36]"
setw -g window-status-activity-style "underscore,fg=#839496,bg=#002b36"
setw -g window-status-separator " "
setw -g window-status-style "NONE,fg=#586e75,bg=#002b36"
setw -g window-status-format '#[fg=#657b83,bg=#002b36] #I #[fg=#657b83] #[fg=#657b83]#W#F'
setw -g window-status-current-format '#[fg=#002b36,bg=#93a1a1]#[fg=#cb4b16,bg=#93a1a1,bold] #I #[fg=#93a1a1,bg=#b58900]#[fg=#002b36,bold] #W #[fg=#b58900,bg=#002b36]'
set -g status-right "#[fg=#002c38,bg=#002c38,bold]#[fg=#268bd3,bg=#002c38]#{prefix_highlight}#[fg=#268bd3,bg=#002b36]#[fg=#001014,bg=#268bd3,bold] #H@#(whoami) "
set -g @prefix_highlight_output_prefix "#[fg=#b28500]#[bg=#002c38]#[fg=#002c38]#[bg=#b28500]"
set -g @prefix_highlight_output_suffix ""
set -g @prefix_highlight_show_sync_mode 'on'
set -g @prefix_highlight_empty_has_affixes 'on'
set -g @prefix_highlight_show_copy_mode 'on'
