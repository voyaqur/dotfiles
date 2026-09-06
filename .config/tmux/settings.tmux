set -g default-terminal "tmux-256color"

set -as terminal-overrides ",*:RGB"
set -as terminal-overrides ",xterm*:Tc"
set -as terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[1 q'
# set -g allow-passthrough on
set -as terminal-overrides ",xterm*:smcup@:rmcup@"
set -as terminal-overrides ',xterm*:Cc=\E]12;%p1%s\b:Cr=\E]112\b:Cv=\E]12;yellow\b:Cbc'

set -s escape-time 10                  # Fast key escape time (good for Vim/Neovim)
set -s set-clipboard on                # OSC 52 system clipboard integration
set -g history-limit 50000             # Increase scrollback buffer size
set -g focus-events on                 # Pass focus events to terminal applications
set -g display-time 1000               # Message display time (ms)
# set -g word-separators " -_()@,[]{}:=/"
set -g mouse on                       # Disable mouse operation

# Environment variables
set-environment -g TMUX_DATA_DIR "${HOME}/.local/share/tmux"

set -g status-keys emacs               # Emacs keys in tmux command prompt
setw -g mode-keys vi                   # Vi keys in copy mode

set -g base-index 1                    # Start window numbering at 1
set -g pane-base-index 1               # Start pane numbering at 1
setw -g pane-base-index 1              # Keep window pane index consistent
set -g renumber-windows on             # Automatically renumber windows on close
set -g detach-on-destroy off           # Don't exit tmux when killing a session
setw -g aggressive-resize on           # Optimizes window sizing for multi-monitors
setw -g xterm-keys on                  # Allow arrow keys in pane navigation

set -g automatic-rename on
set -g set-titles on
set -g set-titles-string '#T'
set -g status on
set -g status-interval 5
setw -g monitor-activity on
set -g visual-activity off
set -g bell-action other
set -g visual-bell off
set -g pane-border-lines heavy
set -g status-position bottom
set -g status "on"
set -g status-justify "left"
set -g status-left-length "60"
set -g status-right-length "60"
