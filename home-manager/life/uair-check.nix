{pkgs, ...}: let
  inherit (pkgs) writeShellScriptBin;
  uairzen = writeShellScriptBin "uairzen" (builtins.readFile ./scripts/uairzen);
  start-day = writeShellScriptBin "start-day" (builtins.readFile ./scripts/start-day);
  uair-check = writeShellScriptBin "uair-check" (builtins.readFile ./scripts/uair-check);
in {
  systemd.user.services.uair-check = {
    Unit.Description = "Checks that pomodoros are running";
    Service = {
      Type = "oneshot";
      ExecStart = "${uair-check}/bin/uair-check";
    };
  };

  systemd.user.timers.uair-check = {
    Unit.Description = "Checks that pomodoros are running";
    Install.WantedBy = ["timers.target"];

    Timer = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "uair-check.service";
    };
  };

  home.packages = [
    uairzen
    start-day
    uair-check
  ];
}
