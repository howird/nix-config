{pkgs, ...}: let
  inherit (pkgs) writeShellScriptBin;
  uairzen = writeShellScriptBin "uairzen" (builtins.readFile ./scripts/uairzen);
  start-day = writeShellScriptBin "start-day" (builtins.readFile ./scripts/start-day);
  uair-check = writeShellScriptBin "uair-check" (builtins.readFile ./scripts/uair-check);
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

  myShell.aliases = {
    uair-check-start = "systemctl --user start uairwird.timer";
    uair-check-stop = "systemctl --user stop uairwird.timer";
  };

  home.packages = [
    uairzen
    start-day
    uair-check
  ];
}
