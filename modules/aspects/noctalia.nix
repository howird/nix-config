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
        # One `full.dotted.path = value` line per leaf, so every diff line
        # carries its whole path rather than relying on hunk context for the
        # parent keys. Arrays stay whole on one line: reorders read as a
        # single change instead of a cascade of shifted indices.
        text = ''
          norm() {
            yj -tj | jq -r '
              def key: if test("^[A-Za-z_][A-Za-z0-9_-]*$") then . else tojson end;
              def leaves($p):
                if type == "object" and length > 0
                then to_entries[] as $e | $e.value | leaves($p + [$e.key | key])
                else "\($p | join(".")) = \(tojson)"
                end;
              leaves([])' | sort
          }

          exec diff -U0 --color=auto --label nix --label gui \
            <(norm <"''${XDG_CONFIG_HOME:-$HOME/.config}/noctalia/config.toml") \
            <(noctalia config export | norm)
        '';
      })
    ];
  };
}
