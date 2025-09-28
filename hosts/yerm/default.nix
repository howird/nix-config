{inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.framework-13-7040-amd
    ./hardware-configuration.nix
    inputs.niri.nixosModules.niri
  ];

  # programs.hyprland.enable = true;
  programs.niri.enable = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
  };

  services = {
    syncthing.enable = true;
    upower.enable = true;
    kanata = {
      enable = true;
      keyboards.laptop.configFile = ../../configs/keyboards/kanata/framework.kbd;
      # keyboards.foldable.configFile = ../../configs/keyboards/kanata/protoarc.kbd;
    };
    # udev.extraRules = ''
    #   SUBSYSTEM=="input", KERNEL=="event*", ENV{LIBINPUT_DEVICE_GROUP}=="5/3554/f605:2c:98:11:3d:41:26", SYMLINK+="input/protoarc-kbd"
    # '';
  };
}
