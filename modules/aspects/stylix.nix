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
    isNixos,
    isDarwin,
    lib,
    pkgs,
    ...
  }: {
    imports =
      lib.optional (!isNixos) inputs.stylix.homeModules.stylix
      ++ [./_stylix/theme.nix];

    config = lib.mkIf isDarwin {
      home.pointerCursor = lib.mkForce {
        enable = false;
        package = pkgs.bibata-cursors;
        name = "Bibata-Original-Ice";
        size = 24;
      };

      stylix.targets.gtksourceview.enable = false;
      stylix.overlays.enable = false;
    };
  };
}
