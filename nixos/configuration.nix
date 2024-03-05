# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
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
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # synaptics touchpad t480s
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];

  networking.hostName = "nixwird-t480";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Wayland Stuff
  xdg.portal.wlr.enable = true;

  # X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [ pkgs.xterm ];

    # Enable touchpad support (enabled default in most desktopManager)
    # libinput.enable = false;
    # synaptics.enable = true;
  
    # configure keymap
    layout = "us";
    xkbVariant = "";
  };

  # https://discourse.nixos.org/t/howto-disable-most-gnome-default-applications-and-what-they-are/13505
  environment.gnome.excludePackages = with pkgs.gnome; [
    epiphany    # web browser
    yelp        # help viewer
    # file-roller # archive manager
    geary       # email client
    seahorse    # password manager

    # these should be self explanatory
    gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts
    gnome-weather pkgs.gnome-connections pkgs.gnome-tour
    #gnome-font-viewer gnome-logs gnome-maps gnome-music gnome-photos
    #gnome-system-monitor gnome-disk-utility gnome-screenshot
  ];

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

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  users.users = {
    howird = {
      isNormalUser = true;
      description = "Howard Nguyen-Huu";
      extraGroups = [ "networkmanager" "wheel" "docker" "audio" ];
      shell = pkgs.zsh;
    };
  };

  programs = {
    git.enable = true;
    zsh.enable = true;
    nano.enable = false;
    tmux.enable = true;
    chromium.enable = true;
    neovim.enable = true;

    # hyprland
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      xwayland.enable = true;
    };
  };

  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
  };

  # List packages installed in system profile. To search, run: `nix search wget`
  environment.systemPackages = (with pkgs; [
    home-manager

    alacritty
    eza
    ripgrep
    bat

    python3
    ffmpeg-headless
    wget

    # Will sometimes need to clear vivaldi GPUCache after update
    # rm -rf ~/.config/vivaldi/Default/GPUCache ~/.config/vivaldi/Default/Storage/ext/**/GPUCache
    vivaldi
    widevine-cdm
  ]) ++ (with pkgs.unstable; [
    # hyprland
    xdg-desktop-portal-hyprland
    swww
    waybar
    dunst
    libnotify
    rofi-wayland
    networkmanagerapplet
    grim
    slurp
    wl-clipboard
  ]);

  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];


  virtualisation.docker.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
