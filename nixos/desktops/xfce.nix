{
  lib,
  config,
  pkgs,
  ...
}:
lib.mkIf config.myDesktop.xfce {
  services.xserver = {
    desktopManager.xfce.enable = true;
    desktopManager.xfce.enableXfwm = true;
    displayManager.lightdm.enable = true;
    excludePackages = [pkgs.xterm];
  };

  services.blueman.enable = true;
  programs.xfconf.enable = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-media-tags-plugin
    thunar-volman
  ];

  environment.systemPackages = with pkgs; [
    blueman
    drawing
    evince
    font-manager
    file-roller
    gnome-disk-utility
    pavucontrol
    qalculate-gtk
    wmctrl
    xclip
    xcolor
    xdo
    xdotool
    xfce.catfish
    xfce.gigolo
    xfce.xfce4-appfinder
    xfce.xfce4-clipman-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-dict
    xfce.xfce4-fsguard-plugin
    xfce.xfce4-genmon-plugin
    xfce.xfce4-netload-plugin
    xfce.xfce4-panel
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-systemload-plugin
    xfce.xfce4-weather-plugin
    # xfce.xfce4-whiskermenu-plugin
    # xfce.xfce4-xkb-plugin
    xfce.xfdashboard
    # xorg.xev
    xsel
    xtitle
    xwinmosaic
    # zuki-themes
  ];
}
