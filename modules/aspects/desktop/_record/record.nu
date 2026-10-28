# Record the screen with wf-recorder. Running it again with any mode while a
# recording is going (or with `stop`) ends it and asks where to save.
const tmp = {
  mp4: "/tmp/recording.mp4"
  palette: "/tmp/palette.png"
  gif_raw: "/tmp/recording_unoptimized.gif"
  gif: "/tmp/gif_result"
  gif_flag: "/tmp/recording_gif"
}

def notify [title: string, body: string] {
  ^notify-send -a Recorder $title $body -t 5000
}

def recorder-pids [] { ps | where name == "wf-recorder" | get pid }

def clean [] { rm -f ...($tmp | values) }

def --wrapped capture [...extra: string] {
  notify "Starting Recording" "Your screen is being recorded"
  ^timeout 600 wf-recorder -F format=rgb24 -x rgb24 -p qp=0 -p crf=0 -p preset=slow -c libx264rgb ...$extra -f $tmp.mp4
}

def capture-area [] {
  let geometry = ^slurp | complete
  if $geometry.exit_code == 0 { capture -g ($geometry.stdout | str trim) }
}

def to-gif [] {
  ^ffmpeg -i $tmp.mp4 -filter_complex "[0:v] palettegen" $tmp.palette
  ^ffmpeg -i $tmp.mp4 -i $tmp.palette -filter_complex "[0:v] fps=10,scale=1400:-1,setpts=0.5*PTS [new];[new][1:v] paletteuse" $tmp.gif_raw
  ^gifsicle -O3 --lossy=100 -i $tmp.gif_raw -o $tmp.gif
}

def stop [out_dir: string] {
  kill ...(recorder-pids)

  let gif = $tmp.gif_flag | path exists
  let ext = if $gif { "gif" } else { "mp4" }
  let result = if $gif {
    notify "Stopped Recording" "Starting GIF conversion phase..."
    to-gif
    $tmp.gif
  } else {
    $tmp.mp4
  }

  let picked = ^zenity --file-selection --save $"--file-filter=*.($ext)" $"--filename=($out_dir)/.($ext)" | complete | get stdout | str trim
  let dest = if ($picked | is-empty) {
    $out_dir | path join $"(date now | format date '%Y-%m-%d_%H-%M-%S').($ext)"
  } else {
    $picked
  }
  let dest = if ($dest | str ends-with $".($ext)") { $dest } else { $"($dest).($ext)" }

  mv -f $result $dest
  open --raw $dest | ^wl-copy -t (if $gif { "image/png" } else { "video/mp4" })
  if $gif {
    notify "GIF conversion completed" $"GIF saved to ($dest)"
  } else {
    notify "Stopped Recording" $"Video saved to ($dest)"
  }
  clean
}

def main [mode: string] {
  let out_dir = $env.HOME | path join Videos
  mkdir $out_dir

  if (recorder-pids | is-not-empty) {
    stop $out_dir
    return
  }

  match $mode {
    "screen" => { clean; capture }
    "area" => { clean; capture-area }
    "gif" => { clean; touch $tmp.gif_flag; capture-area }
    "stop" => {}
    _ => { error make --unspanned {msg: "usage: record <screen|area|gif|stop>"} }
  }
}
