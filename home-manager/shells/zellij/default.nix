{pkgs, ...}: {
  imports = [
    ./zellij.nix
    ./default-layout.nix
    ./zjstatus.nix
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
