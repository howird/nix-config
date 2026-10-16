{
  den.aspects.media.homeManager = {pkgs, ...}: {
    home.packages = import ./_available.nix pkgs (with pkgs; [
      # intentional watching, not streaming!
      # ^^^YOO!!!
      spotify

      obs-studio
      footage
      kdePackages.kdenlive
      # audacity
      # f3d
      # ncspot
      # fretboard

      gimp
      krita
      # darktable
    ]);
  };
}
