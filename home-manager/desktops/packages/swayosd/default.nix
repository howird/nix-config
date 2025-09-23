# {config, ...}: {
{pkgs, ...}: {
  imports = [
    ./styles.nix
  ];

  # services.swayosd.enable = config.myDesktop.hyprland;
  home.packages = with pkgs; [
    swayosd
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "swayosd-server"
    ];

    bind = [
      ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
    ];

    # lockscreen
    bindl = [
      ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise 5%+"
      ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower 5%-"
      "$mainMod, XF86MonBrightnessUp, exec, brightnessctl set 100%"
      "$mainMod, XF86MonBrightnessDown, exec, brightnessctl set 0%"
    ];
    # lockscreen + repeat
    bindle = [
      ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume +2 --max-volume=100"
      ",XF86AudioLowerVolume, exec, swayosd-client --output-volume -2"

      "$mainMod, f11, exec, swayosd-client --output-volume +2 --max-volume=100"
      "$mainMod, f12, exec, swayosd-client --output-volume -2"
    ];
    # trigger on release
    bindr = [
      "CAPS,Caps_Lock,exec,swayosd-client --caps-lock"
      ",Scroll_Lock,exec,swayosd-client --scroll-lock"
      ",Num_Lock,exec,swayosd-client --num-lock"
    ];
  };
}
