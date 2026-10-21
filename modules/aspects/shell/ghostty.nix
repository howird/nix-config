{
  den.aspects.ghostty.homeManager = {
    pkgs,
    lib,
    ...
  }: {
    programs.ghostty = {
      # Not for howard@vip: gl issues on non-NixOS.
      enable = true;
      # nixpkgs' ghostty doesn't build on darwin; use the upstream app.
      package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin pkgs.ghostty-bin;
      enableZshIntegration = true;
      installVimSyntax = true;
      settings =
        lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
          # when using a window manager
          window-decoration = "none";
        }
        // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
          # Without this, macOS's own Option-key consumes Alt+key combos
          # before they reach terminal programs
          macos-option-as-alt = true;
        }
        // {
          background-opacity = 0.9;
          background-blur = true;
          # Without this, helix (termina backend) re-sends the queried
          # background via OSC 11 and the window stops being transparent
          osc-color-report-format = "none";
          confirm-close-surface = false;
          keybind = [
            "ctrl+shift+j=unbind"
          ];
        };
    };
  };
}
