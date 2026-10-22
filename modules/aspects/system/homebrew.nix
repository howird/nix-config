{inputs, ...}: {
  flake-file.inputs.nix-homebrew.url = "github:zhaofengli/nix-homebrew";

  den.aspects.homebrew.darwin = {
    config,
    lib,
    ...
  }: {
    imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];

    nix-homebrew = {
      enable = true;
      user = config.homebrew.user;
      enableBashIntegration = false;
      enableFishIntegration = false;
      enableZshIntegration = false;
    };

    homebrew = {
      enable = true;
      onActivation.cleanup = "none";
    };

    environment.systemPath = lib.mkAfter [
      "${config.homebrew.prefix}/bin"
      "${config.homebrew.prefix}/sbin"
    ];

    environment.interactiveShellInit = ''
      brew() {
        if [ "$USER" = ${config.homebrew.user} ]; then
          command brew "$@"
        else
          sudo -Hu ${config.homebrew.user} ${config.homebrew.prefix}/bin/brew "$@"
        fi
      }
    '';
  };
}
