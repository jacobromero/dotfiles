#!/usr/bin/env sh

ws=${1}
prev_ws=${2}

# Array of possible window titles
# pip_titles=("Picture-in-picture" "Picture-in-Picture" "Picture in Picture" "Picture in picture")

# Function to find matching PIP windows
find_pip_windows() {
  local result=""
  local matches=$(aerospace list-windows --all | grep "Picture-in-Picture")
  result="$result"$'\n'"$matches"
  echo "$result" | sed '/^\s*$/d' # Remove empty lines
}

pip_wins=$(find_pip_windows "${pip_titles[@]}")

move_win() {
  local win="$1"

  # [[ -n $win ]] || return 0

  local win_id=$(echo "$win" | cut -d'|' -f1 | xargs)

  # Skip if the monitor is already the target monitor or if the workspace matches
  # [[ $target_mon != "$win_mon" ]] && return 0
  # [[ $ws == "$win_ws" ]] && return 0

  aerospace move-node-to-workspace --window-id "$win_id" "$ws"
}

# Process each PIP window found
for win in $pip_wins; do
    move_win "$win"
done
