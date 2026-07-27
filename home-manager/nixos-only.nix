{config, ...}: {
  imports = [
    ./apps
    ./browsers
    ./desktops
    ./life

    ./gpg.nix
    ./rclone.nix
    ./thunar.nix
  ];

  config = {
    myShell.aliases.nixwird = "sudo nixos-rebuild switch --flake /home/${config.home.username}/nix/config";
    programs.ghostty.enable = true; # gl issues for non-NixOS

    # editors
    programs.zed-editor.enable = true;

    # browsers
    myBrowser.chromium = true;
  };
}
