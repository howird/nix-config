{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../home.nix
    ../home-desktop.nix
  ];

  config = {
    programs.plasma.powerdevil.AC.autoSuspend.action = "nothing";
    programs.plasma.powerdevil.AC.turnOffDisplay.idleTimeout = 600;
    programs.plasma.powerdevil.AC.turnOffDisplay.idleTimeoutWhenLocked = "whenLockedAndUnlocked";
  };
}
