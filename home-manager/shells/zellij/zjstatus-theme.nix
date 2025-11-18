{
  colors,
  format_left ? "{mode}",
  format_center ? "{tabs}",
}: let
  inherit (colors) base00 base01 base04 base05 base07 base08 base09 base0A base0B base0D base0E base0F;
  bg-col = base00;
  sym-col = base01;
  txt-col = base05;
  mode-fmt = c: t: "#[fg=#${c}]#[bg=#${c},fg=#${bg-col},bold] ${t}#[fg=#${c}]";
  box-fmt = c: s: t: "#[fg=#${c}]#[bg=#${c},fg=#${sym-col},bold]${s} #[bg=#${bg-col},fg=#${txt-col},bold] ${t}#[fg=#${bg-col},bold]";
  tab-fmt = c: t: (box-fmt c "{index}" "{name}{${t}}");
in ''
  {
        format_left   " ${format_left}"
        format_center "${format_center}"
        format_right  "${box-fmt base0D "" "{session}"} "
        format_space  ""
        format_hide_on_overlength "true"
        format_precedence "crl"

        border_enabled  "false"
        border_char     "─"
        border_format   "#[fg=#6C7086]{char}"
        border_position "top"

        mode_normal        "${mode-fmt base0B " NORMAL "}"
        mode_locked        "${mode-fmt base04 "LOCKED  "}"
        mode_resize        "${mode-fmt base08 " RESIZE "}"
        mode_pane          "${mode-fmt base0D " PANE "}"
        mode_tab           "${mode-fmt base07 " TAB "}"
        mode_scroll        "${mode-fmt base0A " SCROLL "}"
        mode_enter_search  "${mode-fmt base0D "ENT-SRCH"}"
        mode_search        "${mode-fmt base0D " SEARCH "}"
        mode_rename_tab    "${mode-fmt base07 "RENAME-T"}"
        mode_rename_pane   "${mode-fmt base0D "RENAME-P"}"
        mode_session       "${mode-fmt base0E " SESSION "}"
        mode_move          "${mode-fmt base0F "  MOVE  "}"
        mode_prompt        "${mode-fmt base0D " PROMPT "}"
        mode_tmux          "${mode-fmt base09 "  TMUX  "}"

        swap_layout_format          " ${mode-fmt base09 "{name}"}"
        swap_layout_hide_if_empty   "true"

        // formatting for inactive tabs
        tab_normal              "${tab-fmt base0D "floating_indicator"}"
        tab_normal_fullscreen   "${tab-fmt base0D "fullscreen_indicator"}"
        tab_normal_sync         "${tab-fmt base0D "sync_indicator"}"

        // formatting for the current active tab
        tab_active              "${tab-fmt base09 "floating_indicator"}"
        tab_active_fullscreen   "${tab-fmt base09 "fullscreen_indicator"}"
        tab_active_sync         "${tab-fmt base09 "sync_indicator"}"

        // separator between the tabs
        tab_separator           " "

        // indicators
        tab_sync_indicator       " "
        tab_fullscreen_indicator " 󰊓"
        tab_floating_indicator   " 󰹙"

        command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
        command_git_branch_format      "#[fg=blue] {stdout} "
        command_git_branch_interval    "10"
        command_git_branch_rendermode  "static"

        datetime        "#[fg=#6C7086,bold] {format} "
        datetime_format "%A, %d %b %Y %I:%M %p"
        datetime_timezone "America/Toronto"
      }
''
