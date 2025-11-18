{...}: {
  xdg.configFile."zellij/layouts/task.kdl".text = ''
    pane_frames true
    keybinds clear-defaults=true {
        locked {
            bind "Alt f" { ToggleFocusFullscreen; SwitchToMode "locked"; }

            bind "Alt h" "Alt left" { MoveFocusOrTab "left"; SwitchToMode "locked"; }
            bind "Alt j" "Alt down" { MoveFocus "down"; SwitchToMode "locked"; }
            bind "Alt k" "Alt up" { MoveFocus "up"; SwitchToMode "locked"; }
            bind "Alt l" "Alt right" { MoveFocusOrTab "right"; SwitchToMode "locked"; }

            bind "Ctrl Alt h" "Ctrl Alt left" { Resize "Increase left"; }
            bind "Ctrl Alt j" "Ctrl Alt down" { Resize "Increase down"; }
            bind "Ctrl Alt k" "Ctrl Alt up" { Resize "Increase up"; }
            bind "Ctrl Alt l" "Ctrl Alt right" { Resize "Increase right"; }
        }
    }
    layout {
        pane command="taskwarrior-tui"
        pane name="taskwarrior-shell" size="30%"
    }
  '';
}
