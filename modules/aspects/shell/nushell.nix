{lib, ...}: {
  den.aspects.nushell.homeManager = {config, ...}: {
    programs.nushell = {
      enable = true;
      # Unlike zsh, Nushell does not source Home Manager's hm-session-vars.sh.
      extraEnv =
        (lib.optionalString config.programs.helix.defaultEditor ''
          $env.EDITOR = ${builtins.toJSON config.home.sessionVariables.EDITOR}
          $env.VISUAL = ${builtins.toJSON config.home.sessionVariables.VISUAL}
        '')
        + (lib.optionalString (config.home.sessionVariables ? NH_FLAKE) ''
          $env.NH_FLAKE = ${builtins.toJSON config.home.sessionVariables.NH_FLAKE}
        '');
      # Drop `open` so it doesn't shadow nushell's structured file reader, and
      # `zls`, which is POSIX syntax (zellij defines a nushell `def` for it).
      shellAliases = lib.removeAttrs config.myShell.aliases ["zls"];
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
