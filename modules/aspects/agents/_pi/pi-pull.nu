# Copy a pi session from another host over ssh and fork it into a local
# directory as a new session.
#
#   pi-pull <host>:<session-file> [dir]
#
# Get the remote session file from `/session` or `$PI_SESSION_FILE` there.
def main [
  source: string      # remote session file as host:path
  dir: path = "."     # directory to attach the forked session to
] {
  let dir = ($dir | path expand)
  if not ($dir | path exists) { error make {msg: $"directory does not exist: ($dir)"} }

  let tmp = (^mktemp -d | str trim)
  let file = ($tmp | path join "session.jsonl")
  try {
    ^scp $source $file
  } catch {
    rm -rf $tmp
    error make {msg: $"could not copy ($source)"}
  }

  cd $dir
  try { ^pi --fork $file }
  rm -rf $tmp
}
