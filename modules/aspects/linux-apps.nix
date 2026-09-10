{...}: {
  den.aspects.linux-apps.homeManager = {pkgs, ...}: {
    imports = [
      ./_apps/default-apps.nix
    ];

    home.packages = with pkgs; [
      foliate
      percollate
      wordbook
      wike

      networkmanager
      dex

      obs-studio
      footage
      kdePackages.kdenlive

      eyedropper
      gimp
      krita

      gnome-decoder
      blanket
      warp
    ];
  };
}
