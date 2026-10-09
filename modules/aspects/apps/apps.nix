{den, ...}: {
  # GUI apps, grouped by what they're for. Each category filters out what
  # doesn't build on the current platform.
  den.aspects.apps.includes = [
    den.aspects.comms
    den.aspects.productivity
    den.aspects.reading
    den.aspects.media
    den.aspects.tools
  ];
}
