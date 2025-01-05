{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  host,
  ...
}: {
  imports = [
    ./desktops
    ./packages.nix
    ./stylix.nix
    ./boot.nix
    ./nixpkgs.nix
  ];

  networking.networkmanager.enable = true;
  networking.hostName = "${host}";

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_US.UTF-8";

  services.printing.enable = true;
  services.xserver.wacom.enable = true;

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.libinput.enable = true;

  users.users = {
    howird = {
      isNormalUser = true;
      description = "Howard Nguyen-Huu";
      extraGroups = ["networkmanager" "wheel" "docker" "audio" "video" "render"];
      shell = pkgs.zsh;
    };
  };

  services.flatpak.enable = true;

  virtualisation.docker.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
