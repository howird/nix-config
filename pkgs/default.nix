# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  expose-theme = pkgs.callPackage ./expose {};
  reactionary-theme = pkgs.callPackage ./reactionary {};
  commonality-theme = pkgs.callPackage ./commonality {};
  chicago95-theme = pkgs.callPackage ./chicago95 {};
  retrosmart-cursors = pkgs.callPackage ./retrosmart-cursors {};
  kde-compact-pager = pkgs.callPackage ./kde-compact-pager {};
  kde-fokus = pkgs.callPackage ./kde-fokus {};
  tahoma2d = pkgs.callPackage ./tahoma2d {};
}
