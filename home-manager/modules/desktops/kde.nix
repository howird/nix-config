{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: lib.mkIf config.myDesktop.kde {

}
