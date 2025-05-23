{pkgs, ...}: {
  home.packages = with pkgs; [
    uair
    figlet
    (writeShellScriptBin "uairfiglet" "uairctl listen | figlet")
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
