{
  den.aspects.bluetooth.nixos = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  den.aspects.bluetooth.homeManager = {pkgs, ...}: {
    home.packages = with pkgs; [
      bluetui
      bluez
    ];
  };
}
