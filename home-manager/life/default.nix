{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./taskwarrior.nix
    ./uair.nix
    ./uair-waybar.nix
    ./uair-check.nix
  ];

  home.packages = with pkgs; [
    uair
    zenity
    timewarrior
    taskwarrior-tui
    taskopen
  ];

  myShell.aliases = {
    tu = "taskwarrior-tui";
    ta = "task";
    ti = "timew";
    plan = ''echo "The following tasks must have due dates:" && ta due.none: list && echo "The following tasks must be organized:" && ta -TAGGED -PROJECT'';
  };

  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
  };

  systemd.user.services.uair = {
    Unit.Description = "Uair pomodoro timer";
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.uair}/bin/uair";
      Restart = "always";
    };
    Install.WantedBy =
      if config.programs.hyprland.enable
      then ["hyprland-session.target"]
      else ["default.target"];
  };
}
