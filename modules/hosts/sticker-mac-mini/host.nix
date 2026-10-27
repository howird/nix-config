{den, ...}: {
  den.hosts.aarch64-darwin.sticker-mac-mini.users.howird = {};

  den.aspects.sticker-mac-mini.includes = [
    den.aspects.paseo-daemon
    den.aspects.homebrew
  ];

  den.aspects.sticker-mac-mini.darwin = {
    lib,
    pkgs,
    ...
  }: let
    colimaUser = "sticker";
    colimaHome = "/Users/${colimaUser}/.colima";
    colimaSocket = "${colimaHome}/default/docker.sock";
    # a partial file zeroes the keys it leaves out, so this mirrors colima's
    # embedded/defaults/colima.yaml in full. vmType, mountType, runtime and arch
    # are fixed once the VM exists; changing them needs a `colima delete`.
    colimaConfig = (pkgs.formats.yaml {}).generate "colima.yaml" {
      # Docker Desktop's defaults: every core, half the RAM, a 64G sparse disk
      cpu = 10;
      memory = 8;
      disk = 64;
      rootDisk = 20;
      arch = "host";
      cpuType = "host";
      vmType = "vz";
      rosetta = true;
      binfmt = true;
      nestedVirtualization = false;
      runtime = "docker";
      # colima turns on buildkit and the containerd image store when this is empty
      docker = {};
      modelRunner = "docker";
      autoActivate = true;
      kubernetes = {
        enabled = false;
        version = "v1.35.0+k3s1";
        k3sArgs = ["--disable=traefik"];
        port = 0;
      };
      network = {
        address = false;
        mode = "shared";
        interface = "en0";
        preferredRoute = false;
        dns = [];
        dnsHosts."host.docker.internal" = "host.lima.internal";
        hostAddresses = false;
        gatewayAddress = "192.168.5.2";
      };
      portForwarder = "ssh";
      forwardAgent = false;
      sshConfig = true;
      sshPort = 0;
      # every admin shares this VM, so mount all homes. The VM runs as sticker,
      # so containers can only write where sticker can; open a repo up with
      #   chmod -R +a "group:admin allow read,write,append,delete,add_file,add_subdirectory,delete_child,readattr,writeattr,readextattr,writeextattr,readsecurity,file_inherit,directory_inherit" ~/repos
      mountType = "virtiofs";
      mountInotify = false;
      mounts = [
        {
          location = "/Users";
          writable = true;
        }
      ];
      provision = [];
      diskImage = "";
      forceDiskImage = false;
      env = {};
    };
  in {
    networking.computerName = "sticker-mac-mini";
    networking.localHostName = "sticker-mac-mini";

    environment.systemPackages = with pkgs; [
      # system-wide so other users ssh'ing in from ghostty get its terminfo
      ghostty-bin.terminfo
      # bundles the compose and buildx plugins
      docker-client
      # credsStore = "osxkeychain" used Docker Desktop's copy of the helper
      docker-credential-helpers
      colima
    ];

    # macOS /bin/zsh's ncurses ignores TERMINFO_DIRS changes after startup, so
    # set-environment's export comes too late; hand it to the login shell up front.
    services.openssh.extraConfig = ''
      SetEnv TERMINFO_DIRS=/run/current-system/sw/share/terminfo:/usr/share/terminfo
    '';

    # brew's colima service is a login agent; this starts at boot with no login
    launchd.daemons.colima = {
      # colima writes merged settings back into colima.yaml on start, so it gets
      # a fresh copy rather than a read-only store symlink
      script = ''
        mkdir -p ${colimaHome}/default
        install -m 644 ${colimaConfig} ${colimaHome}/default/colima.yaml
        # lima 2.2 leaves an orphaned vz VM after an unclean shutdown and the
        # next start crash-loops; drop once lima >= 2.3 (lima-vm/lima#5088)
        colima stop --force >>${colimaHome}/daemon.log 2>&1 || true
        exec colima start --foreground >>${colimaHome}/daemon.log 2>&1
      '';
      path = [pkgs.colima pkgs.docker-client "/usr/bin" "/bin" "/usr/sbin" "/sbin"];
      environment.HOME = "/Users/${colimaUser}";
      serviceConfig = {
        UserName = colimaUser;
        GroupName = "staff";
        RunAtLoad = true;
        # a manual `colima stop` exits cleanly and stays stopped
        KeepAlive.SuccessfulExit = false;
        ThrottleInterval = 10;
      };
    };

    # colima's socket is sticker-only 0600; re-expose it at the standard path for admins
    launchd.daemons.docker-socket.serviceConfig = {
      ProgramArguments = [
        (lib.getExe pkgs.socat)
        "UNIX-LISTEN:/var/run/docker.sock,fork,unlink-early,user=root,group=admin,mode=660"
        "UNIX-CONNECT:${colimaSocket}"
      ];
      RunAtLoad = true;
      KeepAlive = true;
    };

    nix-homebrew.autoMigrate = true;
    homebrew.user = "sticker";

    homebrew = {
      casks = [
        "claude-code"
        "codex"
      ];
    };
  };

  den.aspects.sticker-mac-mini.homeManager = {lib, ...}: {
    services.gpg-agent.enable = lib.mkForce false;
    myMcp.servers.plane.enable = false;
  };
}
