{config, ...}: {
  programs.waybar.settings.mainBar = with config.lib.stylix.colors; {
    position = "bottom";
    layer = "top";
    height = 28;
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    modules-left = [
      "custom/launcher"
      "hyprland/workspaces"
    ];
    modules-center = [
      "custom/uair"
      "clock"
    ];
    modules-right = [
      "tray"
      "cpu"
      "disk"
      "pulseaudio"
      "battery"
      "custom/notification"
    ];
    clock = {
      calendar = {
        format = {
          today = "<span color='#98971A'><b>{}</b></span>";
        };
      };
      format = "  {:%I:%M %p}";
      tooltip = "true";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "  {:%b %d}";
    };
    "hyprland/workspaces" = {
      active-only = false;
      format = "{icon}";
      on-click = "activate";
      show-special = true;
      format-icons.sort-by-number = true;
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
      };
    };
    cpu = {
      format = "<span foreground='#${green}'> </span> {usage}%";
      format-alt = "<span foreground='#${green}'> </span> {avg_frequency} GHz";
      interval = 2;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] alacritty --override font_size=14 --title float_alacritty btop'";
    };
    memory = {
      format = "<span foreground='#${cyan}'>󰟜 </span>{}%";
      format-alt = "<span foreground='#${cyan}'>󰟜 </span>{used} GiB"; # 
      interval = 2;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] alacritty --override font_size=14 --title float_alacritty btop'";
    };
    disk = {
      # path = "/";
      format = "<span foreground='#${orange}'>󰋊 </span>{percentage_used}%";
      interval = 60;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 650] alacritty --override font_size=14 --title float_alacritty btop'";
    };
    network = {
      format-wifi = "<span foreground='#${magenta}'> </span> {signalStrength}%";
      format-ethernet = "<span foreground='#${magenta}'>󰀂 </span>";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "<span foreground='#${magenta}'>󰖪 </span>";
    };
    tray = {
      icon-size = 20;
      spacing = 8;
    };
    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "<span foreground='#${blue}'> </span> {volume}%";
      format-icons = {
        default = ["<span foreground='#${blue}'> </span>"];
      };
      scroll-step = 2;
      on-click = "pavucontrol";
    };
    battery = {
      format = "<span foreground='#${yellow}'>{icon}</span> {capacity}%";
      format-icons = [
        " "
        " "
        " "
        " "
        " "
      ];
      format-charging = "<span foreground='#${yellow}'> </span>{capacity}%";
      format-full = "<span foreground='#${yellow}'> </span>{capacity}%";
      format-warning = "<span foreground='#${yellow}'> </span>{capacity}%";
      interval = 5;
      states = {
        warning = 20;
      };
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time}";
    };
    "custom/launcher" = {
      format = "";
      on-click = "rofi -show drun";
    };
    "custom/notification" = {
      tooltip = false;
      format = "{icon} ";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>  <span foreground='#${red}'></span>";
        none = "  <span foreground='#${red}'></span>";
        dnd-notification = "<span foreground='red'><sup></sup></span>  <span foreground='#${red}'></span>";
        dnd-none = "  <span foreground='#${red}'></span>";
        inhibited-notification = "<span foreground='red'><sup></sup></span>  <span foreground='#${red}'></span>";
        inhibited-none = "  <span foreground='#${red}'></span>";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>  <span foreground='#${red}'></span>";
        dnd-inhibited-none = "  <span foreground='#${red}'></span>";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };
  };
}
