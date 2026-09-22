{
  config,
  pkgs,
  ...
}: let
  mkScript = name:
    pkgs.replaceVarsWith {
      src = ./scripts/${name};
      replacements.noteWorkspace = config.desktop.workspaces.note;
      dir = "bin";
      isExecutable = true;
      postCheck = ''${pkgs.stdenv.shellDryRun} "$target"'';
      meta.mainProgram = name;
    };

  uairzen = mkScript "uairzen";
  start-day = mkScript "start-day";
  uair-check = mkScript "uair-check";
  uair-startup = mkScript "uair-startup";
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
    Install.WantedBy = ["graphical-session.target"];

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
    uair-startup
  ];
}
