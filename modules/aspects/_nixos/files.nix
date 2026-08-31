{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sshfs
    libsixel
    yazi
    timg
    ghostty
    gnome-disk-utility
  ];

  xdg.terminal-exec = {
    enable = true;
    settings.default = ["ghostty.desktop"];
  };

  services.gvfs.enable = true;
}
