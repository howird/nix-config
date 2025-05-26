{
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = lib.mkIf config.myEditor.zed [
    pkgs.zed-editor
  ];
}
