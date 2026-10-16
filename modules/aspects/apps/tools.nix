{
  den.aspects.tools.homeManager = {pkgs, ...}: {
    home.packages = import ./_available.nix pkgs (with pkgs; [
      gnome-decoder
      blanket
      eyedropper
      warp

      qbittorrent
      aria2
      openconnect_openssl
    ]);
  };
}
