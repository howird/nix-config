{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  environment.systemPackages = with pkgs.rosPackages.humble; [
    pkgs.colcon
    ros-core
  ];

}
