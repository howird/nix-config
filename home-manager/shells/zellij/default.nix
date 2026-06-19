{pkgs, ...}: {
  imports = [
    ./zellij.nix
    ./default-layout.nix
    ./tab-bar.nix
  ];

  programs.zellij.enable = true;
  programs.zellij.tab-bar.name = "zjstatus";

  home.packages = with pkgs; [
    zesh
  ];

  myShell.aliases = {
    zh = "zesh cn .";
    zls = ''zesh connect "$(zesh list | fzf | sed "s|^~|$HOME|")"'';
  };
}
