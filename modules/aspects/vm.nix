{
  # Not included by any host today (matches the pre-migration repo, where
  # nixos/vm.nix was only ever commented out of nixos/default.nix's imports).
  den.aspects.vm.nixos = {hostUsers, ...}: {
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = hostUsers;
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
