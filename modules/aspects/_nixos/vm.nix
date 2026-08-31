{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["howird"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
