#!/usr/bin/env bash

tat_selector() {
  if [[ -z "$TMUX" && -z "$ZELLIJ" && $TERM_PROGRAM != "vscode" && $TERM_PROGRAM != "zed" ]]; then
    local options
    local existing_sessions
    local selected_option

    existing_sessions=$(tmux list-sessions 2>/dev/null)
    options="cwd ($PWD)\nnone"

    if [[ -n "$existing_sessions" ]]; then
      options="$options\n$existing_sessions"
    fi

    selected_option=$(echo -e "$options" | fzf --reverse --prompt="select tmux session: ")

    case "$selected_option" in
      "cwd ($PWD)")
        tat
        ;;
      "none")
        echo "not attaching to tmux."
        ;;
      *)
        selected_session=$(echo "$selected_option" | sed -E 's/:.*$//')

        if [[ -n "$selected_session" ]]; then
          tmux attach-session -t "$selected_session"
        else
          echo "no valid selection. not attaching to tmux."
        fi
        ;;
    esac
  fi
}

tat_selector

