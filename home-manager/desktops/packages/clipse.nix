{config, ...}: {
  services.clipse = {
    enable = config.programs.hyprland.enable || config.programs.niri.enable;
    allowDuplicates = false;
    historySize = 150;
    imageDisplay.type = "sixel";
    systemdTarget = "hyprland-session.target";
    theme = with config.lib.stylix.colors.withHashtag; {
      useCustomTheme = true;
      DimmedDesc = base07;
      DimmedTitle = base07;
      FilteredMatch = base08;
      NormalTitle = base08;
      NormalDesc = base0B;
      SelectedDesc = base0D;
      SelectedTitle = base0D;
      SelectedBorder = base0D;
      SelectedDescBorder = base0D;
      TitleFore = base05;
      Titleback = base01;
      StatusMsg = base0E;
      PinIndicatorColor = base0F;
    };
  };
}
