{...}: {
  # howird-only (matches the pre-migration repo's home-manager/apps, only ever
  # imported by nixos-only.nix). Cross-platform only — packages with no
  # aarch64-darwin build in nixpkgs live in den.aspects.linux-apps instead,
  # so this aspect stays safe to include from a darwin host too. (percollate
  # claims darwin support in meta.platforms but actually pulls in chromium
  # internally, which isn't buildable there — moved out too. Same for warp,
  # whose meta.broken is true on aarch64-darwin specifically.)
  den.aspects.apps.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      typora
      obsidian

      openconnect_openssl
      aria2

      # audacity
      # f3d
      drawio
      # darktable

      vesktop
      slack
      # zoom-us

      # intentional watching, not streaming!
      # ^^^YOO!!!
      qbittorrent
      spotify
      # ncspot
      # fretboard
    ];
  };
}
