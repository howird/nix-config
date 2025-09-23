{pkgs, ...}: {
  imports = [
    ./hyprland
    ./niri
    ./packages
  ];

  home.packages = with pkgs; [
    wl-clipboard-rs
    slurp
    grim
  ];
}
