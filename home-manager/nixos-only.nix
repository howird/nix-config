{config, ...}: {
  imports = [
    ./desktops

    ./gpg.nix
  ];

  config = {
    myShell.aliases.nixwird = "sudo nixos-rebuild switch --flake /home/${config.home.username}/nix/config";
    programs.ghostty.enable = true; # gl issues for non-NixOS

    # editors
    myEditor.zed = true;

    # browsers
    myBrowser.chromium = true;
  };
}
