{...}: {
  # Only the dconf half is ever included (by howard@vip) — matches the
  # pre-migration repo, where nixos/desktops/gnome.nix and
  # home-manager/desktops/gnome/gnome.nix both existed but neither was ever
  # imported by anything (the former missing from nixos/desktops/default.nix's
  # imports, the latter because non-nixos.nix only imported ./gnome/dconf.nix
  # directly). Both are kept as unreferenced files for parity — the nixos one
  # has a pre-existing `service.xserver` (should be `services`) typo, and the
  # home-manager one references a bare `programs` that isn't a module arg
  # there; neither is ever forced since neither is included.
  den.aspects.gnome.nixos.imports = [./_gnome/unused-nixos-gnome.nix];

  den.aspects.gnome.homeManager.imports = [./_gnome/dconf.nix];
}
