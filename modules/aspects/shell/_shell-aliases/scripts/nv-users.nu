# List GPU compute processes with their owner, uptime, CPU% and state.
def main [] {
  if (which nvidia-smi | is-empty) {
    error make --unspanned {msg: "nvidia-smi is not installed or not in PATH"}
  }
  let smi = ^nvidia-smi --query-compute-apps=pid,used_gpu_memory,gpu_bus_id --format=csv,noheader,nounits | complete
  if $smi.exit_code != 0 {
    error make --unspanned {msg: $"nvidia-smi failed, is the driver loaded?\n($smi.stderr)"}
  }
  let apps = $smi.stdout | from csv --noheaders --trim all | rename pid vram_mib bus_id
  if ($apps | is-empty) {
    print "No active GPU compute tasks found."
    return
  }

  # ps exits non-zero when some pids have already ended; keep what it found.
  let procs = ^ps -o pid=,user=,etime=,pcpu=,state= -p ($apps.pid | str join ",") | complete | get stdout
    | parse -r '\s*(?<pid>\d+)\s+(?<user>\S+)\s+(?<uptime>\S+)\s+(?<cpu>\S+)\s+(?<state>\S+)'
    | update pid { into int }

  $apps | each {|app|
    let p = $procs | where pid == $app.pid | get 0? | default {user: "(ended)"}
    {
      pid: $app.pid
      user: $p.user
      bus_id: $app.bus_id
      vram_mib: $app.vram_mib
      uptime: ($p.uptime? | default "N/A")
      cpu: ($p.cpu? | default "N/A")
      state: (match ($p.state? | default "" | str substring 0..0) {
        "R" => "Running"
        "S" => "Sleeping"
        "D" => "Disk Sleep"
        "Z" => "Zombie"
        "T" => "Stopped/Traced"
        "I" => "Idle (Kernel)"
        _ => ($p.state? | default "N/A")
      })
    }
  }
}
