{
  config,
  host,
  lib,
  ...
}: {
  services.hypridle = {
    inherit (config.programs.niri) enable;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        inhibit_sleep = 3;
        ignore_dbus_inhibit = false;
      };

      listener =
        [
          {
            # idle warnings
            timeout = 540; # 9 mins
            on-timeout = "notify-send 'You are idle!'";
            on-resume = "notify-send 'Welcome back!'";
          }
          {
            # lockscreen
            timeout = 600; # 10 mins
            on-timeout = "loginctl lock-session";
            # on-resume = "notify-send 'Welcome back to your desktop!'";
          }
          {
            # screen off when locked
            timeout = 30;
            on-timeout = "pidof hyprlock && hyprctl dispatch dpms off";
            on-resume = "pidof hyprlock && hyprctl dispatch dpms on";
          }
        ]
        ++ (
          lib.optional (host != "bofa") {
            # suspend
            timeout = 1200;
            on-timeout = "systemctl suspend";
            on-resume = "notify-send 'Welcome back to your desktop!'";
          }
        );
    };
  };
}
