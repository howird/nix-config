_not_inside_tmux() { [[ -z "$TMUX" ]] }

tat_selector() {
  if _not_inside_tmux; then
    local options
    local existing_sessions
    local selected_option

    existing_sessions=$(tmux list-sessions 2>/dev/null | sed -E 's/:.*$//')
    current_dir="$PWD"
    options="cwd ($current_dir)\nnone"

    if [[ -n "$existing_sessions" ]]; then
      options="$options\n$existing_sessions"
    fi

    selected_option=$(echo -e "$options" | fzf --reverse --prompt="select tmux session:")

    case "$selected_option" in
      "cwd ($current_dir)")
        tat
        ;;
      "no")
        echo "Skipping tmux attachment."
        ;;
      *)
        if [[ -n "$selected_option" ]]; then
          tmux attach-session -t "$selected_option"
        else
          echo "No session selected. Exiting."
        fi
        ;;
    esac
  fi
}

tat_selector

