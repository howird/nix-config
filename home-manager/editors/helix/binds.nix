{...}: {
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

  # https://github.com/sxyazi/yazi/pull/2461
  programs.yazi.initLua = ./yazi.lua;
  programs.helix.settings.keys.normal = {
    "-" = [
      ":sh rm -f /tmp/unique-file"
      ":insert-output yazi %{buffer_name} --chooser-file=/tmp/unique-file"
      '':insert-output echo "\x1b[?1049h\x1b[?2004h" > /dev/tty''
      ":open %sh{cat /tmp/unique-file}"
      ":redraw"
      ":set mouse false"
      ":set mouse true"
    ];
    "_" = [
      ":sh rm -f /tmp/unique-file"
      ":insert-output GO_ROOT=1 yazi --chooser-file=/tmp/unique-file"
      '':insert-output echo "\x1b[?1049h\x1b[?2004h" > /dev/tty''
      ":open %sh{cat /tmp/unique-file}"
      ":redraw"
      ":set mouse false"
      ":set mouse true"
    ];
  };
}
