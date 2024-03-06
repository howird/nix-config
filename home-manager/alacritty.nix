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
    settings = {
      window = {
        opacity = 0.8;
        blur = true;
      };
      colors = {
        background = "#fff7f7";
      };
    };
  };
}
