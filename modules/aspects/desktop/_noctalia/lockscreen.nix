{
  config,
  lib,
  pkgs,
  ...
}: let
  outputs =
    ["eDP-1" "HDMI-A-1" "HDMI-A-2"]
    ++ map (n: "DP-${toString n}") (lib.range 1 13);
  # cx/cy are absolute logical pixels, but noctalia rescales them by
  # (output size / placement size) on load. A 1x1 placement turns them into
  # fractions of the screen.
  at = output: cx: cy: {
    inherit output cx cy;
    placement_width = 1.0;
    placement_height = 1.0;
  };

  textColor = "#0e7b47";

  clock = output: cx: cy: box_width: box_height: format:
    at output cx cy
    // {
      type = "clock";
      inherit box_width box_height;
      settings = {
        inherit format;
        font_family = "Aleo";
        color = textColor;
        background = false;
        shadow = false;
      };
    };

  widgetsFor = output: {
    "lockscreen-login-box@${output}" =
      at output 0.5 0.88
      // {
        type = "login_box";
        settings = {
          layout = "regular";
          show_session_buttons = true;
          show_weather = false;
          show_media = false;
          show_unlock_hint = false;
          background_opacity = 0.0;
        };
      };
    "lockscreen-time@${output}" = clock output 0.5 0.13 500.0 180.0 "{:%-I:%M %p}";
    "lockscreen-date@${output}" = clock output 0.5 0.22 420.0 50.0 "{:%A, %B %-d}";
    "lockscreen-weather@${output}" =
      at output 0.52 0.29
      // {
        type = "weather";
        settings = {
          color = textColor;
          background = false;
          shadow = false;
        };
      };
  };
in {
  programs.noctalia.settings = {
    idle = {
      pre_action_fade_seconds = 2.0;
      behavior = {
        lock = {
          enabled = true;
          action = "lock";
          timeout = 600;
        };
        screen-off = {
          enabled = true;
          action = "screen_off";
          timeout = 660;
        };
      };
    };

    lockscreen = {
      enabled = true;
      blurred_desktop = false;
      blur_intensity = 0.15;
      tint_intensity = 0.15;
      transition = ["honeycomb"];
      transition_duration = 777;
    };

    lockscreen_widgets = {
      enabled = true;
      widget = lib.mergeAttrsList (map widgetsFor outputs);
    };
  };

  # noctalia copies the whole lockscreen layout into settings.toml (the GUI
  # overrides) on first load, and that copy beats config.toml from then on.
  # Drop it on every switch so edits here take effect; noctalia rebuilds it
  # from config.toml as soon as the file changes.
  home.activation.noctaliaResetLockscreenWidgets = lib.hm.dag.entryAfter ["writeBoundary"] ''
    settings="${config.xdg.stateHome}/noctalia/settings.toml"
    if [ -f "$settings" ]; then
      tmp="$(mktemp)"
      ${pkgs.gawk}/bin/awk '
        /^[[:space:]]*\[/ {
          s = $0
          sub(/^[[:space:]]*\[+/, "", s)
          skip = (s ~ /^lockscreen_widgets[].]/)
        }
        !skip
      ' "$settings" > "$tmp"
      # cp rather than mv: noctalia watches the file, and this keeps its mode
      if ! cmp -s "$settings" "$tmp"; then
        run cp "$tmp" "$settings"
      fi
      rm -f "$tmp"
    fi
  '';
}
