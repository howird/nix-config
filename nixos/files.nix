{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sshfs
    yazi
    timg
    nautilus
    gnome-disk-utility
  ];

  services.gvfs.enable = true;
}
