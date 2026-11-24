{
  inputs,
  den,
  ...
}: {
  den.homes.aarch64-darwin."howird@sticker-mac-mini" = {
    # Standalone homes do not inherit the system's nixpkgs configuration.
    pkgs = import inputs.nixpkgs {
      system = "aarch64-darwin";
      overlays = [inputs.helix-plugins.overlays.default];
      config.allowUnfree = true;
    };

    aspect = {
      includes = [den.aspects.howird];
      homeManager = {
        config,
        lib,
        pkgs,
        ...
      }: {
        myShell.hmFlakeArgs = "#${config.home.username}@sticker-mac-mini";

        home.packages = with pkgs; [ouch];

        programs.codex.enable = true;

        # Remote Login (sshd) is managed by macOS, not services.openssh.enable.
        programs.zellij.webServer.enable = true;
        services.gpg-agent.enable = lib.mkForce false;
        myMcp.servers.plane.enable = false;
      };
    };
  };
}
