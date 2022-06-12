#!/usr/bin/env bash

if [ "$DARKMODE" == "0" ]; then
  tmux_theme_conf="$HOME/.tmux/plugins/tmux-gruvbox/tmux-gruvbox-light.conf"
else
  tmux_theme_conf="$HOME/.tmux/plugins/tmux-gruvbox/tmux-gruvbox-dark.conf"
fi

tmux source-file $tmux_theme_conf
