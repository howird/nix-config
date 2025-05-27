{pkgs, ...}: {
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
}
