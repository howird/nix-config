{
  inputs,
  pkgs,
  ...
}:
with pkgs.stdenv.hostPlatform; {
  zjstatus = inputs.zjstatus.packages.${system}.default;
  ghostty = inputs.ghostty.packages.${system}.default;
  zen-browser = inputs.zen-browser.packages.${system}.twilight;

  zesh = pkgs.callPackage ./zesh {};
}
