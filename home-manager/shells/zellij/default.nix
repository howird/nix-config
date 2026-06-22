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
    zls = ''selected=$(zesh list | fzf | sed "s|^~|$HOME|"); [[ -n $selected ]] && zesh connect "$selected"'';
  };
}
