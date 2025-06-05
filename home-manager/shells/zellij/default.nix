{pkgs, ...}: {
  imports = [
    ./zellij.nix
  ];

  programs.zellij.enable = true;

  home.packages = with pkgs; [
    zesh
  ];

  myShell.aliases = {
    zh = "zesh cn .";
    zls = "zesh cn $(zesh l | fzf)";
  };
}
