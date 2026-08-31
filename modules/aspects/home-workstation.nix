{inputs, ...}: {
  den.aspects.home-workstation.homeManager = {config, ...}: {
    imports = [
      ./_home-workstation/apps
      (import ./_home-workstation/browsers inputs)
      ./_home-workstation/desktops
      ./_home-workstation/life

      ./_home-workstation/gpg.nix
      ./_home-workstation/rclone.nix
      ./_home-workstation/thunar.nix
    ];

    myShell.aliases.nixwird = "sudo nixos-rebuild switch --flake /home/${config.home.username}/nix/config";
    programs.ghostty.enable = true; # gl issues for non-NixOS

    # editors
    programs.zed-editor.enable = true;

    # browsers
    myBrowser.chromium = true;
  };
}
