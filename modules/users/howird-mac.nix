{den, ...}: {
  den.aspects.howird-mac.includes = [
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
    den.aspects.git
    den.aspects.htop
    den.aspects.programming
    den.aspects.sioyek
    den.aspects.yazi
    den.aspects.stylix
    den.aspects.rclone

    den.aspects.ghostty
    den.aspects.zen

    den.aspects.apps
    den.aspects.mac-apps
  ];

  den.aspects.howird-mac.homeManager = {
    lib,
    pkgs,
    ...
  }: {
    home.username = lib.mkForce "howird";
    home.homeDirectory = lib.mkForce "/Users/howird";

    myShell.aliases.nixwird = "sudo darwin-rebuild switch --flake /Users/howird/nix/config#mba";

    programs.ghostty.enable = true;
    programs.ghostty.package = pkgs.ghostty-bin;
    programs.zed-editor.enable = true;
  };
}
