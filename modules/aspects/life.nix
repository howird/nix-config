{...}: {
  # howird-only (matches the pre-migration repo's home-manager/life, only ever
  # imported by nixos-only.nix).
  den.aspects.life.homeManager = {pkgs, ...}: {
    imports = [
      ./_life/uair.nix
      ./_life/uair-waybar.nix
      ./_life/uair-check.nix
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
  };
}
