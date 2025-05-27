{pkgs, ...}: {
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float, class:zenity, title:pomo"
    "move 5 5, class:zenity, title:pomo"
    "noinitialfocus, class:zenity, title:pomo"
    "nofocus 1, class:zenity, title:^(pomo: .*)$"
    "pin, class:zenity, title:^(pomo: .*)$"
    "center, class:zenity, title:^(pomo: .*)$"
    "opacity 0.75 override 0.75 override, class:zenity, title:^(pomo: .*)$"
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
    on-click = "uairzen";
    on-click-right = "uairctl toggle";
    on-click-middle = "uairctl finish";
    exec-if = "which uairctl";
    exec = ''uairctl fetch '{\"text\":\"{name} {time}\",\"class\":\"{state}\",\"percentage\":{percent}}' '';
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "uairzen" ''
      uairctl listen | zenity \
        --progress \
        --title="pomo$1" \
        --percentage=0 \
        --auto-close \
        --no-cancel
    '')
    (writeShellScriptBin "start-day" ''
      uairctl jump pre-med && \
        (uairzen ': start your day off right by setting intentions 🌅 and aligning with them 🧘' > /dev/null &)
    '')
  ];
}
