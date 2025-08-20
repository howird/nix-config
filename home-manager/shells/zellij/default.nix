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

  myShell.aliases = let
    zesh = "${pkgs.zesh}/bin/zesh";
    fzf = "${pkgs.fzf}/bin/fzf";
  in {
    zh = "${zesh} cn .";
    zls = "${zesh} cn $(${zesh} l | ${fzf})";
  };
}
