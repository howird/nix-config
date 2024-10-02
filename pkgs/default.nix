# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  expose-theme = pkgs.callPackage ./expose {};
  reactionary-theme = pkgs.callPackage ./reactionary {};
  commonality-theme = pkgs.callPackage ./commonality {};
  retrosmart-cursors = pkgs.callPackage ./retrosmart-cursors {};
}
