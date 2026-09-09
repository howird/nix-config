{den, ...}: {
  den.aspects.howird.includes = [
    den.batteries.host-aspects

    # workstation-only (nixos-config-attached, not shared with howard@vip)
    den.aspects.niri
    den.aspects.apps
    den.aspects.granola
    den.aspects.browsers
    den.aspects.life
    den.aspects.gpg
    den.aspects.rclone
    den.aspects.thunar

    # shared with howard@vip
    den.aspects.editors-helix
    den.aspects.editors-vscode
    den.aspects.editors-zed
    den.aspects.agents-kiro
    den.aspects.agents-claude
    den.aspects.agents-pi
    den.aspects.agents-antigravity
    den.aspects.shells-zsh
    den.aspects.shells-fish
    den.aspects.shells-starship
    den.aspects.shells-zellij
    den.aspects.shell-aliases
    den.aspects.ghostty
    den.aspects.git
    den.aspects.htop
    den.aspects.programming
    den.aspects.sioyek
    den.aspects.typesetting
    den.aspects.yazi
    den.aspects.stylix
  ];

  den.aspects.howird.homeManager = {config, ...}: {
    programs.niri.enable = true;

    myShell.aliases.nixwird = "sudo nixos-rebuild switch --flake /home/${config.home.username}/nix/config";
    programs.ghostty.enable = true; # gl issues for non-NixOS

    # editors
    programs.zed-editor.enable = true;

    # browsers
    myBrowser.chromium = true;
  };
}
