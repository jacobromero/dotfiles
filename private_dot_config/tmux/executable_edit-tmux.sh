#!/bin/bash

# $HOME/bin/vim-edit-tmux-output

file=`mktemp`.tmuxtmp
tmux capture-pane -pS -32768 | tr -s '\n' > $file

# tmux send-keys "nvim '+ normal G $' $file" KPEnter
tmux display-popup -h 85% -w 85% -E "nvim '+ normal G $' $file"
rm -f $file
