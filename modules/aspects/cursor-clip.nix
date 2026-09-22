{inputs, ...}: {
  flake-file.inputs.cursor-clip = {
    url = "github:sirulex/cursor-clip";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.crane.follows = "crane";
    inputs.flake-utils.follows = "flake-utils";
  };

  # Clipboard-history daemon and overlay. Part of
  # den.aspects.bundles.waybar-shell; noctalia's clipboard panel replaces it.
  # Wired into niri, so this expects den.aspects.niri alongside it.
  den.aspects.cursor-clip.homeManager = {
    config,
    pkgs,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    home.packages = [inputs.cursor-clip.packages.${system}.default];

    programs.niri.settings = {
      spawn-at-startup = [
        {argv = ["cursor-clip" "--daemon"];}
      ];
      binds."Mod+V".action = config.lib.niri.actions.spawn "cursor-clip";
    };
  };
}
