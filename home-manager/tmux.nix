{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    # mouse = true;
  };
}
