{config, ...}: {
  programs.sioyek = {
    enable = true;
    bindings = {
      "goto_beginning" = "G";
      "goto_end" = "ge";
      "prev_state" = "<C-o>";
      "next_state" = "<C-i>";
      "screen_down" = "<C-d>";
      "screen_up" = "<C-u>";
    };
    config = with config.lib.stylix.colors; {
      "custom_text_color" = "${base00-dec-r} ${base00-dec-g} ${base00-dec-b}";
      "custom_background_color" = "${base05-dec-r} ${base05-dec-g} ${base05-dec-b}";
      "dark_mode_background_color" = "${base00-dec-r} ${base00-dec-g} ${base00-dec-b}";
      "status_bar_text_color" = "${base05-dec-r} ${base05-dec-g} ${base05-dec-b}";
      "status_bar_color" = "${base00-dec-r} ${base00-dec-g} ${base00-dec-b}";
      "startup_commands" = "toggle_custom_color";
      "ruler_mode" = "1";
      "touchpad_sensitivity" = "1.6";
      "default_dark_mode" = "1";
    };
  };
}
