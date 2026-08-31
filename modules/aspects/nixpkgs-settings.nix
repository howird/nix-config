{...}: {
  flake-file.inputs.rust-overlay = {
    url = "github:oxalica/rust-overlay";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.nixpkgs-settings.nixos = {
    inputs,
    lib,
    pkgs,
    ...
  }: {
    nixpkgs.overlays = [
      inputs.self.overlays.default
      inputs.rust-overlay.overlays.default
      inputs.niri.overlays.niri
    ];
    nixpkgs.config = {
      allowUnfree = true;
      # rocmSupport = true;
      # cudaSupport = true;
      permittedInsecurePackages = [
      ];
    };

    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    nix.settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org"
        "https://cuda-maintainers.cachix.org"
        "https://nixpkgs-python.cachix.org"
        "https://pi.cachix.org"
        "https://ryoppippi.cachix.org"
        "https://niri-epireyn.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
        "pi.cachix.org-1:lGeoGJaZ5ZDabuRzkcD5EBTNnDM4HJ1vqeOxlWk1Flk="
        "ryoppippi.cachix.org-1:b2LbtWNvJeL/qb1B6TYOMK+apaCps4SCbzlPRfSQIms="
        "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA="
      ];
      trusted-users = ["root" "howird"];
    };

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    nix.optimise.automatic = true;

    programs.nix-ld.enable = true;

    programs.nh = {
      enable = true;
      flake = "/home/howird/nix/config";
    };

    environment.systemPackages = with pkgs; [
      nix-index
    ];
  };
}
