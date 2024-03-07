{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      window = {
        opacity = 0.85;
        blur = true;
      };
      colors = {
        background = "#fff7f7";
      };
      font = {
        regular = {
          family = "JetBrainsMono Nerd Font";
          style = "monospace";
        };
      };
    };
  };
}
