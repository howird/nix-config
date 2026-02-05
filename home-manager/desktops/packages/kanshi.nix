{
  config,
  lib,
  ...
}: {
  services.kanshi = {
    inherit (config.programs.niri) enable;
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
      ++ (let
        imapAttrs0 = f: attrs: lib.imap0 (i: kv: f i kv.name kv.value) (lib.attrsToList attrs);
      in
        imapAttrs0 (index: criteria: mode: {
          profile.name = "disable_laptop_screen_${toString index}";
          profile.outputs = [
            {
              inherit criteria mode;
              position = "0,0";
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        }) {
          "LG Electronics LG ULTRAWIDE 0x0007F992" = "2560x1080@60Hz";
          "LG Electronics LG ULTRAWIDE 0x01010101" = "2560x1080@60Hz";
          "LG Electronics LG ULTRAWIDE 0x0003D937" = "2560x1080@60Hz";
          "Acer Technologies G236HL LVNAA0052482" = "1920x1080@60Hz";
        });
  };
}
