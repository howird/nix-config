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
    pre-session = n: (
      session-fmt
      "pre-work${n}"
      "intention-setting"
      "1"
      "true"
      "notify-send '🍅: 🌅 rest done! time for WORK ${n} 🧠'"
    );
    work-session = n: (
      session-fmt
      "work${n}"
      "working"
      "25" "true"
      "uairzen ': 🧠 WORK ${n} done, rest time! DO NOT SCROLL! settle your mind with long-distance gaze, meditation, stretches, etc. 🌅'"
    );
    rest-session = n: (
      session-fmt
      "rest${n}"
      "resting"
      "5"
      "true"
      "uairzen ': 🌅 rest ${n} done! spend the next moment choosing what you want to accomplish next! 🧠'"
    );
  in
    builtins.foldl' (x: y: x + y) ''
      loop_on_end = true

      [defaults]
      format = "{percent}\n#{time} of {name} left.\n"
      paused_state_text = "paused"
      resumed_state_text = "resumed"
    '' [
      (pre-session "1")
      (work-session "1")
      (rest-session "1")
      (pre-session "2")
      (work-session "2")
      (rest-session "2")
      (pre-session "3")
      (work-session "3")
      (rest-session "3")
      (pre-session "4")
      (
        session-fmt
        "work4"
        "working"
        "25"
        "true"
        "uairzen ': you did it! time to rest 🌅 and realign 🧘'"
      )
      (
        session-fmt
        "med-prep"
        "settling-my-mind"
        "2"
        "true"
        "uairzen ': 🌅 time to start meditating 🧘, your goal is to sharpen 🔪 your intentions by settling your mind'"
      )
      (
        session-fmt
        "med"
        "meditating"
        "12"
        "true"
        "uairzen ': meditation 🧘 done. spend the next moment choosing what you want to accomplish next! 🧠'"
      )
    ];
}
