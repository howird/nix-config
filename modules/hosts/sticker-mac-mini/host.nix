{den, ...}: {
  den.hosts.aarch64-darwin.sticker-mac-mini.users.howird = {};

  den.aspects.sticker-mac-mini.includes = [
    den.aspects.paseo-daemon
    den.aspects.homebrew
  ];

  den.aspects.sticker-mac-mini.darwin = {pkgs, ...}: {
    networking.computerName = "sticker-mac-mini";
    networking.localHostName = "sticker-mac-mini";

    environment.systemPackages = with pkgs; [
      git
    ];

    nix-homebrew.autoMigrate = true;
    homebrew.user = "sticker";

    homebrew = {
      casks = [
        "claude-code"
        "codex"
        "docker-desktop"
      ];
    };
  };

  den.aspects.sticker-mac-mini.homeManager = {lib, ...}: {
    services.gpg-agent.enable = lib.mkForce false;
  };
}
