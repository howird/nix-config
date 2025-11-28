{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = lib.optional config.programs.niri.enable pkgs.hyprlock;
  xdg.configFile."hypr/hyprlock.conf".text = let
    mkRgba = c: a: let
      r = config.lib.stylix.colors."${c}-rgb-r";
      g = config.lib.stylix.colors."${c}-rgb-g";
      b = config.lib.stylix.colors."${c}-rgb-b";
    in "rgba(${r}, ${g}, ${b}, ${a})";

    text = mkRgba "base05";
    base = mkRgba "base00";
    surface2 = mkRgba "base04";
  in ''
    # BACKGROUND
    background {
      monitor =
      path = ${config.stylix.image}
      blur_passes = 2
      contrast = 0.8916
      brightness = 0.8172
      vibrancy = 0.1696
      vibrancy_darkness = 0.0
    }

    # GENERAL
    general {
      hide_cursor = true
      no_fade_in = false
      grace = 0
      disable_loading_bar = false
      ignore_empty_input = true
      fractional_scaling = 0
    }

    # Time
    label {
      monitor =
      text = cmd[update:1000] echo "$(date +"%I:%M %p")"
      color = ${text "0.9"}
      font_size = 150
      font_family = ${config.desktop.font.name} 800
      shadow_passes = 4
      position = 0, -180
      halign = center
      valign = top
    }

    # Day
    label {
      monitor =
      text = cmd[update:1000] echo "<i>~ $(date +"%A, %B %d") ~</i>"
      color = ${text "0.9"}
      font_size = 40
      font_family = ${config.desktop.font.name} 600
      shadow_passes = 3
      position = 0, -420
      halign = center
      valign = top
    }


    # USER-BOX
    shape {
      monitor =
      size = 360, 60
      color = ${base "0.33"}
      rounding = 25
      border_size = 0
      border_color = rgba(255, 255, 255, 0.0)
      rotate = 0

      position = 0, 310
      halign = center
      valign = bottom
    }

    # USER
    label {
      monitor =
      text =   $USER
      color = ${text "1.0"}
      font_size = 20
      font_family = ${config.desktop.font.name}
      position = 0, 322
      halign = center
      valign = bottom
    }

    # INPUT FIELD
    input-field {
      monitor =
      size = 360, 60
      outline_thickness = 0
      rounding = 25
      dots_size = 0.25 # Scale of input-field height, 0.2 - 0.8
      dots_spacing = 0.4 # Scale of dots' absolute size, 0.0 - 1.0
      dots_center = true
      outer_color = ${surface2 "0.2"}
      inner_color = ${surface2 "0.2"}
      color = ${base "0.9"}
      font_color = ${text "0.9"}
      font_size = 14
      font_family = ${config.desktop.font.name}
      fade_on_empty = false
      placeholder_text = <i><span foreground="#${config.lib.stylix.colors.withHashtag.base00}">Enter Password</span></i>
      hide_input = false
      position = 0, 230
      halign = center
      valign = bottom
    }
  '';
}
