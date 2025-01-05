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

    ./alacritty.nix
    ./packages.nix
  ];

  config = {
    myShell.aliases.nixwird = "sudo nixos-rebuild switch --flake /home/${config.myUsername}/nix/config";

    # desktops
    myDesktop.hyprland = true;

    # editors
    myEditor.vscode = true;
    myEditor.zed = true;

    # shells
    myShell.zsh = true;

    # browsers
    myBrowser.edge = true;
    myBrowser.zen = true;
  };
}
