{inputs, ...}: {
  flake-file.inputs = {
    pi.url = "github:earendil-works/pi/main";
  };

  den.aspects.pi.homeManager = {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = [
      ./_pi/binds.nix
      ./_pi/plugins.nix
      ./_pi/settings.nix
      ./_pi/themes.nix
    ];

    home.file = {
      ".pi/agent/AGENTS.md".source =
        config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/AGENTS.md";
      ".pi/agent/APPEND_SYSTEM.md".source = ./_pi/APPEND_SYSTEM.md;
    };

    programs.pi-coding-agent = {
      enable = true;
      mutableSettings = true;
      extraPackages = with pkgs; [bun gnumake gcc python3 git openssh];
      package = pkgs.symlinkJoin {
        name = "pi-coding-agent";
        paths = [inputs.pi.packages.${pkgs.stdenv.hostPlatform.system}.default];
        nativeBuildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/pi \
            --set SHELL ${lib.getExe pkgs.bash} \
            --set PI_SKIP_VERSION_CHECK 1 \
            --set PI_SUBAGENT_ZELLIJ_PLACEMENT tab-stack
        '';
        meta.mainProgram = "pi";
      };
    };
  };
}
