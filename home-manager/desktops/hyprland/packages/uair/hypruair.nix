{
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float, class:zenity, title:🍅"
    "move 100%-w-0.5% 1%, class:zenity, title:🍅"
    "noinitialfocus, class:zenity, title:🍅"
    "nofocus 1, class:zenity, title:^(🍅: .*)$"
    "pin, class:zenity, title:^(🍅: .*|checking in 🍅)$"
    "center, class:zenity, title:^(🍅: .*|checking in 🍅)$"
    "opacity 0.75 override 0.75 override, class:zenity, title:^(🍅: .*|checking in 🍅)$"
  ];

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
