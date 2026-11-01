# Prompt for a link and open it as a chromium app window. Whitespace
# (including newlines, e.g. from a URL wrapped by a terminal) is stripped
# before validation. The entry is pre-filled with the clipboard, and submitting
# it empty also falls back to the clipboard.

const title = "Open in Chromium app"

# remove whitespace
def squash []: string -> string { str replace --all --regex '\s' '' }

# Resolve a dotless host through ssh config aliases (e.g. Host thematrix ->
# HostName thematrix.<tailnet>.ts.net); other hosts pass through.
def expand-ssh-alias []: string -> string {
  let host = $in
  if $host == "" or ($host | str contains ".") or ($host | str starts-with "[") or $host == "localhost" {
    return $host
  }
  ssh -G -- $host | complete | get stdout | lines
  | parse "{key} {value}" | where key == hostname | get value.0? | default $host
}

# Strip whitespace, expand ssh host aliases, and add a scheme to bare hosts
# (http:// for loopback and tailnet hosts, https:// otherwise). Errors on an
# invalid link.
def normalize []: string -> string {
  let raw = $in | squash
  let has_scheme = $raw =~ '^[A-Za-z][A-Za-z0-9+.-]*://'
  let parts = if $has_scheme { $raw } else { $"http://($raw)" } | url parse
  if $parts.scheme == file { return $raw }
  let host = $parts.host | expand-ssh-alias
  let local = $host == localhost or ($host | str starts-with "127.") or $host == "[::1]" or ($host | str ends-with ".ts.net")
  let scheme = if $has_scheme { $parts.scheme } else if $local { "http" } else { "https" }
  # host needs a dot unless it's localhost or an IPv6 literal
  if $scheme not-in [http https] or not ($host == localhost or ($host | str starts-with "[") or ($host | str contains ".")) {
    error make {msg: $"not a valid link: ($raw)"}
  }
  $parts | update scheme $scheme | update host $host | url join
}

def error-box [text: string] {
  zenity --error $"--title=($title)" --no-markup $"--text=($text)" | complete | ignore
}

# Usage: open-webapp [prefill-text]
def main [prefill?: string] {
  # Pre-fill with the clipboard (selected, so typing replaces it) unless given
  # text. Whitespace is stripped so a wrapped link shows as one line.
  let clip = wl-paste --no-newline | complete | get stdout
  mut text = $prefill | default $clip | squash

  loop {
    let entry = (zenity --entry $"--title=($title)" --width=700
      "--text=Link to open:" $"--entry-text=($text)"
      --ok-label=Go --cancel-label=Cancel | complete)
    if $entry.exit_code != 0 { exit 0 }

    mut input = $entry.stdout | squash
    if $input == "" {
      $input = $clip | squash
      if $input == "" {
        error-box "No link given and the clipboard is empty."
        $text = ""
        continue
      }
    }

    let url = try { $input | normalize } catch { null }
    if $url != null { exec chromium $"--app=($url)" }

    error-box $"Not a valid link:\n\n($input)"
    $text = $input
  }
}
