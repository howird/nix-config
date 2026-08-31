{...}: {
  den.aspects.input-devices.nixos = {
    services.libinput.enable = true;
    services.xserver.wacom.enable = true;
    # hardware.opentabletdriver.enable = true;
    # hardware.opentabletdriver.daemon.enable = true;
  };
}
