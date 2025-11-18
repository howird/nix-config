{pkgs, ...}: {
  imports = [
    ./zellij.nix
    ./default-layout.nix
    ./task-layout.nix
    ./tab-bar.nix
  ];

  programs.zellij.enable = true;
  programs.zellij.tab-bar.name = "zjstatus";

  home.packages = with pkgs; [
    zesh
  ];

  myShell.aliases = {
    zh = "zesh cn .";
    zls = ''zesh cn "$(zesh l | fzf)"'';
  };
}
