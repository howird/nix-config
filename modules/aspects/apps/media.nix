{
  den.aspects.media.homeManager = {pkgs, ...}: {
    home.packages = import ./_available.nix pkgs (with pkgs; [
      spotify
      # ncspot
      # fretboard

      obs-studio
      footage
      kdePackages.kdenlive
      # audacity
      # f3d

      gimp
      krita
      # darktable
    ]);
  };
}
