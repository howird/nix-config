{config, ...}: {
  programs.waybar.settings.mainBar = with config.lib.stylix.colors.withHashtag; {
    position = "bottom";
    layer = "top";
    height = 28;
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;

    modules-left = [
      "niri/workspaces"
    ];
    modules-center = [
      "custom/uair-time"
      "clock"
      "custom/uair"
    ];
    modules-right = [
      "tray"
      "pulseaudio"
      "battery"
      "custom/notification"
    ];
    clock = {
      calendar = {
        format = {
          today = "<span color='${green}'><b>{}</b></span>";
        };
      };
      format = "   it's {:%I:%M%p on a %A}, ";
      tooltip = "true";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      format-alt = "  {:%F, w%U/52, %R} ";
      interval = 1;
    };
    "niri/workspaces" = {
      format = "{icon}";
      format-icons = {
        default = "󰹟 ";
      };
    };
    "custom/notification" = {
      tooltip = false;
      format = "{icon} ";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span> <span foreground='${red}'></span>";
        none = " <span foreground='${red}'></span>";
        dnd-notification = "<span foreground='red'><sup></sup></span> <span foreground='${red}'></span>";
        dnd-none = " <span foreground='${red}'></span>";
        inhibited-notification = "<span foreground='red'><sup></sup></span> <span foreground='${red}'></span>";
        inhibited-none = " <span foreground='${red}'></span>";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span> <span foreground='${red}'></span>";
        dnd-inhibited-none = " <span foreground='${red}'></span>";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };

    cpu = {
      format = "<span foreground='${green}'> </span> {usage}%";
      format-alt = "<span foreground='${green}'> </span> {avg_frequency} GHz";
      interval = 2;
    };
    memory = {
      format = "<span foreground='${cyan}'>󰟜 </span>{}%";
      format-alt = "<span foreground='${cyan}'>󰟜 </span>{used} GiB"; # 
      interval = 2;
    };
    disk = {
      # path = "/";
      format = "<span foreground='${orange}'>󰋊 </span>{percentage_used}%";
      interval = 60;
    };
    network = {
      format-wifi = "<span foreground='${magenta}'> </span> {signalStrength}%";
      format-ethernet = "<span foreground='${magenta}'>󰀂 </span>";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "<span foreground='${magenta}'>󰖪 </span>";
    };
    tray = {
      icon-size = 16;
      spacing = 8;
    };
    pulseaudio = {
      format = "{icon}  {volume}%";
      format-muted = "<span foreground='${red}'> </span>";
      format-icons = [
        "<span foreground='${yellow}'> </span>"
        "<span foreground='${orange}'> </span>"
        "<span foreground='${green}'> </span>"
        "<span foreground='${blue}'> </span>"
      ];
      scroll-step = 2;
      on-click = "pavucontrol";
    };
    battery = {
      format = "<span foreground='${yellow}'>{icon}</span>   {capacity}%";
      format-icons = [
        " "
        " "
        " "
        " "
        " "
      ];
      format-charging = "<span foreground='${yellow}'></span>   {capacity}%";
      format-full = "<span foreground='${green}'></span>   {capacity}%";
      format-warning = "<span foreground='${red}'></span>   {capacity}%";
      interval = 5;
      states = {
        warning = 20;
      };
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time} left";
    };
  };
}
