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
    # and upower come from the hosts, networkmanager from defaults.nix, and
    # power-profiles-daemon from `recommendedServices` below. Hence
    # `package = null` - there is nothing to install system-wide.
    programs.noctalia = {
      enable = config.programs.niri.enable;
      package = null;
      recommendedServices.enable = true;
    };

    # programs.niri.enable makes niri-flake run polkit-kde-agent-1 as
    # niri-flake-polkit.service. noctalia registers an agent of its own
    # (shell.polkit_agent in _noctalia/settings.nix) and polkit accepts only
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
      ./_noctalia/settings.nix
    ];

    programs.noctalia = {
      enable = true;
      # niri spawns it (see ./_noctalia/niri.nix) rather than a user unit:
      # with the unit, every app started from the launcher is killed whenever
      # the unit restarts.
      systemd.enable = false;
    };

    # What the GUI is overriding that ./_noctalia/settings.nix does not say.
    # `config export` is the deployed config.toml with the shell's state-dir
    # settings.toml merged on top, so diffing it against that same config.toml
    # leaves exactly the GUI's tweaks - which outrank the repo at runtime and
    # are lost on the next machine. Port what you want to keep into settings.nix.
    #
    # Both sides go through json because they come from different TOML writers:
    # raw, the diff is ~180 lines of indentation, array wrapping and float
    # spelling (0.29999999999999999 vs 0.3) with the real changes buried in it.
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
