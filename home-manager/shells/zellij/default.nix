{pkgs, ...}: {
  imports = [
    ./zellij.nix
    ./default-layout.nix
  ];

  programs.zellij.enable = true;

  home.packages = with pkgs; [
    zesh
    zjstatus
  ];

  myShell.aliases = {
    zh = "zesh cn .";
    zls = "zesh cn $(zesh l | fzf)";
  };
}
