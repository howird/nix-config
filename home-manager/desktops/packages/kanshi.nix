{
  config,
  lib,
  ...
}: {
  services.kanshi = {
    enable = config.programs.hyprland.enable || config.programs.niri.enable;

    settings =
      [
        {
          profile.name = "undocked";
          profile.outputs = [
            {
              criteria = "eDP-1";
              scale = 1.6;
              status = "enable";
            }
          ];
        }
        {
          profile.name = "home_office";
          profile.outputs = [
            {
              criteria = "LG Electronics LG ULTRAWIDE 0x0001BB08";
              position = "0,0";
              mode = "2560x1080@60Hz";
            }
            {
              criteria = "Dell Inc. DELL P2422H 1P9MYK3";
              position = "320,-1080";
              mode = "1920x1080@60Hz";
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        }
      ]
      ++ (lib.imap0 (index: value: {
          profile.name = "disable_laptop_screen_${builtins.toString index}";
          profile.outputs = [
            {
              criteria = value;
              position = "0,0";
              mode = "2560x1080@60Hz";
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        }) [
          "LG Electronics LG ULTRAWIDE 0x0007F992"
          "LG Electronics LG ULTRAWIDE 0x01010101"
          "LG Electronics LG ULTRAWIDE 0x0003D937"
        ]);
  };
}
