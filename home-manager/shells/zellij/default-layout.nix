{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."zellij/layouts/default.kdl".text = let
    inherit (config.lib.stylix.colors) base00 base01 base04 base05 base07 base08 base09 base0A base0B base0D base0E base0F;
    bg-col = base00;
    sym-col = base01;
    txt-col = base05;
    mode-fmt = c: t: "#[fg=#${c}]#[bg=#${c},fg=#${bg-col},bold] ${t}#[fg=#${c}]";
    box-fmt = c: s: t: "#[fg=#${c}]#[bg=#${c},fg=#${sym-col},bold]${s} #[bg=#${bg-col},fg=#${txt-col},bold] ${t}#[fg=#${bg-col},bold]";
    tab-fmt = c: t: (box-fmt c "{index}" "{name}{${t}}");
  in ''
    layout {
        swap_tiled_layout name="vertical" {
            tab max_panes=5 {
                pane split_direction="vertical" {
                    pane
                    pane { children; }
                }
            }
            tab max_panes=8 {
                pane split_direction="vertical" {
                    pane { children; }
                    pane { pane; pane; pane; pane; }
                }
            }
            tab max_panes=12 {
                pane split_direction="vertical" {
                    pane { children; }
                    pane { pane; pane; pane; pane; }
                    pane { pane; pane; pane; pane; }
                }
            }
        }

        swap_tiled_layout name="horizontal" {
            tab max_panes=5 {
                pane
                pane
            }
            tab max_panes=8 {
                pane {
                    pane split_direction="vertical" { children; }
                    pane split_direction="vertical" { pane; pane; pane; pane; }
                }
            }
            tab max_panes=12 {
                pane {
                    pane split_direction="vertical" { children; }
                    pane split_direction="vertical" { pane; pane; pane; pane; }
                    pane split_direction="vertical" { pane; pane; pane; pane; }
                }
            }
        }

        swap_tiled_layout name="stacked" {
            tab min_panes=5 {
                pane split_direction="vertical" {
                    pane
                    pane stacked=true { children; }
                }
            }
        }

        swap_floating_layout name="staggered" {
            floating_panes
        }

        swap_floating_layout name="enlarged" {
            floating_panes max_panes=10 {
                pane { x "5%"; y 1; width "90%"; height "90%"; }
                pane { x "5%"; y 2; width "90%"; height "90%"; }
                pane { x "5%"; y 3; width "90%"; height "90%"; }
                pane { x "5%"; y 4; width "90%"; height "90%"; }
                pane { x "5%"; y 5; width "90%"; height "90%"; }
                pane { x "5%"; y 6; width "90%"; height "90%"; }
                pane { x "5%"; y 7; width "90%"; height "90%"; }
                pane { x "5%"; y 8; width "90%"; height "90%"; }
                pane { x "5%"; y 9; width "90%"; height "90%"; }
                pane focus=true { x 10; y 10; width "90%"; height "90%"; }
            }
        }

        swap_floating_layout name="spread" {
            floating_panes max_panes=1 {
                pane {y "50%"; x "50%"; }
            }
            floating_panes max_panes=2 {
                pane { x "1%"; y "25%"; width "45%"; }
                pane { x "50%"; y "25%"; width "45%"; }
            }
            floating_panes max_panes=3 {
                pane focus=true { y "55%"; width "45%"; height "45%"; }
                pane { x "1%"; y "1%"; width "45%"; }
                pane { x "50%"; y "1%"; width "45%"; }
            }
            floating_panes max_panes=4 {
                pane { x "1%"; y "55%"; width "45%"; height "45%"; }
                pane focus=true { x "50%"; y "55%"; width "45%"; height "45%"; }
                pane { x "1%"; y "1%"; width "45%"; height "45%"; }
                pane { x "50%"; y "1%"; width "45%"; height "45%"; }
            }
        }

        default_tab_template {
            pane size=1 borderless=true {
                plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
                    format_left   "{mode} {tabs}"
                    format_center ""
                    format_right  "${box-fmt base0D "" "{session}"} "
                    format_space  ""
                    format_hide_on_overlength "true"
                    format_precedence "crl"

                    border_enabled  "false"
                    border_char     "─"
                    border_format   "#[fg=#6C7086]{char}"
                    border_position "top"

                    mode_normal        " ${mode-fmt base0B " NORMAL "}"
                    mode_locked        " ${mode-fmt base04 "LOCKED  "}"
                    mode_resize        " ${mode-fmt base08 " RESIZE "}"
                    mode_pane          " ${mode-fmt base0D " PANE "}"
                    mode_tab           " ${mode-fmt base07 " TAB "}"
                    mode_scroll        " ${mode-fmt base0A " SCROLL "}"
                    mode_enter_search  " ${mode-fmt base0D "ENT-SRCH"}"
                    mode_search        " ${mode-fmt base0D " SEARCH "}"
                    mode_rename_tab    " ${mode-fmt base07 "RENAME-T"}"
                    mode_rename_pane   " ${mode-fmt base0D "RENAME-P"}"
                    mode_session       " ${mode-fmt base0E " SESSION "}"
                    mode_move          " ${mode-fmt base0F "  MOVE  "}"
                    mode_prompt        " ${mode-fmt base0D " PROMPT "}"
                    mode_tmux          " ${mode-fmt base09 "  TMUX  "}"

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
            }
            children
        }
    }
  '';
}
