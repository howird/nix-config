{lib, ...}: {
  den.aspects.nushell.homeManager = {config, ...}: {
    programs.nushell = {
      enable = true;
      # Drop `open` so it doesn't shadow nushell's structured file reader, and
      # `zls`, which is POSIX syntax (zellij defines a nushell `def` for it).
      shellAliases = lib.removeAttrs config.myShell.aliases ["open" "zls"];
      settings = {
        show_banner = false;
        edit_mode = "helix";
        cursor_shape = {
          helix_normal = "block";
          helix_select = "underscore";
          helix_insert = "line";
        };
        history.file_format = "sqlite";
      };
    };
  };
}
