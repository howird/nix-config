{
  inputs,
  pkgs,
  ...
}:
with pkgs.stdenv.hostPlatform; {
  # inherit (inputs.hyprland.packages.${system}) hyprland xdg-desktop-portal-hyprland;
  # inherit (inputs.hyprland-plugins.packages.${system}) hyprexpo hyprscrolling;
  zjstatus = inputs.zjstatus.packages.${system}.default;
  ghostty = inputs.ghostty.packages.${system}.default;
  zen-browser = inputs.zen-browser.packages.${system}.default;

  expose-theme = pkgs.callPackage ./expose {};
  reactionary-theme = pkgs.callPackage ./reactionary {};
  commonality-theme = pkgs.callPackage ./commonality {};
  chicago95-theme = pkgs.callPackage ./chicago95 {};
  retrosmart-cursors = pkgs.callPackage ./retrosmart-cursors {};
  kde-compact-pager = pkgs.callPackage ./kde-compact-pager {};
  kde-fokus = pkgs.callPackage ./kde-fokus {};
  tahoma2d = pkgs.callPackage ./tahoma2d {};
  zesh = pkgs.callPackage ./zesh {};
}
