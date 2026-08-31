{inputs, ...}: {
  den.default.nixos = {
    host,
    pkgs,
    ...
  }: {
    _module.args.inputs = inputs;

    imports = [
      ./aspects/_nixos/desktop
      ./aspects/_nixos/system-packages.nix
      (import ./aspects/_nixos/style.nix inputs)
      ./aspects/_nixos/boot.nix
      ./aspects/_nixos/nixpkgs-settings.nix
      (import ./aspects/_nixos/syncthing.nix host)
      ./aspects/_nixos/emulators.nix
      ./aspects/_nixos/input-devices.nix
      ./aspects/_nixos/mobile.nix
      ./aspects/_nixos/files.nix
      ./aspects/_nixos/firewall.nix
      inputs.niri.nixosModules.niri
    ];

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

    imports = [
      (import ./aspects/_home/editors inputs)
      (import ./aspects/_home/shells inputs)
      ./aspects/_home/ghostty.nix
      ./aspects/_home/git.nix
      ./aspects/_home/htop.nix
      ./aspects/_home/programming.nix
      ./aspects/_home/sioyek.nix
      ./aspects/_home/typesetting.nix
      # ./aspects/_home/voxtype.nix
      ./aspects/_home/yazi.nix
    ];

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
