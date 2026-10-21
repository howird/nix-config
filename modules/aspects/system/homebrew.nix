{inputs, ...}: {
  flake-file.inputs.nix-homebrew.url = "github:zhaofengli/nix-homebrew";

  # Installs brew itself, owned by the primary user. Nothing declares
  # brews or casks; it's there for manual installs.
  den.aspects.homebrew.darwin = {config, ...}: {
    imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];

    nix-homebrew = {
      enable = true;
      user = config.system.primaryUser;
    };
  };
}
