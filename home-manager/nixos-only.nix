{config, ...}: {
  imports = [
    ./desktops

    ./gpg.nix
    ./mpv.nix
    ./packages.nix
    ./apps.nix
  ];

  config = {
    myShell.aliases.nixwird = "sudo nixos-rebuild switch --flake /home/${config.myUsername}/nix/config";

    # desktops
    myDesktop.hyprland = true;

    # editors
    myEditor.zed = true;

    # browsers
    myBrowser.zen = true;
    myBrowser.vivaldi = true;
  };
}
