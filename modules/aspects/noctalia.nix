{inputs, ...}: {
  flake-file.inputs.noctalia.url = "github:noctalia-dev/noctalia";

  den.aspects.noctalia.nixos = {
    config,
    lib,
    ...
  }: {
    imports = [inputs.noctalia.nixosModules.default];

    # The shell itself is a home-manager package spawned by niri, so the NixOS
    # side exists only for the system services its widgets talk to: bluetooth
    # and upower come from the hosts, networkmanager from networking.nix, and
    # power-profiles-daemon from `recommendedServices` below. Hence
    # `package = null` - there is nothing to install system-wide.
    programs.noctalia = {
      enable = true;
      package = null;
      recommendedServices.enable = true;
    };

    # programs.niri.enable makes niri-flake run polkit-kde-agent-1 as
    # niri-flake-polkit.service. noctalia registers an agent of its own
    # (shell.polkit_agent in _noctalia/system.nix) and polkit accepts only
    # one registration per session, so with both on one silently loses the
    # race - and the KDE one pulls kdePackages in for a prompt that may never
    # be drawn.
    systemd.user.services.niri-flake-polkit.enable =
      lib.mkIf config.programs.noctalia.enable false;
  };

  den.aspects.noctalia.homeManager = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      inputs.noctalia.homeModules.default

      ./_noctalia/niri.nix
      ./_noctalia/appearance.nix
      ./_noctalia/bar.nix
      ./_noctalia/lockscreen.nix
      ./_noctalia/system.nix
    ];

    programs.noctalia = {
      enable = true;
      # niri spawns it (see ./_noctalia/niri.nix) rather than a user unit:
      # with the unit, every app started from the launcher is killed whenever
      # the unit restarts.
      systemd.enable = false;
    };

    home.packages = [
      (pkgs.writeShellApplication {
        name = "noctalia-cfg-drift";
        runtimeInputs = [pkgs.yj pkgs.jq config.programs.noctalia.package];
        text = ''
          norm() { yj -tj | jq -S; }

          exec diff -u --color=auto --label nix --label gui \
            <(norm <"''${XDG_CONFIG_HOME:-$HOME/.config}/noctalia/config.toml") \
            <(noctalia config export | norm)
        '';
      })
    ];
  };
}
