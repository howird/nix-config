{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    openconnect
    gtkwave

    obsidian
    texlive.combined.scheme-full

    discord
    teams-for-linux

    stremio
    spotify
  ] ++ (
    if (config.myDesktop == "hyprland") then 
      with pkgs; [
        xdg-desktop-portal-hyprland
        networkmanagerapplet
        wl-clipboard
        libnotify
        dunst
        slurp
        grim
        swww
      ]
    else ( if (config.myDesktop == "kde") then
      with pkgs; [
        pkgs.libsForQt5.qtwayland
      ]
    else ( if (config.myDesktop == "gnome") then
      with pkgs; [
        gnome.dconf-editor
        gnome.gnome-tweaks
      ]
    else
      []
    ))
  );
}
