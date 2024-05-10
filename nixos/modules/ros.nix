{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  environment.systemPackages = with pkgs.rosPackages.foxy; [
  ];
}
