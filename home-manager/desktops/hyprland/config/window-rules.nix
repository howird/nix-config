{
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "pin, class:rofi"

    "float, class:mpv"
    "float, class:com.github.finefindus.eyedropper"
    "center, class:mpv"
    "size 1200 725, class:mpv"
    "idleinhibit focus, class:mpv"

    "float, title:^(.*Transmission.*)$"
    "float, title:^(.*Volume Control.*)$"
    "float,title:^(.*Sharing Indicator.*)$"
    "float,class:zen, title:^(Extension:.*)$"
    "move 0 0,title:^(.*Firefox — Sharing Indicator.*)$"

    "float, title:^(.*Picture-in-Picture.*)$"
    "float, class:^(xdg-desktop-portal-.*)$"
    "opacity 1.0 override 1.0 override, title:^(.*Picture-in-Picture.*)$"
    "pin, title:^(.*Picture-in-Picture.*)$"

    "opacity 0.8 override 0.6 override, class:spotify"
    "float, class:spotify"
    "opacity 1.0 override 1.0 override, class:mpv"
    "opacity 1.0 override 1.0 override, class:zen"
    "opacity 1.0 override 1.0 override, class:^(org\.gnome\.Papers)$"

    "float, class:Zotero, title:^(.*Progress.*)$"
    "opacity 0.5, class:Zotero, title:^(.*Progress.*)$"
    "float, class:Zotero, title:^(Zotero Settings)$"
    "float, class:Zotero, title:^(Plugins Manager.*)$"
    "float, class:^(.*qBittorrent.*)$, title:^(?!qBittorrent).+$" # not working

    "idleinhibit focus, class:mpv"
    "idleinhibit focus, class:firefox, title:Library"
    "idleinhibit focus, class:^(.*suyu.*)$"
    "idleinhibit focus, class:vlc"
    "idleinhibit focus, class:spotify"
    "idleinhibit fullscreen, fullscreen:0"

    "center, class:^(org.gnome.FileRoller)$"
    "float, class:^(org.gnome.FileRoller)$"
    "size 850 500, class:^(org.gnome.FileRoller)$"
    "size 850 500, title:^(.*File Upload.*)$"

    "float,class:^(nm-.*)$"
    "float,class:^(.*blueman.*)$"
    "float,class:^(.*pavucontrol.*)$"
    "size 850 450,class:^(.*pavucontrol.*)"
    "float,class:^(.*SoundWireServer.*)$"
    "float,class:^(.*.sameboy-wrapped.*)$"
    "float,class:^(.*file_progress.*)$"
    "float,class:^(.*confirm.*)$"
    "float,class:^(.*dialog.*)$"
    "float,class:^(.*download.*)$"
    "float,class:^(.*notification.*)$"
    "float,class:^(.*error.*)$"
    "float,class:^(.*confirmreset.*)$"
    "float,title:^(.*Open File.*)$"
    "float,title:^(.*File Upload.*)$"
    "float,title:^(.*branchdialog.*)$"
    "float,title:^(.*Confirm to replace files.*)$"
    "float,title:^(.*File Operation Progress.*)$"

    "opacity 0.0 override, class:xwaylandvideobridge"
    "noanim, class:xwaylandvideobridge"
    "noinitialfocus, class:xwaylandvideobridge"
    "maxsize 1 1, class:xwaylandvideobridge"
    "noblur, class:xwaylandvideobridge"

    # uair
    "float, class:zenity, title:🍅"
    "move 100%-w-0.5% 1%, class:zenity, title:🍅"
    "move 75%-w-0.5% 5%, class:zenity, title:^(what to do 🍅)$"
    "noinitialfocus, class:zenity, title:^(🍅|what to do 🍅)$"
    "nofocus 1, class:zenity, title:^(🍅: .*)$"
    "pin, class:zenity, title:^(🍅: .*|checking in 🍅|what to do 🍅)$"
    "center, class:zenity, title:^(🍅: .*|checking in 🍅)$"
    "opacity 0.75 override 0.75 override, class:zenity, title:^(🍅: .*|checking in 🍅|what to do 🍅)$"
  ];
}
