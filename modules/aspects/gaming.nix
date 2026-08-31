{...}: {
  # Not included by any host today (matches the pre-migration repo, where
  # nixos/gaming.nix existed but nothing imported it).
  den.aspects.gaming.nixos = {pkgs, ...}: {
    programs = {
      steam.enable = true;
      steam.gamescopeSession.enable = true;
      gamemode.enable = true;
    };

    environment.systemPackages = with pkgs; [
      mangohud
      protonup
    ];

    # home.sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
