{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
    ./stylix.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      inputs.rust-overlay.overlays.default
    ];
    config = {allowUnfree = true;};
  };

  myShell.aliases.nixwird = "home-manager switch --flake /home/${config.myUsername}/nix/config${config.myShell.hmFlakeArgs}";
}
