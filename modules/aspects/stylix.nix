{inputs, ...}: {
  flake-file.inputs.stylix = {
    url = "github:danth/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.stylix.nixos = {pkgs, ...}: {
    imports = [
      inputs.stylix.nixosModules.stylix
      ./_stylix/theme.nix
    ];

    fonts.packages = with pkgs; [
      maple-mono.NF
      aleo-fonts
      inter
    ];
  };

  den.aspects.stylix.homeManager = {
    host,
    lib,
    ...
  }: {
    # NixOS-attached users (howird) already get stylix's home-manager module
    # auto-injected via NixOS's own stylix integration (home-manager.sharedModules)
    # — importing it again here would redefine its read-only options. Only a
    # standalone home with no real host behind it (howard@vip) needs it
    # imported explicitly.
    imports =
      lib.optional (!(host ? class)) inputs.stylix.homeModules.stylix
      ++ [./_stylix/theme.nix];
  };
}
