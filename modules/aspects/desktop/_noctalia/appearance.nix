{
  programs.noctalia.settings = {
    backdrop = {
      # Drawn behind niri's overview; see the layer-rule in ./niri.nix.
      enabled = true;
      blur_intensity = 0.5;
      tint_intensity = 0.3;
    };

    osd.position = "top_center";

    shell = {
      panel = {
        clipboard_placement = "floating";
        launcher_placement = "floating";
        transparency_mode = "soft";
      };

      screen_corners.enabled = false;
    };

    # Templates write themed configs out to other apps' config dirs, which
    # stylix owns here - and they would be clobbered on every rebuild anyway.
    theme.templates = {
      enable_builtin_templates = false;
      enable_community_templates = false;
    };

    wallpaper = {
      enabled = true;
      fill_mode = "crop";
      automation.enabled = false;
    };
  };
}
