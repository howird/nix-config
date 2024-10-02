{
  stdenv,
  lib,
  fetchFromGitLab,
}:
stdenv.mkDerivation rec {
  pname = "reactionary";
  version = "09.30.24";

  src = fetchFromGitLab {
    domain = "opencode.net";
    owner = "phob1an";
    repo = pname;
    rev = "bf5af99404c19ddcca935510bd783277d60b5753";
    sha256 = "sha256-27wWlRCBSiDtXvhXDCNdxiRN400pwzCO0S+Cjla/RCg=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/{plasma/desktoptheme,plasma/look-and-feel,aurorae/themes,color-schemes}
    cp -R desktoptheme/reactionary/ $out/share/plasma/desktoptheme
    cp PLUS/*.colors $out/share/color-schemes
    cp -R look-and-feel/org.magpie.react.desktop/ $out/share/plasma/look-and-feel
    cp -R themes/reactionary/ $out/share/aurorae/themes
    cp -R sddm/ $out/share
    cp -R icons/ $out/share
    cp -R wallpapers/ $out/share

    runHook postInstall
  '';

  meta = with lib; {
    description = "KDE Plasma 6 Theme. Just a bit of fun recreating the look and feel of ReactOS.";
    homepage = "https://store.kde.org/p/2138468";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
