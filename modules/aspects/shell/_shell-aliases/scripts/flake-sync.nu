# Pin the current repo's flake inputs to the revisions locked in the nix
# config flake, so both evaluate against the same nixpkgs (and store paths).

# The nix module that builds this script swaps in `myShell.flakePath`.
const CONFIG_FLAKE = ("~/nix/config" | path expand)

# A flake ref that pins exactly what a flake.lock node's `locked` describes.
def locked-ref [l: record] {
  match $l.type {
    "github" | "gitlab" | "sourcehut" => $"($l.type):($l.owner)/($l.repo)/($l.rev)"
    "tarball" | "file" => $"($l.type)+($l.url)"
    "git" => $"git+($l.url)?rev=($l.rev)"
    _ => null
  }
}

# What repo an input comes from, ignoring branch and revision.
def source-id [o: record] {
  if $o.type in ["github" "gitlab" "sourcehut"] {
    $"($o.type):($o.owner)/($o.repo)" | str lowercase
  } else {
    $o.url? | default "" | str lowercase
  }
}

# Root inputs of a lock file as {name, node}; inputs that `follows` another
# input are dropped, since they have no lock node of their own.
def root-inputs [lock: record] {
  $lock.nodes.root.inputs
  | transpose name node
  | where ($it.node | describe) == "string"
  | each {|i| $i | merge ($lock.nodes | get $i.node) }
}

# The flake repo containing the working directory, or null when there is
# none (or it is the config flake itself, which is always in sync).
def find-repo [] {
  let root = ^git rev-parse --show-toplevel | complete
  let repo = if $root.exit_code == 0 { $root.stdout | str trim } else { $env.PWD }
  if not ($repo | path join flake.nix | path exists) { return }
  if ($repo | path expand) == ($CONFIG_FLAKE | path expand) { return }
  $repo
}

# Inputs of `repo` whose lock differs from the config's, as
# {name, ref, ours, theirs}, where `ref` pins the config's revision.
def outdated [repo: string, names: list<string>] {
  let ours = root-inputs (open --raw ($repo | path join flake.lock) | from json)
  let theirs = root-inputs (open --raw ($CONFIG_FLAKE | path join flake.lock) | from json)
  for n in ($names | where $it not-in $ours.name) { print -e $"skip ($n): not an input of ($repo)" }

  $ours | each {|o|
    let t = $theirs | where name == $o.name | get 0?
    let wanted = if ($names | is-empty) {
      $t != null and ($o.name == "nixpkgs" or (source-id $o.original) == (source-id $t.original))
    } else {
      $o.name in $names
    }
    if not $wanted { return }
    if $t == null { print -e $"skip ($o.name): not an input of ($CONFIG_FLAKE)"; return }
    let ref = locked-ref $t.locked
    if $ref == null { print -e $"skip ($o.name): can't pin a ($t.locked.type) input"; return }
    if $o.locked == $t.locked { return }
    {name: $o.name, ref: $ref, ours: $o.locked, theirs: $t.locked}
  }
}

# Short revision and date of a lock node's `locked`, for messages.
def describe-lock [l: record] {
  let rev = $l.rev? | default ($l.narHash | str substring 7..14) | str substring 0..6
  $"($rev) \(($l.lastModified * 1_000_000_000 | into datetime | format date '%F'))"
}

# Sync this repo's nixpkgs, plus every other root input it shares with the
# config flake (same name and same source repo), to the config's lock.
# Pass input names to sync exactly those instead.
def main [...names: string] {
  let repo = find-repo
  if $repo == null {
    error make --unspanned {msg: "not in a flake repo (or in the config flake itself)"}
  }
  if not ($repo | path join flake.lock | path exists) { ^nix flake lock $repo }

  let stale = outdated $repo $names
  if ($stale | is-empty) {
    print "already in sync"
    return
  }
  ^nix flake lock $repo ...($stale | each {|s| [--override-input $s.name $s.ref] } | flatten)
}

# Report, on stderr, the inputs `flake-sync` would change, exiting 1 if
# there are any. Silent and successful outside a locked flake repo, so it
# can run unconditionally from a direnv hook.
def "main check" [...names: string] {
  let repo = find-repo
  if $repo == null or not ($repo | path join flake.lock | path exists) { return }

  let stale = outdated $repo $names
  if ($stale | is-empty) { return }
  for s in $stale {
    print -e $"flake-sync: ($s.name) is at (describe-lock $s.ours), config has (describe-lock $s.theirs)"
  }
  print -e "flake-sync: run `flake-sync` to match the config"
  exit 1
}
