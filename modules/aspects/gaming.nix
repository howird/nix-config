{...}: {
  # Not included by any host today (matches the pre-migration repo, where
  # nixos/gaming.nix existed but nothing imported it).
  den.aspects.gaming.nixos.imports = [
    ./_nixos/gaming.nix
  ];
}
