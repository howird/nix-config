{
  stdenv,
  lib,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "compact_pager";
  version = "3.3";

  src = fetchFromGitHub {
    owner = "tilorenz";
    repo = pname;
    rev = "190b97e61f7c8f16572843d994460055a259b204";
    sha256 = "sha256-GehWXbjYFurB4Q7s8PebgWdcGEvqrpktviDf+K4LpnI=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/plasma/plasmoids/com.github.tilorenz.compact_pager/
    cp -r package/* $out/share/plasma/plasmoids/com.github.tilorenz.compact_pager/

    runHook postInstall
  '';

  meta = with lib; {
    description = "A compact pager (virtual desktop switcher) for the KDE Plasma desktop";
    homepage = "https://github.com/tilorenz/compact_pager";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
