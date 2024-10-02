{
  stdenv,
  lib,
  fetchFromGitLab,
}:
stdenv.mkDerivation rec {
  pname = "commonality";
  version = "09.30.24";

  src = fetchFromGitLab {
    domain = "opencode.net";
    owner = "phob1an";
    repo = pname;
    rev = "f968a088e07498e9ca427ff13e9022202d121511";
    sha256 = "sha256-Xc9cZPB8RcT62b5V7R9ZqyASDXLK8SWbneTjyPkvVHs=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/{plasma/desktoptheme,plasma/look-and-feel,aurorae/themes,color-schemes}
    cp -R desktoptheme/commonality/ $out/share/plasma/desktoptheme
    cp desktoptheme/commonality/colors~ $out/share/color-schemes/Commonality.colors
    cp -R look-and-feel/org.magpie.comm.desktop/ $out/share/plasma/look-and-feel
    cp -R themes/Commonality/ $out/share/aurorae/themes
    cp -R sddm/ $out/share
    cp -R icons/ $out/share
    cp -R wallpapers/ $out/share

    runHook postInstall
  '';

  meta = with lib; {
    description = "KDE Plasma 6 Theme. Commonality brings the style of CDE to the Plasma desktop.";
    homepage = "https://www.pling.com/p/1459520/";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
