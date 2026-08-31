{...}: {
  den.aspects.llms.nixos.imports = [
    ./_nixos/llms.nix
  ];
}
