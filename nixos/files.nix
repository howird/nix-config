{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sshfs
    libsixel
    yazi
    timg
    ghostty
    nautilus
    gnome-disk-utility
  ];

  xdg.terminal-exec = {
    enable = true;
    settings.default = ["ghostty.desktop"];
  };

  services.gvfs.enable = true;
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ghostty";
  };
}
