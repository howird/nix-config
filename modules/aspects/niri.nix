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

  # The compositor itself: layout, appearance, window/workspace rules and the
  # binds that drive niri. The bar, launcher, notifications, OSD, lock screen
  # and wallpaper are a separate concern - see den.aspects.bundles.waybar-shell
  # and den.aspects.noctalia.
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

        blueman
        pavucontrol
      ]);
    };
  };
}
