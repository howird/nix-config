{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sshfs
    libsixel
    yazi
    timg
    nautilus
    gnome-disk-utility
  ];

  services.gvfs.enable = true;
}
