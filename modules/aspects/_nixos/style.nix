inputs: {pkgs, ...}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ../_shared/stylix.nix
  ];

  fonts.packages = with pkgs; [
    maple-mono.NF
    aleo-fonts
    inter
  ];
}
