{inputs, ...}: {
  flake-file.inputs.niri = {
    url = "github:epireyn/niri-flake";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.nixpkgs-stable.follows = "nixpkgs-stable";
  };

  den.aspects.niri.nixos = {pkgs, ...}: {
    imports = [inputs.niri.nixosModules.niri];

    programs.niri = {
      package = pkgs.niri-unstable;
    };
    niri-flake.cache.enable = true;
    environment.systemPackages = [pkgs.xwayland-satellite-unstable];
  };

  den.aspects.niri.homeManager = {
    lib,
    pkgs,
    config,
    ...
  }: {
    imports = [
      ./_niri/appearance.nix
      ./_niri/binds.nix
      ./_niri/niri.nix
      ./_niri/programs.nix
      ./_niri/window-rules.nix
      ./_niri/workspaces.nix
    ];

    options.programs.niri.enable = lib.mkEnableOption "niri";

    config = {
      home.packages = lib.mkIf config.programs.niri.enable (with pkgs; [
        glib
        wayland
        libnotify
        wdisplays

        networkmanagerapplet
        pavucontrol

        # clipboard
        slurp
        grim
        wl-clipboard-rs
      ]);
    };
  };
}
