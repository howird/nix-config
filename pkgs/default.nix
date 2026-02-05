{
  inputs,
  pkgs,
  ...
}:
with pkgs.stdenv.hostPlatform; {
  ghostty = inputs.ghostty.packages.${system}.default;
  voxtype-vulkan = inputs.voxtype.packages.${system}.vulkan;
  zen-browser = inputs.zen-browser.packages.${system}.twilight;
  zjstatus = inputs.zjstatus.packages.${system}.default;
  zsh-helix-mode = inputs.zsh-helix-mode.packages.${system}.default;

  zesh = pkgs.callPackage ./zesh {};
}
