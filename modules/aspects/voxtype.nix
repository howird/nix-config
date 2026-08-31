{...}: {
  # Not included by any user today (matches the pre-migration repo, where
  # home-manager/voxtype.nix existed but was commented out of
  # home-manager/default.nix's imports — no voxtype flake input exists either).
  den.aspects.voxtype.homeManager = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [
      inputs.voxtype.homeManagerModules.default
    ];

    home.packages = with pkgs; [
      wtype
      voxtype-vulkan
    ];
  };
}
