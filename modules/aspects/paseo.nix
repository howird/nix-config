{inputs, ...}: {
  flake-file.inputs.paseo = {
    url = "github:getpaseo/paseo";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # The desktop app spawns its own daemon (port 6767, state in ~/.paseo)
  # unless one is already running there; `paseo` is the CLI for that daemon.
  den.aspects.paseo.homeManager = {pkgs, ...}: let
    paseo = inputs.paseo.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    home.packages = [
      paseo.paseo
      paseo.desktop
    ];
  };

  # Always-on daemon for reaching this host's agents from other machines.
  # It runs as howird on ~/.paseo, so agents use howird's tools and logins,
  # and a local desktop app attaches to it instead of starting its own.
  # Bound on all interfaces but the port stays closed in the firewall, so
  # only the trusted tailscale0 interface reaches it; no hosted relay.
  den.aspects.paseo-daemon.nixos = {config, ...}: {
    imports = [inputs.paseo.nixosModules.paseo];

    services.paseo = {
      enable = true;
      user = "howird";
      group = "users";
      listenAddress = "0.0.0.0";
      # IPs are always allowed; this admits MagicDNS names too
      hostnames = [config.networking.hostName ".ts.net"];
      relay.enable = false;
    };
  };

  # paseo-daemon for machines we don't have root on (howard@vip), as a user
  # service like tailscale-userspace. It binds localhost: the userspace
  # tailscaled forwards inbound tailnet connections there, so it is still
  # reachable on the tailnet.
  den.aspects.paseo-user-daemon.homeManager = {
    config,
    lib,
    pkgs,
    ...
  }: let
    paseo = inputs.paseo.packages.${pkgs.stdenv.hostPlatform.system}.paseo;
  in {
    home.packages = [paseo];

    systemd.user.services.paseo = {
      Unit.Description = "Paseo daemon";
      Service = {
        Environment = [
          "PASEO_HOME=${config.home.homeDirectory}/.paseo"
          "PASEO_LISTEN=127.0.0.1:6767"

          # agents need the home-manager tools (claude, pi, git, ...)
          "PATH=${lib.concatStringsSep ":" [
            "${config.home.profileDirectory}/bin"
            "/nix/var/nix/profiles/default/bin"
            "/usr/local/bin"
            "/usr/bin"
            "/bin"
          ]}"
        ];
        # one config serves several servers, so read each one's MagicDNS
        # short name at start; IPs are always allowed
        ExecStart = toString (pkgs.writeShellScript "paseo-daemon" ''
          export PASEO_HOSTNAMES="$(${lib.getExe' pkgs.hostname "hostname"} -s),.ts.net"
          exec ${lib.getExe' paseo "paseo-server"} --no-relay
        '');
        Restart = "on-failure";
        RestartSec = 5;
        TimeoutStopSec = 15;
      };
      Install.WantedBy = ["default.target"];
    };
  };
}
