{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./languages

    ./helix.nix
    ./binds.nix
  ];

  programs.helix = {
    defaultEditor = true;
    package = inputs.helix-flake.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
      cargoBuildFlags = (oldAttrs.cargoBuildFlags or []) ++ ["--features" "steel,git"];
    });
    extraPackages = with pkgs; [steel];
  };

  programs.yazi.enable = true;
}
