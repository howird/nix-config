{pkgs, ...}: let
  uairzen = pkgs.writeShellScriptBin "uairzen" (builtins.readFile ./scripts/uairzen);
  start-day = pkgs.writeShellScriptBin "start-day" (builtins.readFile ./scripts/start-day);
  uair-check = pkgs.writeShellScriptBin "uair-check" (builtins.readFile ./scripts/uair-check);
in {
  systemd.user.services.uairwird = {
    Unit.Description = "Checks that pomodoros are running";
    Service = {
      Type = "oneshot";
      ExecStart = "${uair-check}/bin/uair-check";
    };
  };

  systemd.user.timers.uairwird = {
    Unit.Description = "Checks that pomodoros are running";
    Install.WantedBy = ["timers.target"];

    Timer = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "uairwird.service";
    };
  };

  home.packages = [
    uairzen
    start-day
    uair-check
  ];
}
