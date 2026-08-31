{...}: {
  # howird-only (matches the pre-migration repo's home-manager/apps, only ever
  # imported by nixos-only.nix).
  den.aspects.apps.homeManager = {pkgs, ...}: {
    imports = [
      ./_apps/default-apps.nix
    ];

    home.packages = with pkgs; [
      foliate
      typora
      obsidian
      presenterm
      percollate
      wordbook
      wike

      openconnect_openssl
      networkmanager
      aria2
      dex

      audacity
      obs-studio
      footage
      kdePackages.kdenlive

      f3d
      drawio
      eyedropper
      gimp
      darktable
      krita

      vesktop
      slack
      # zoom-us

      # intentional watching, not streaming!
      # ^^^YOO!!!
      qbittorrent
      spotify
      ncspot
      fretboard
      gnome-decoder
      warp
      blanket
    ];
  };
}
