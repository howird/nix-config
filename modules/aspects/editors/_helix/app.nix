# `nix run .#hx` — this config's helix (settings, languages, themes, steel
# plugins) without installing it. The config is read from the store, so
# ~/.config/helix and ~/.local/share/steel are neither used nor touched. Handy
# for trying plugin/config changes before switching.
#
# It evaluates a throwaway home-manager config holding only the helix module,
# so it is the same on every system and independent of any host: no stylix,
# so the theme is helix.nix's default rather than a host's stylix theme.
{
  inputs,
  lib,
  system,
  module,
}: let
  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [inputs.helix-plugins.overlays.default];
    config.allowUnfree = true;
  };

  hm =
    (inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        module
        {
          programs.helix.enable = true;
          home = {
            username = "hx";
            homeDirectory = "/var/empty";
            stateVersion = "23.11";
          };
        }
      ];
    }).config;

  files = hm.home-files;
  helix = hm.programs.helix;

  # The xdg files, so language servers and formatters see the same settings
  # as on a host, plus the helix.scm home-manager doesn't manage but steelix
  # requires.
  configDir = pkgs.runCommand "hx-config" {} ''
    mkdir -p $out/helix
    for f in ${files}/.config/*; do
      [ "''${f##*/}" = helix ] || ln -s "$f" $out/
    done
    for f in ${files}/.config/helix/*; do ln -s "$f" $out/helix/; done
    [ -e $out/helix/helix.scm ] || touch $out/helix/helix.scm
  '';
in
  pkgs.writeShellApplication {
    name = "hx";
    runtimeInputs = helix.extraPackages;
    # STEEL_HOME has to be writable (steelix writes its builtin `helix/*.scm`
    # modules there on startup), so it is a temp dir of links to the plugins.
    text = ''
      shopt -s nullglob
      steel_home=$(mktemp -d -t "hx-steel.XXXXXX")
      trap 'rm -rf "$steel_home"' EXIT
      mkdir -p "$steel_home/cogs"
      for f in ${files}/.local/share/steel/cogs/*; do ln -s "$f" "$steel_home/cogs/"; done
      if [ -e ${files}/.local/share/steel/native ]; then
        ln -s ${files}/.local/share/steel/native "$steel_home/native"
      fi

      XDG_CONFIG_HOME=${configDir} \
        HELIX_STEEL_CONFIG=${configDir}/helix \
        STEEL_HOME="$steel_home" \
        ${lib.getExe' helix.package "hx"} "$@"
    '';
  }
