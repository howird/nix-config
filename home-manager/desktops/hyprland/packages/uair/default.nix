{pkgs, ...}: {
  home.packages = with pkgs; [
    uair
    yad
    figlet
    (writeShellScriptBin "uairfiglet" ''uair | yad --progress --no-buttons --css="* { font-size: 80px; }"'')
  ];
  xdg.configFile."uair/uair.toml".source = ./uair.toml;

  systemd.user.services = {
    uair = {
      Unit = {
        Description = "Uair pomodoro timer";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.uair}/bin/uair -q";
        Restart = "always";
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
