{
  description = "";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pix2tex = {
      url = "github:SimonYde/pix2tex.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:ch4og/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland = {
    #   type = "git";
    #   url = "https://github.com/hyprwm/Hyprland";
    #   submodules = true;
    # };
    hypr-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    nixosHosts = [
      "yerm"
      "updog"
      "bofa"
    ];

    # IN PYTHON:
    # def genAttrs(systems):
    #   return lambda fn: { system: fn(system) for system in systems }
    # forAllSystems = genAttrs(systems)
    forAllSystems = nixpkgs.lib.genAttrs systems;
    forAllHosts = nixpkgs.lib.genAttrs nixosHosts;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;

    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    apps = forAllSystems (system: {
      plasma-rc2nix = inputs.plasma-manager.apps.${system}.rc2nix;
    });

    # NixOS configuration entrypoint
    # Available through 'sudo nixos-rebuild switch --flake .#your-hostname'
    nixosConfigurations = forAllHosts (host:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs host;};
        modules = [
          ./nixos
          ./hosts/${host}

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # home-manager.backupFileExtension = "old";
            home-manager.users.howird = import ./hosts/${host}/home.nix;
            home-manager.extraSpecialArgs = {inherit inputs outputs host;};
          }
        ];
      });

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager switch --flake .#howird@yerm'
    homeConfigurations = {
      "howard@vip" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          host = "vip";
          inherit inputs outputs;
        };
        modules = [
          ./hosts/vip/home.nix
          ./home-manager/non-nixos.nix
        ];
      };
    };
  };
}
