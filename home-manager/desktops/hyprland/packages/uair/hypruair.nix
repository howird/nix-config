{pkgs, ...}: {
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float, class:zenity, title:🍅"
    "move 100%-w-1% 1%, class:zenity, title:🍅"
    "noinitialfocus, class:zenity, title:🍅"
    "nofocus 1, class:zenity, title:^(🍅: .*)$"
    "pin, class:zenity, title:^(🍅: .*)$"
    "center, class:zenity, title:^(🍅: .*)$"
    "opacity 0.75 override 0.75 override, class:zenity, title:^(🍅: .*)$"
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

  home.packages = with pkgs; [
    (writeShellScriptBin "uairzen" ''
      uairctl resume
      uairctl listen | zenity \
        --progress \
        --title="🍅$1" \
        --percentage=0 \
        --auto-close \
        --no-cancel &> /dev/null
    '')
    (writeShellScriptBin "start-day" ''
      uairctl jump med-prep
      uairzen ': start your day off right by setting intentions 🌅 and aligning with them 🧘' &
    '')
  ];
}
