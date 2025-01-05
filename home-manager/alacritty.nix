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
    settings.window.blur = true;
  };
}
