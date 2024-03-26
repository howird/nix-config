{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./modules/gnome.nix
    ./modules/hyprland.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];

    config = {
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  # nix.nixPath = ["/etc/nix/path"];
  # environment.etc =
  #   lib.mapAttrs'
  #   (name: value: {
  #     name = "nix/path/${name}";
  #     value.source = value.flake;
  #   })
  #   config.nix.registry;

  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users = {
    howird = {
      isNormalUser = true;
      description = "Howard Nguyen-Huu";
      extraGroups = [ "networkmanager" "wheel" "docker" "audio" ];
      shell = pkgs.fish;
    };
  };

  # List packages installed in system profile. To search, run: `nix search wget`
  environment.systemPackages = # let ollama = pkgs.ollama.override { acceleration = "rocm"; }; in
  with pkgs; [
    home-manager

    # utilities
    neofetch
    htop
    lsof
    pciutils
    cachix
    wget
    zoxide
    eza
    ripgrep
    bat
    fd
    fzf
    yt-dlp
    gitui
    ncspot

    # apps
    vlc
    # sometimes vivaldi's GPUCache must be cleared after an update
    # rm -rf ~/.config/vivaldi/Default/GPUCache ~/.config/vivaldi/Default/Storage/ext/**/GPUCache
    vivaldi
    widevine-cdm
    amberol
    openconnect
    gimp
    gtkwave

    # programming
    python3
    ffmpeg-headless
    nodejs
    cargo
    rustc
  ];

  programs = {
    git.enable = true;
    zsh.enable = true;
    fish.enable = true;
    tmux.enable = true;
    chromium.enable = true;
  };

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  virtualisation.docker.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
