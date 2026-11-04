{
  den.aspects.media.homeManager = {pkgs, ...}: {
    home.packages = import ./_available.nix pkgs (with pkgs; [
      # intentional watching, not streaming!
      # ^^^YOO!!!
      vlc
      showtime
      loupe # image viewer

      # fretboard
      ncspot
      spotify
      rhythmbox

      audacity
      # obs-studio
      footage
      gimp
      # krita
      # darktable
      # f3d
      # kdePackages.kdenlive
    ]);
  };
}
