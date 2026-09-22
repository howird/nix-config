{
  config,
  lib,
  ...
}: {
  # Guard lives on the binds attrset, not in `assertions`: assertions are only
  # collected at the very end of evaluation, and by then niri's own
  # "defined multiple times" error for Mod+Return/Mod+N has already fired.
  # Forcing it here means the shell clash is reported as a shell clash.
  programs.niri.settings =
    lib.throwIf config.programs.waybar.enable ''
      den.aspects.noctalia and den.aspects.bundles.waybar-shell are mutually
      exclusive: both are complete desktop shells, and both bind Mod+Return,
      Mod+N and the media keys. Include one or the other in the user's aspect
      list, not both.
    '' (let
      # `noctalia msg <cmd>` as a niri spawn action.
      msg = cmd: {spawn = ["noctalia" "msg"] ++ cmd;};

      # Media and brightness keys have to keep working on the lock screen, and
      # auto-repeat while held.
      key = cmd: {
        action = msg cmd;
        allow-when-locked = true;
      };
      ramp = cmd: (key cmd) // {repeat = true;};
    in {
      # Spawned by niri rather than a systemd user unit so apps started from the
      # launcher survive a shell restart (programs.noctalia.systemd.enable).
      spawn-at-startup = [
        {argv = ["noctalia"];}
      ];

      binds = {
        # The keys the waybar stack used, pointed at noctalia's panels.
        "Mod+Return".action = msg ["panel-toggle" "launcher"];
        "Mod+N".action = msg ["panel-toggle" "control-center"];
        "Super+Shift+Q".action = msg ["session" "lock"];
        "Mod+V".action = msg ["panel-toggle" "clipboard"];

        "Mod+Shift+N".action = msg ["notification-dnd-toggle"];
        "Mod+Shift+W".action = msg ["panel-toggle" "wallpaper"];
        "Mod+Ctrl+Comma".action = msg ["settings-toggle"];
        "Alt+Tab".action = msg ["window-switcher"];

        # niri's built-in screenshot has no annotator; noctalia's does.
        "Mod+S".action = msg ["screenshot-region"];
        "Mod+Shift+S".action = msg ["screenshot-fullscreen" "pick"];

        # Replaces the swayosd-client binds.
        "XF86AudioRaiseVolume" = ramp ["volume-up"];
        "XF86AudioLowerVolume" = ramp ["volume-down"];
        "XF86AudioMute" = key ["volume-mute"];
        "XF86AudioMicMute" = key ["mic-mute"];
        "XF86MonBrightnessUp" = ramp ["brightness-up"];
        "XF86MonBrightnessDown" = ramp ["brightness-down"];

        # Routed through the shell rather than playerctl, so they raise an OSD
        # and follow noctalia's own active-player selection.
        "XF86AudioPlay" = key ["media" "toggle"];
        "XF86AudioNext" = key ["media" "next"];
        "XF86AudioPrev" = key ["media" "previous"];
        "XF86AudioStop" = key ["media" "stop"];
      };

      window-rules = [
        {
          matches = [{app-id = "^dev\\.noctalia\\.Noctalia$";}];
          open-floating = true;
          default-column-width.fixed = 1080;
          default-window-height.fixed = 920;
        }
      ];

      layer-rules = [
        # Blurred, tinted copy of the wallpaper, shown behind niri's overview
        # (noctalia's `[backdrop]`, enabled in ./settings.nix).
        {
          matches = [{namespace = "^noctalia-backdrop";}];
          place-within-backdrop = true;
        }
        {
          matches = [{namespace = "^noctalia-notification$";}];
          block-out-from = "screencast";
        }
      ];

      # Lets noctalia raise the app behind a notification action, and focus
      # windows picked from its launcher and window switcher.
      debug.honor-xdg-activation-with-invalid-serial = [];
    });
}
