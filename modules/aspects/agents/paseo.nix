{
  inputs,
  den,
  ...
}: {
  flake-file.inputs.paseo = {
    url = "github:getpaseo/paseo";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # The CLI and `paseo-server`. Comes with whichever daemon aspect a machine
  # runs; the Electron client is separate so headless hosts never get it.
  den.aspects.paseo.homeManager = {pkgs, ...}: {
    home.packages = [inputs.paseo.packages.${pkgs.stdenv.hostPlatform.system}.paseo];
  };

  den.aspects.paseo-desktop.homeManager = {pkgs, ...}: {
    home.packages = [inputs.paseo.packages.${pkgs.stdenv.hostPlatform.system}.desktop];
  };

  den.aspects.paseo-daemon.includes = [den.aspects.paseo];
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

  # nix-darwin has no paseo module, so this mirrors the nixos one: a system
  # daemon that starts at boot, no login needed, running as howird.
  den.aspects.paseo-daemon.darwin = {
    config,
    lib,
    pkgs,
    ...
  }: let
    user = "howird";
    home = "/Users/${user}";
    paseo = inputs.paseo.packages.${pkgs.stdenv.hostPlatform.system}.paseo;
  in {
    launchd.daemons.paseo = {
      # launchd won't create PASEO_HOME or a log the user can write, so the
      # script does both after dropping to the user
      script = ''
        mkdir -p "$PASEO_HOME"
        exec ${lib.getExe' paseo "paseo-server"} --no-relay >>"$PASEO_HOME/daemon.log" 2>&1
      '';
      environment = {
        HOME = home;
        PASEO_HOME = "${home}/.paseo";
        PASEO_LISTEN = "0.0.0.0:6767";
        # IPs are always allowed; this admits MagicDNS names too
        PASEO_HOSTNAMES = "${config.networking.hostName},.ts.net";
        # agents need the home-manager tools (claude, pi, git, ...)
        PATH = lib.concatStringsSep ":" [
          "/etc/profiles/per-user/${user}/bin"
          "/run/current-system/sw/bin"
          "/nix/var/nix/profiles/default/bin"
          "/usr/local/bin"
          "/usr/bin"
          "/bin"
        ];
      };
      serviceConfig = {
        UserName = user;
        GroupName = "staff";
        RunAtLoad = true;
        KeepAlive.SuccessfulExit = false;
        ThrottleInterval = 5;
      };
    };
  };

  # Runs as the user, for machines we don't have root on (howard@vip).
  den.aspects.paseo-user-daemon.includes = [den.aspects.paseo];
  den.aspects.paseo-user-daemon.homeManager = {
    config,
    lib,
    pkgs,
    ...
  }: let
    paseo = inputs.paseo.packages.${pkgs.stdenv.hostPlatform.system}.paseo;
  in {
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
