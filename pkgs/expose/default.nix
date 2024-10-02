{
  stdenv,
  lib,
  fetchFromGitLab,
}:
stdenv.mkDerivation rec {
  pname = "expose";
  version = "11.2.21";

  src = fetchFromGitLab {
    domain = "opencode.net";
    owner = "phob1an";
    repo = pname;
    rev = "8fd7c6aef28fe58e7c5028993305602121ebb560";
    sha256 = "sha256-Y3WKBPgRqc48Tixm6n2gV570HEKzlXvHrT+mRkyNW2g=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/{plasma/desktoptheme,plasma/look-and-feel,aurorae/themes}
    cp -R desktoptheme/expose/ $out/share/plasma/desktoptheme
    cp -R look-and-feel/org.magpie.expose.desktop $out/share/plasma/look-and-feel
    cp -R themes/expose/ $out/share/aurorae/themes
    cp -R sddm/ $out/share
    cp -R wallpapers/ $out/share

    runHook postInstall
  '';

  meta = with lib; {
    description = "KDE Plasma 6 Theme. Remembering XP.";
    homepage = "https://store.kde.org/p/2136378";
    license = licenses.gpl3;
    # maintainers = [ maintainers.ymarkus ];
    platforms = platforms.all;
  };
}
