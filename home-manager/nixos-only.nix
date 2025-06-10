{config, ...}: {
  imports = [
    ./desktops

    ./gpg.nix
    ./mpv.nix
  ];

  config = {
    myShell.aliases.nixwird = "sudo nixos-rebuild switch --flake /home/${config.myUsername}/nix/config";
    programs.ghostty.enable = true; # gl issues for non-NixOS

    # desktops
    myDesktop.hyprland = true;

    # editors
    myEditor.zed = true;

    # browsers
    myBrowser.chromium = true;
  };
}
