{
  programs.waybar.settings.mainBar."custom/uair" = {
    format = "{} {icon}";
    format-icons = [
      " "
      " "
      " "
      " "
      " "
      " "
    ];
    tooltip = false;
    return-type = "json";
    interval = 1;
    on-click = "uairctl toggle";
    on-click-right = "uairzen";
    on-click-middle = "uairctl finish";
    exec-if = "which uairctl";
    exec = ''uairctl fetch '{\"text\":\"{name} {time}\",\"class\":\"{state}\",\"percentage\":{percent}}' '';
  };
}
