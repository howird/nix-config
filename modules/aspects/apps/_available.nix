# Keeps the packages that build on this platform, so a category lists apps
# once instead of being split per platform.
pkgs: let
  inherit (pkgs) lib stdenv;
  # meta.platforms claims darwin, but the build pulls in something that
  # doesn't: chromium (percollate), webkitgtk (foliate).
  darwinDenylist = ["percollate" "foliate"];
in
  builtins.filter (p:
    lib.meta.availableOn stdenv.hostPlatform p
    && !(p.meta.broken or false)
    && !(stdenv.hostPlatform.isDarwin && builtins.elem (lib.getName p) darwinDenylist))
