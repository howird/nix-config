{pkgs, ...}: {
  home.packages = with pkgs; [
    uair
    figlet
    (writeShellScriptBin "uairtozero" "uairctl listen -o cli | stdbuf -oL awk '/00:00/ {print; exit} {print}' | figlet")
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
