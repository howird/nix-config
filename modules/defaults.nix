{
  den,
  inputs,
  ...
}: {
  # Every NixOS host gets these by default — replaces the old manual
  # `imports = [ <raw file paths> ]` list, which also meant `host`/`user`
  # never reached those files as real den context args (only plain module
  # composition). Promoting each to its own top-level `den.aspects.<name>`
  # and including it here lets den's own dispatch inject `host`/`user`
  # directly (see aspects/syncthing.nix).
  den.schema.host.includes = [
    den.aspects.niri
    den.aspects.gdm
    den.aspects.stylix
    den.aspects.system-packages
    den.aspects.boot
    den.aspects.nixpkgs-settings
    den.aspects.syncthing
    den.aspects.emulators
    den.aspects.input-devices
    den.aspects.mobile
    den.aspects.files
    den.aspects.firewall
  ];

  den.default.nixos = {
    host,
    pkgs,
    ...
  }: {
    # Makes `inputs` available as a plain specialArg to every nixos-class
    # aspect for this host, regardless of whether it's a top-level
    # `den.aspects.<name>.nixos` (den's own context-injection only threads
    # `host`/`user`, not `inputs`) or nested content.
    _module.args.inputs = inputs;

    networking.networkmanager.enable = true;
    networking.hostName = host.name;

    time.timeZone = "America/Toronto";
    i18n.defaultLocale = "en_US.UTF-8";

    services.printing.enable = true;

    services.xserver.enable = true;
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    users.users.howird = {
      isNormalUser = true;
      description = "Howard Nguyen-Huu";
      extraGroups = ["networkmanager" "wheel" "docker" "audio" "video" "render" "kvm" "adbusers"];
      shell = pkgs.zsh;
    };

    services.flatpak.enable = true;

    virtualisation.docker.enable = true;

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "old";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.11";
  };

  den.default.homeManager = {
    lib,
    config,
    ...
  }: {
    _module.args.inputs = inputs;

    programs.zsh.enable = true;
    programs.helix.enable = true;

    programs.home-manager.enable = true;
    home = {
      username = lib.mkDefault "howird";
      homeDirectory = "/home/${config.home.username}";
      sessionPath = ["$HOME/.local/bin"];
    };

    # Nicely reload system units when changing configs
    systemd.user.startServices = "sd-switch";

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    home.stateVersion = "23.11";
  };
}
