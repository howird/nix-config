{...}: {
  den.aspects.kanata.nixos = {
    services.kanata.enable = true;
  };

  # One-time manual steps after the first `darwin-rebuild switch` for a host
  # enabling this (Apple gates these behind GUI approval; nix can't do them
  # for us):
  #   1: Go to System Settings app and do the following:
  #     A. Privacy & Security: approve the "pqrs.org" system extension when
  #        prompted
  #     B. General > Login Items & Extensions:
  #        I) App Background Activity: allow kanata and
  #           Karabiner-Virtual-HIDDevice-Daemon
  #        II) Extensions: enable Karabiner-Virtual-HIDDevice-Manager
  #     C. Privacy & Security > {Input Monitoring, Accessibility} add and
  #        allow `/usr/local/libexec/kanata`
  #
  #   2: Run: `sudo launchctl kickstart -k system/org.nixos.kanata`
  den.aspects.kanata.darwin = {
    config,
    pkgs,
    lib,
    ...
  }: let
    cfg = config.services.kanata;

    # driver-version-pinned to match what this kanata build was tested
    # against (see nixpkgs' kanata package.nix passthru).
    karabinerDriver = pkgs.kanata.passthru.darwinDriver;
    karabinerManagerApp = "/Applications/.Karabiner-VirtualHIDDevice-Manager.app";
    karabinerDaemonApp = "/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app";
  in {
    options.services.kanata = {
      enable = lib.mkEnableOption "kanata keyboard remapping (via Karabiner's VirtualHIDDevice driver)";
      configFile = lib.mkOption {
        type = lib.types.path;
        description = "kanata .kbd config file to run.";
      };
    };

    config = lib.mkIf cfg.enable {
      environment.systemPackages = [pkgs.kanata];

      system.activationScripts.postActivation.text = lib.mkAfter ''
        echo "setting up kanata..." >&2

        mkdir -p "$(dirname "${karabinerDaemonApp}")"
        rm -rf "${karabinerManagerApp}" "${karabinerDaemonApp}"
        ditto "${karabinerDriver}/Applications/.Karabiner-VirtualHIDDevice-Manager.app" "${karabinerManagerApp}"
        ditto "${karabinerDriver}/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app" "${karabinerDaemonApp}"
        chown -R root:wheel "${karabinerManagerApp}" "/Library/Application Support/org.pqrs"

        "${karabinerManagerApp}/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager" activate || true

        # copied to a stable path (rather than referencing /nix/store directly)
        # so the Input Monitoring/Accessibility grants below survive future
        # store-path changes from package updates.
        mkdir -p /usr/local/libexec
        cp -f ${pkgs.kanata}/bin/kanata /usr/local/libexec/kanata
        chmod 755 /usr/local/libexec/kanata
      '';

      launchd.daemons."Karabiner-DriverKit-VirtualHIDDevice-Daemon" = {
        serviceConfig = {
          Label = "org.pqrs.Karabiner-DriverKit-VirtualHIDDevice-Daemon";
          ProgramArguments = ["${karabinerDaemonApp}/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon"];
          RunAtLoad = true;
          KeepAlive = true;
          ProcessType = "Interactive";
        };
      };

      launchd.daemons.kanata = {
        serviceConfig = {
          ProgramArguments = [
            "/usr/local/libexec/kanata"
            "--cfg"
            "${cfg.configFile}"
          ];
          RunAtLoad = true;
          KeepAlive = true;
          StandardOutPath = "/var/log/kanata.log";
          StandardErrorPath = "/var/log/kanata.log";
        };
      };
    };
  };
}
