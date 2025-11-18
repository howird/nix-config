{config, ...}: {
  xdg.configFile."zellij/config.kdl".text = ''
    default_mode "locked"
    pane_frames false
    mirror_session true
    copy_command "wl-copy"
    attach_to_session true
    show_startup_tips false
    show_release_notes false

    keybinds clear-defaults=true {
        locked {
            bind "Ctrl space" { SwitchToMode "normal"; }
            bind "Ctrl tab" { GoToPreviousTab; }
            bind "Ctrl Shift tab" { GoToNextTab; }

            bind "Alt space" { ToggleFloatingPanes; SwitchToMode "locked"; }
            bind "Alt h" "Alt left" { MoveFocusOrTab "left"; SwitchToMode "locked"; }
            bind "Alt j" "Alt down" { MoveFocus "down"; SwitchToMode "locked"; }
            bind "Alt k" "Alt up" { MoveFocus "up"; SwitchToMode "locked"; }
            bind "Alt l" "Alt right" { MoveFocusOrTab "right"; SwitchToMode "locked"; }
        }
        normal {
            bind "h" "left" { MoveFocusOrTab "left"; SwitchToMode "locked"; }
            bind "j" "down" { MoveFocus "down"; SwitchToMode "locked"; }
            bind "k" "up" { MoveFocus "up"; SwitchToMode "locked"; }
            bind "l" "right" { MoveFocusOrTab "right"; SwitchToMode "locked"; }

            bind "+" { Resize "Increase"; SwitchToMode "locked"; }
            bind "-" { Resize "Decrease"; SwitchToMode "locked"; }
            bind "=" { Resize "Increase"; SwitchToMode "locked"; }

            bind "v" { NextSwapLayout; SwitchToMode "locked"; }

            bind "n" { NewTab; SwitchToMode "locked"; }
            bind "Shift n" { NewPane "down"; SwitchToMode "locked"; }

            bind "d" { Detach; }
            bind "Ctrl p" {
                LaunchOrFocusPlugin "session-manager" {
                    floating true
                    move_to_focused_tab true
                }
                SwitchToMode "locked"
            }
        }
        shared_among "normal" "pane" {
            bind "space" { TogglePaneEmbedOrFloating; SwitchToMode "locked"; }
            bind "f" { ToggleFocusFullscreen; SwitchToMode "locked"; }
            bind "x" { CloseFocus; SwitchToMode "locked"; }
            bind "n" { NewPane; SwitchToMode "locked"; }
            bind "w" { ToggleFloatingPanes; SwitchToMode "locked"; }
            bind "z" { TogglePaneFrames; SwitchToMode "locked"; }

            bind "o" { NewPane "down"; SwitchToMode "locked"; }
            bind "a" { NewPane "right"; SwitchToMode "locked"; }
            bind "Shift o" { NewPane "stacked"; SwitchToMode "locked"; }
        }
        shared_among "normal" "tab" {
            bind "1" { GoToTab 1; SwitchToMode "locked"; }
            bind "2" { GoToTab 2; SwitchToMode "locked"; }
            bind "3" { GoToTab 3; SwitchToMode "locked"; }
            bind "4" { GoToTab 4; SwitchToMode "locked"; }
            bind "5" { GoToTab 5; SwitchToMode "locked"; }
            bind "6" { GoToTab 6; SwitchToMode "locked"; }
            bind "7" { GoToTab 7; SwitchToMode "locked"; }
            bind "8" { GoToTab 8; SwitchToMode "locked"; }
            bind "9" { GoToTab 9; SwitchToMode "locked"; }

            bind "[" { BreakPaneLeft; SwitchToMode "locked"; }
            bind "]" { BreakPaneRight; SwitchToMode "locked"; }
        }
        shared_among "normal" "move" {
            bind "tab" { MovePane; }
            bind "Shift tab" { MovePaneBackwards; }
        }
        pane {
            bind "j" { NewPane "down"; SwitchToMode "locked"; }
            bind "l" { NewPane "right"; SwitchToMode "locked"; }
            bind "s" { NewPane "stacked"; SwitchToMode "locked"; }

            bind "r" { SwitchToMode "renamepane"; PaneNameInput 0; }
            bind "i" { TogglePanePinned; SwitchToMode "locked"; }

            bind "tab" { SwitchFocus; }
        }
        tab {
            bind "h" "left" { GoToPreviousTab; SwitchToMode "locked"; }
            bind "l" "right" { GoToNextTab; SwitchToMode "locked"; }

            bind "j" "down" { GoToNextTab; }
            bind "k" "up" { GoToPreviousTab; }

            bind "b" { BreakPane; SwitchToMode "locked"; }
            bind "n" { NewTab; SwitchToMode "locked"; }
            bind "r" { SwitchToMode "renametab"; TabNameInput 0; }
            bind "s" { ToggleActiveSyncTab; SwitchToMode "locked"; }

            bind "x" { CloseTab; SwitchToMode "locked"; }
            bind "tab" { ToggleTab; }
        }
        resize {
            bind "h" "left" { Resize "Increase left"; }
            bind "j" "down" { Resize "Increase down"; }
            bind "k" "up" { Resize "Increase up"; }
            bind "l" "right" { Resize "Increase right"; }

            bind "+" { Resize "Increase"; }
            bind "-" { Resize "Decrease"; }
            bind "=" { Resize "Increase"; }

            bind "Shift h" "Shift left" { Resize "Decrease left"; }
            bind "Shift j" "Shift down" { Resize "Decrease down"; }
            bind "Shift k" "Shift up" { Resize "Decrease up"; }
            bind "Shift l" "Shift right" { Resize "Decrease right"; }
        }
        move {
            bind "h" "left" { MovePane "left"; }
            bind "j" "down" { MovePane "down"; }
            bind "k" "up" { MovePane "up"; }
            bind "l" "right" { MovePane "right"; }

            bind "n" { MovePane; }
            bind "p" { MovePaneBackwards; }
        }
        scroll {
            bind "Alt h" "Alt left" { MoveFocusOrTab "left"; SwitchToMode "locked"; }
            bind "Alt j" "Alt down" { MoveFocus "down"; SwitchToMode "locked"; }
            bind "Alt k" "Alt up" { MoveFocus "up"; SwitchToMode "locked"; }
            bind "Alt l" "Alt right" { MoveFocusOrTab "right"; SwitchToMode "locked"; }

            bind "i" { EditScrollback; SwitchToMode "locked"; }
            bind "/" { SwitchToMode "entersearch"; SearchInput 0; }

            bind "s" { SwitchToMode "normal"; }
        }
        search {
            bind "c" { SearchToggleOption "CaseSensitivity"; }
            bind "o" { SearchToggleOption "WholeWord"; }

            bind "n" { Search "down"; }
            bind "Shift n" { Search "up"; }

            bind "w" { SearchToggleOption "Wrap"; }
        }
        shared_except "locked" "renametab" "renamepane" {
            bind "Ctrl space" { SwitchToMode "locked"; }
            bind "Ctrl q" { Quit; }
        }
        shared_except "locked" "entersearch" {
            bind "enter" { SwitchToMode "locked"; }
        }
        shared_except "locked" "entersearch" "renametab" "renamepane" {
            bind "esc" { SwitchToMode "locked"; }
        }
        shared_except "locked" "entersearch" "renametab" "renamepane" "move" {
            bind "m" { SwitchToMode "move"; }
        }
        shared_except "locked" "tab" "entersearch" "renametab" "renamepane" {
            bind "t" { SwitchToMode "tab"; }
        }
        shared_except "locked" "tab" "scroll" "entersearch" "renametab" "renamepane" {
            bind "s" { SwitchToMode "scroll"; }
        }
        shared_among "normal" "resize" "tab" "scroll" "prompt" "tmux" {
            bind "p" { SwitchToMode "pane"; }
        }
        shared_except "locked" "resize" "pane" "tab" "entersearch" "renametab" "renamepane" {
            bind "r" { SwitchToMode "resize"; }
        }
        shared_among "scroll" "search" {
            bind "Ctrl d" { PageScrollDown; }
            bind "Ctrl u" { PageScrollUp; }

            bind "h" "left" { HalfPageScrollUp; }
            bind "j" "down" { ScrollDown; }
            bind "k" "up" { ScrollUp; }
            bind "l" "right" { HalfPageScrollDown; }

            bind "q" { ScrollToBottom; SwitchToMode "locked"; }
            bind "esc" { ScrollToBottom; SwitchToMode "locked"; }
        }
        entersearch {
            bind "Ctrl c" "esc" { SwitchToMode "scroll"; }
            bind "enter" { SwitchToMode "search"; }
        }
        renametab {
            bind "esc" { UndoRenameTab; SwitchToMode "tab"; }
        }
        renamepane {
            bind "esc" { UndoRenamePane; SwitchToMode "pane"; }
        }
        shared_among "renametab" "renamepane" {
            bind "Ctrl c" { SwitchToMode "locked"; }
        }
    }

    // Plugin aliases - can be used to change the implementation of Zellij
    // changing these requires a restart to take effect
    plugins {
        about location="zellij:about"
        compact-bar location="zellij:compact-bar"
        configuration location="zellij:configuration"
        filepicker location="zellij:strider" {
            cwd "/home/${config.home.username}"
        }
        plugin-manager location="zellij:plugin-manager"
        session-manager location="zellij:session-manager"
        status-bar location="zellij:status-bar"
        strider location="zellij:strider"
        welcome-screen location="zellij:session-manager" {
            welcome_screen true
        }
        tab-bar ${config.programs.zellij.tab-bar.text}
    }
  '';
}
