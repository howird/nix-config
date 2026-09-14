{inputs, ...}: {
  flake-file.inputs.cursor-clip = {
    url = "github:sirulex/cursor-clip";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.crane.follows = "crane";
    inputs.flake-utils.follows = "flake-utils";
  };

  # Wayland clipboard tooling. The cursor-clip daemon/overlay is wired into
  # niri, so this expects den.aspects.niri alongside it.
  den.aspects.clipboard.homeManager = {
    lib,
    pkgs,
    config,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    home.packages = with pkgs; [
      slurp
      grim
      wl-clipboard-rs
      inputs.cursor-clip.packages.${system}.default
    ];

    programs.niri.settings = lib.mkIf config.programs.niri.enable {
      spawn-at-startup = [
        {argv = ["cursor-clip" "--daemon"];}
      ];
      binds."Mod+V".action = config.lib.niri.actions.spawn "cursor-clip";
    };
  };
}
