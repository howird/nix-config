{inputs, ...}: {
  flake-file.inputs.claude-desktop = {
    url = "github:heytcass/claude-desktop-linux-flake";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.flake-utils.follows = "flake-utils";
  };
  flake-file.inputs.claude-code = {
    url = "github:ryoppippi/nix-claude-code";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.claude.homeManager = {
    config,
    pkgs,
    lib,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) system;
    cfg = config.programs.claude-code;
    claude = inputs.claude-code.packages.${system}.default;
  in {
    # set on the claude binary itself, so ~/.claude/settings.json stays claude code's own
    options.programs.claude-code.environmentVariables = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = {};
      description = "Environment variables set on the claude binary.";
    };

    config = lib.mkMerge [
      # wrapper: implements environmentVariables
      {
        programs.claude-code.package = pkgs.symlinkJoin {
          # name keeps the version visible to home-manager's version-gated features
          name = "claude-${lib.getVersion claude}";
          paths = [claude];
          nativeBuildInputs = [pkgs.makeWrapper];
          postBuild = ''
            wrapProgram $out/bin/claude ${lib.concatStringsSep " " (lib.mapAttrsToList (name: value: "--set ${name} ${lib.escapeShellArg value}") cfg.environmentVariables)}
          '';
          meta.mainProgram = "claude";
        };
      }

      # settings
      {
        home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [
          inputs.claude-desktop.packages.${system}.claude-desktop
        ];

        programs.claude-code = {
          enable = true;
          environmentVariables.CLAUDE_CODE_DISABLE_AUTO_MEMORY = "1";
          context = ''
            @~/AGENTS.md
          '';
        };
      }
    ];
  };
}
