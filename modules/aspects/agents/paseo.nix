{inputs, ...}: {
  flake-file.inputs.paseo = {
    url = "github:getpaseo/paseo";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.paseo.homeManager = {pkgs, ...}: let
    paseo = inputs.paseo.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    home.packages = [
      paseo.paseo
      paseo.desktop
    ];
  };

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
