{
  programs.helix.settings.keys = {
    # see https://rushter.com/blog/helix-editor/

    select = {
      "$" = "goto_line_end";
      "^" = "goto_first_nonwhitespace";
    };

    normal = {
      "$" = ["select_mode" "goto_line_end" "normal_mode"];
      "^" = ["select_mode" "goto_first_nonwhitespace" "normal_mode"];
      esc = ["collapse_selection" "keep_primary_selection"];
    };
  };

  programs.helix.settings.keys.normal = {
    "-" = ":dugtrio-open";
  };
}
