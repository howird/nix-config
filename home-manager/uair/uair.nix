{
  xdg.configFile."uair/uair.toml".text = let
    session-fmt = id: name: t: autostart: cmd: ''

      [[sessions]]
      id = "${id}"
      name = "${name}"
      duration = "${t}m"
      time_format = "%M:%S"
      command = "${cmd}"
      autostart = ${autostart}
    '';
    work-session = n: (session-fmt "work${n}" "!work ${n}!" "25" "false" "uairzen ': 🧠 work ${n} done, rest time 🌅'");
    rest-session = n: (session-fmt "rest${n}" "~rest ${n}~" "5" "true" "notify-send '🍅: 🌅 rest ${n} done! work time 🧠'");
  in
    ''
      loop_on_end = true

      [defaults]
      format = "{percent}\n#{time} left in {name}\n"
      paused_state_text = "paused"
      resumed_state_text = "resumed"
    ''
    + (session-fmt "med-prep" "~meditation prep~" "3" "true" "uairzen ': 🌅 time to start your 🧘'")
    + (session-fmt "med" "~meditation~" "15" "true" "notify-send '🍅: 🧘 done, are you ready to start?'")
    + (work-session "1")
    + (rest-session "1")
    + (work-session "2")
    + (rest-session "2")
    + (work-session "3")
    + (rest-session "3")
    + (session-fmt "work4" "!WORK 4!" "25" "false" "uairzen ': you did it! time to rest 🌅 and realign 🧘'");
}
