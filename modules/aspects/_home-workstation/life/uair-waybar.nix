{
  programs.waybar.settings.mainBar = {
    "custom/uair" = {
      format = "i'm {}! 󱅻 ";
      on-click = "uairctl toggle";
      on-click-right = ''notify-send "$(uairctl fetch '🍅: {time} of {name} left, you got this!')"'';
      on-click-middle = "uairctl finish";
      tooltip = false;
      return-type = "json";
      interval = 2;
      exec-if = "which uairctl";
      exec = ''uairctl fetch '{\"text\":\"{name} for {total}\", \"class\":\"{name}\"}' '';
    };

    "custom/uair-time" = {
      format = "{icon} ";
      format-icons = [
        ""
        ""
        ""
        ""
        ""
        ""
      ];
      on-click = "uairctl toggle";
      on-click-right = ''notify-send "$(uairctl fetch '🍅: {time} of {name} left, you got this!')"'';
      on-click-middle = "start-day";
      tooltip = false;
      return-type = "json";
      interval = 1;
      exec-if = "which uairctl";
      exec = ''uairctl fetch '{\"class\":\"{state}\", \"percentage\":{percent}}' '';
    };
  };
}
