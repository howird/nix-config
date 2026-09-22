{config, ...}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "XF86AudioRaiseVolume" = {
      action = spawn "swayosd-client" "--output-volume" "+2" "--max-volume=100";
      allow-when-locked = true;
      repeat = true;
    };
    "XF86AudioLowerVolume" = {
      action = spawn "swayosd-client" "--output-volume" "-2";
      allow-when-locked = true;
      repeat = true;
    };
    "XF86AudioMute" = {
      action = spawn "swayosd-client" "--output-volume" "mute-toggle";
      allow-when-locked = true;
      repeat = false;
    };

    # Brightness controls
    "XF86MonBrightnessUp" = {
      action = spawn "swayosd-client" "--brightness" "+5";
      allow-when-locked = true;
      repeat = true;
    };
    "XF86MonBrightnessDown" = {
      action = spawn "swayosd-client" "--brightness" "-5";
      allow-when-locked = true;
      repeat = true;
    };
  };
}
