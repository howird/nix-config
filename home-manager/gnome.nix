{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };
}
