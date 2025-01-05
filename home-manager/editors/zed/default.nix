{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  config = {
    home.packages = lib.mkIf config.myEditor.zed [
      pkgs.zed-editor
    ];
  };
}
