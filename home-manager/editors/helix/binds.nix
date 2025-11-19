{...}: {
  programs.helix.settings.keys = {
    # see https://rushter.com/blog/helix-editor/
    # https://github.com/sxyazi/yazi/pull/2461

    select = {
      "$" = "goto_line_end";
      "^" = "goto_first_nonwhitespace";
      G = "goto_file_end";
      k = ["extend_line_up" "extend_to_line_bounds"];
      j = ["extend_line_down" "extend_to_line_bounds"];
    };
    normal = {
      "$" = "goto_line_end";
      "^" = "goto_first_nonwhitespace";
      G = "goto_file_end";
      V = ["select_mode" "extend_to_line_bounds"];
      esc = ["collapse_selection" "keep_primary_selection"];
      "-" = "file_explorer_in_current_buffer_directory";
      "_" = "file_explorer";
    };
  };
}
