{pkgs, ...}: {
  programs.niri = {
    package = pkgs.niri-unstable;
  };
  niri-flake.cache.enable = true;
  environment.systemPackages = [pkgs.xwayland-satellite-unstable];
}
