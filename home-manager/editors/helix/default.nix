{
  lib,
  config,
  pkgs,
  ...
}: {
  programs.helix = {
    enable = config.myEditor.helix;
  };
  home.packages = lib.optional config.myEditor.evil-helix pkgs.evil-helix;
}
