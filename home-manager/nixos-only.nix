{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./desktops
    ./editors
    ./shells
    ./browsers

    ./gpg.nix
    ./mpv.nix
    ./alacritty.nix
    ./packages.nix
  ];

  config = {
    myShell.aliases.nixwird = "sudo nixos-rebuild switch --flake /home/${config.myUsername}/nix/config";

    # desktops
    myDesktop.hyprland = true;

    # editors
    myEditor.zed = true;

    # browsers
    myBrowser.edge = true;
    myBrowser.zen = true;
  };
}
