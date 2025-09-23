{pkgs, ...}: {
  programs.niri = {
    package = pkgs.niri;
  };
  niri-flake.cache.enable = true;
}
