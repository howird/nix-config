{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
    ../home-manager/stylix.nix
  ];

  fonts.packages = with pkgs; [
    maple-mono.NF
    aleo-fonts
    inter
  ];
}
