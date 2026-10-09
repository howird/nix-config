{
  den.aspects.mobile.nixos = {
    pkgs,
    hostUsers,
    ...
  }: {
    services.usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };

    environment.systemPackages = with pkgs; [
      libimobiledevice
      ifuse
      android-tools

      scrcpy
    ];

    programs.weylus = {
      enable = true;
      users = hostUsers;
      openFirewall = true;
    };
  };
}
