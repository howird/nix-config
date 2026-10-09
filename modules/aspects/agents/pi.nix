{inputs, ...}: {
  flake-file.inputs = {
    pi = {
      url = "github:lukasl-dev/pi.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.pi.homeManager = {
    config,
    pkgs,
    lib,
    ...
  }: {
    imports = [
      inputs.pi.homeModules.default
      ./_pi/binds.nix
      ./_pi/plugins.nix
      ./_pi/settings.nix
    ];

    home.file.".pi/agent/AGENTS.md".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/AGENTS.md";

    programs.pi.coding-agent = {
      enable = true;
      # toolchain for native deps (e.g. node-pty) that bun builds when installing pi packages
      package = pkgs.symlinkJoin {
        name = "pi-coding-agent-bun";
        paths = [inputs.pi.packages.${pkgs.stdenv.hostPlatform.system}.coding-agent-bun];
        nativeBuildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/pi --suffix PATH : ${lib.makeBinPath [pkgs.gnumake pkgs.gcc pkgs.python3]}
        '';
        meta.mainProgram = "pi";
      };
    };
  };
}
