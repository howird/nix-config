{
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [7400 7401];

    # Allow multicast ranges used by DDS
    allowedUDPPortRanges = [
      {
        from = 7400;
        to = 7500;
      }
    ];
  };
}
