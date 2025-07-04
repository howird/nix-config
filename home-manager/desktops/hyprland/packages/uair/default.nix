{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./uair.nix
    ./hypruair.nix
  ];

  home.packages = with pkgs; [
    uair
    zenity
  ];

  systemd.user.services.uair = {
    Unit.Description = "Uair pomodoro timer";
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.uair}/bin/uair -q";
      Restart = "always";
    };
    Install.WantedBy =
      if config.myDesktop.hyprland
      then ["hyprland-session.target"]
      else ["default.target"];
  };
}
