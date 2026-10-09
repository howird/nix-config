{
  den.aspects.ghostty.homeManager = {
    pkgs,
    lib,
    ...
  }: {
    programs.ghostty = {
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
          confirm-close-surface = false;
          keybind = [
            "ctrl+shift+j=unbind"
          ];
        };
    };
  };
}
