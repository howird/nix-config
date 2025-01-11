{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ../home-manager/stylix.nix
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    maple-mono-NF
    aleo-fonts
  ];
}
