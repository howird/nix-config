{pkgs, ...}: {
  imports = [
    ./uair.nix
    ./uair-waybar.nix
    ./uair-check.nix
  ];

  home.packages = with pkgs; [
    uair
    zenity
  ];

  systemd.user.services.uair = {
    Unit = {
      Description = "Uair pomodoro timer";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.uair}/bin/uair";
      Restart = "on-failure";
      RestartSec = 1;
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
