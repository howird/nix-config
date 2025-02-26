{pkgs, ...}: {
  home.packages = with pkgs; [
    batsignal
  ];

  systemd.user.services = {
    batsignal = {
      Unit = {
        Description = "Batsignal: battery warning notifications";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.batsignal}/bin/batsignal -c 5 -w 20 -f 90";
        Restart = "always";
      };
      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
