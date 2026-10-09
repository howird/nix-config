# The .desktop counterpart of lib.getExe: `desktopEntry pkg "foo.desktop"`
# gives { name = "foo.desktop"; check = <drv>; }, where the check fails to
# build unless pkg really ships share/applications/foo.desktop. Feed the
# checks to home.checks so a typo or an upstream rename breaks the build
# instead of silently breaking "open with".
pkgs: pkg: name: {
  inherit name;
  check = pkgs.runCommandLocal "desktop-entry-${name}" {} ''
    if [ ! -e ${pkg}/share/applications/${name} ]; then
      echo "${pkg.name} has no share/applications/${name}" >&2
      exit 1
    fi
    touch $out
  '';
}
