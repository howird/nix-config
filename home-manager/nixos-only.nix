{config, ...}: {
  imports = [
    ./desktops

    ./gpg.nix
    ./mpv.nix
    ./alacritty.nix
    ./packages.nix
    ./mime-apps.nix
  ];

  config = {
    myShell.aliases.nixwird = "sudo nixos-rebuild switch --flake /home/${config.myUsername}/nix/config";

    # desktops
    myDesktop.hyprland = true;

    # editors
    myEditor.zed = true;

    # browsers
    myBrowser.edge = true;
    myBrowser.vivaldi = true;
    myBrowser.zen = true;
  };
}
