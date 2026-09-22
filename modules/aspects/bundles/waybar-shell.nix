{den, ...}: {
  # The desktop shell as a stack of separate programs: bar, notifications,
  # OSD, launcher, lock screen, idle, battery warnings, wallpaper and
  # clipboard manager. den.aspects.noctalia is the alternative - it does all
  # of this in one process. Include one or the other, never both.
  den.aspects.bundles.waybar-shell.includes = [
    den.aspects.waybar
    den.aspects.swaync
    den.aspects.swayosd
    den.aspects.rofi
    den.aspects.hyprlock
    den.aspects.hypridle
    den.aspects.batsignal
    den.aspects.awww
    den.aspects.cursor-clip
  ];

  den.aspects.bundles.waybar-shell.homeManager = {
    config,
    pkgs,
    ...
  }: {
    # Tray applet for NetworkManager. noctalia has a native network widget,
    # so this belongs to the waybar stack rather than to niri.
    home.packages = [pkgs.networkmanagerapplet];

    programs.niri.settings.binds = with config.lib.niri.actions; {
      # Screenshots and media transport are shell-owned: noctalia handles both
      # itself (with an annotation editor and an OSD respectively), so under
      # this stack they fall back to niri's built-ins and playerctl.
      "Mod+S".action.screenshot = {show-pointer = false;};
      "Mod+Shift+S".action.screenshot-window = {write-to-disk = false;};

      "XF86AudioPlay" = {
        action = spawn "playerctl" "play-pause";
        allow-when-locked = true;
      };
      "XF86AudioNext" = {
        action = spawn "playerctl" "next";
        allow-when-locked = true;
      };
      "XF86AudioPrev" = {
        action = spawn "playerctl" "previous";
        allow-when-locked = true;
      };
      "XF86AudioStop" = {
        action = spawn "playerctl" "stop";
        allow-when-locked = true;
      };
    };
  };
}
