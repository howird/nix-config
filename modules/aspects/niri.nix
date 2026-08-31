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

      ./_niri/packages/batsignal.nix
      ./_niri/packages/hypridle.nix
      ./_niri/packages/hyprlock.nix
      ./_niri/packages/kanshi.nix
      ./_niri/packages/rofi.nix
      ./_niri/packages/record/default.nix
      ./_niri/packages/swaync
      ./_niri/packages/swayosd
      ./_niri/packages/waybar
    ];

    options = {
      programs.niri.enable = lib.mkEnableOption "niri";
      desktop.font = {
        useSerif = lib.mkEnableOption "useSerif";
        name = lib.mkOption {
          type = lib.types.str;
          description = "Name of the font.";
        };
      };
    };

    config = {
      home.packages = with pkgs;
        [
          wl-clipboard-rs
          slurp
          grim
        ]
        ++ lib.optionals config.programs.niri.enable [
          glib
          wayland
          libnotify
          wdisplays
          cursor-clip

          blueman
          networkmanagerapplet
          pavucontrol
        ];

      desktop.font.name =
        if config.desktop.font.useSerif
        then config.stylix.fonts.serif.name
        else config.stylix.fonts.sansSerif.name;

      stylix.targets.waybar.font =
        if config.desktop.font.useSerif
        then "serif"
        else "sansSerif";

      services.awww.enable = config.programs.niri.enable;
    };
  };
}
