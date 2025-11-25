{...}: {
  programs.helix.settings.keys = {
    # see https://rushter.com/blog/helix-editor/
    # https://github.com/sxyazi/yazi/pull/2461

    select = {
      "$" = "goto_line_end";
      "^" = "goto_first_nonwhitespace";
    };

    normal = {
      "$" = ["select_mode" "goto_line_end"];
      "^" = ["select_mode" "goto_first_nonwhitespace"];
      esc = ["collapse_selection" "keep_primary_selection"];
      "-" = "file_explorer_in_current_buffer_directory";
      "_" = "file_explorer";
    };
  };
}
