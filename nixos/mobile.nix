{pkgs, ...}: {
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse

    scrcpy
  ];

  programs.weylus = {
    enable = true;
    users = ["howird"];
    openFirewall = true;
  };
}
