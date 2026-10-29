let
  # caches every host pulls from; linux-only ones are added in the nixos block
  caches = [
    {
      url = "https://cache.nixos.org";
      key = "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
    }
    {
      url = "https://nixpkgs-python.cachix.org";
      key = "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU=";
    }
    {
      url = "https://pi.cachix.org";
      key = "pi.cachix.org-1:lGeoGJaZ5ZDabuRzkcD5EBTNnDM4HJ1vqeOxlWk1Flk=";
    }
    {
      url = "https://ryoppippi.cachix.org";
      key = "ryoppippi.cachix.org-1:b2LbtWNvJeL/qb1B6TYOMK+apaCps4SCbzlPRfSQIms=";
    }
  ];
  cacheSettings = extra: let
    all = caches ++ extra;
  in {
    substituters = map (c: c.url) all;
    trusted-public-keys = map (c: c.key) all;
  };
in {
  den.aspects.nixpkgs-settings.nixos = {
    inputs,
    lib,
    pkgs,
    hostUsers,
    ...
  }: {
    nixpkgs.overlays = [
      inputs.niri.overlays.niri
      inputs.helix-plugins.overlays.default
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

    nix.settings =
      cacheSettings [
        {
          url = "https://cache.nixos-cuda.org";
          key = "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=";
        }
        {
          url = "https://niri-epireyn.cachix.org";
          key = "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA=";
        }
        {
          url = "https://noctalia.cachix.org";
          key = "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=";
        }
      ]
      // {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        trusted-users = ["root"] ++ hostUsers;
      };

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    nix.optimise.automatic = true;

    programs.nix-ld.enable = true;

    programs.nh.enable = true;

    environment.systemPackages = with pkgs; [
      nix-index
    ];
  };

  den.aspects.nixpkgs-settings.darwin = {
    inputs,
    lib,
    hostUsers,
    ...
  }: {
    nixpkgs.overlays = [
      inputs.helix-plugins.overlays.default
    ];
    nixpkgs.config.allowUnfree = true;

    nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    nix.settings =
      cacheSettings []
      // {
        trusted-users = ["root"] ++ hostUsers;
      };
  };
}
